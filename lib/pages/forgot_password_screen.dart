import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isLoading = false;
  String? _errorMessage;
  
  // Validaciones de contraseña
  bool _hasLowercase = false;
  bool _hasSpecialChar = false;
  bool _hasMinLength = false;
  bool _hasNumber = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Verificar requisitos de la contraseña
  void _checkPasswordRequirements(String password) {
    setState(() {
      _hasLowercase = RegExp(r'[a-z]').hasMatch(password);
      _hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
      _hasMinLength = password.length >= 8;
      _hasNumber = RegExp(r'[0-9]').hasMatch(password);
    });
  }

  // Actualizar contraseña
  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Verificar que se cumplan todos los requisitos
    if (!(_hasLowercase && _hasSpecialChar && _hasMinLength && _hasNumber)) {
      setState(() {
        _errorMessage = 'La contraseña no cumple con todos los requisitos';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Obtener usuario actual
      User? user = FirebaseAuth.instance.currentUser;
      
      if (user != null) {
        // Actualizar contraseña
        await user.updatePassword(_newPasswordController.text);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Contraseña actualizada correctamente'),
              backgroundColor: Colors.green,
            ),
          );
          
          // Limpiar formulario
          _newPasswordController.clear();
          _confirmPasswordController.clear();
          _checkPasswordRequirements('');
        }
      }
    } on FirebaseAuthException catch (e) {
      String message;
      
      switch (e.code) {
        case 'requires-recent-login':
          message = 'Por seguridad, debes iniciar sesión nuevamente antes de cambiar tu contraseña';
          break;
        case 'weak-password':
          message = 'La contraseña es demasiado débil';
          break;
        default:
          message = e.message ?? 'Error al actualizar la contraseña';
      }
      
      setState(() {
        _errorMessage = message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ocurrió un error inesperado';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Choose new password'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Almost done. Enter your new password and you\'re all set.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                const Text(
                  'New password',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // Email (no editable)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    FirebaseAuth.instance.currentUser?.email ?? 'example@gmail.com',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Confirm new password',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: const InputDecoration(
                    hintText: 'Enter new password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onChanged: _checkPasswordRequirements,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa una contraseña';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    hintText: 'Confirm new password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor confirma tu contraseña';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                // Requisitos de contraseña
                Column(
                  children: [
                    Icon(
                      _hasLowercase ? Icons.check_circle : Icons.circle_outlined,
                      color: _hasLowercase ? Colors.green : Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    const Text('One lowercase character'),
                    const SizedBox(width: 16),
                    Icon(
                      _hasSpecialChar ? Icons.check_circle : Icons.circle_outlined,
                      color: _hasSpecialChar ? Colors.green : Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    const Text('One special character'),
                  
                const SizedBox(height: 8),
                
                  
                    Icon(
                      _hasMinLength ? Icons.check_circle : Icons.circle_outlined,
                      color: _hasMinLength ? Colors.green : Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    const Text('8 character minimum'),
                    const SizedBox(width: 16),
                    Icon(
                      _hasNumber ? Icons.check_circle : Icons.circle_outlined,
                      color: _hasNumber ? Colors.green : Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    const Text('One number'),
                  ],
                ),
                
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _updatePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      disabledBackgroundColor: Colors.blue.withOpacity(0.6),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Reset password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
