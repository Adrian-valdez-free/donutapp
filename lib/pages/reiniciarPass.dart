import 'package:donutapp/pages/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordPage extends StatefulWidget {
  final String oobCode;
  const ResetPasswordPage({super.key, required this.oobCode});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _success = false;
  String? _error;

 Future<void> _resetPassword() async {
  try {
    if (_passwordController.text.trim().isEmpty) {
  setState(() {
    _error = 'Por favor, ingresa una nueva contraseña';
    _success = false;
  });
  return;
}
    await FirebaseAuth.instance.confirmPasswordReset(
      code: widget.oobCode,
      newPassword: _passwordController.text,
    );
    setState(() {
      _success = true;
      _error = null;
    });

    // Redirige al login después de 2 min
    Future.delayed(const Duration(seconds: 120), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LogIn()),
        (route) => false,
      );
    });

  } catch (e) {
    setState(() {
      _error = 'Error al cambiar la contraseña: ${e.toString()}';
      _success = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restablecer Contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_success)
              const Text('¡Contraseña restablecida con éxito!', style: TextStyle(color: Colors.green)),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Nueva Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              child: const Text('Cambiar Contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
