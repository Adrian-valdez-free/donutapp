import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  File? _imageFile;
  String? _currentPhotoURL;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final data = doc.data();
      if (data != null) {
        _nameController.text = data['name'] ?? '';
        setState(() {
          _currentPhotoURL = data['photoURL'];
        });
      }
    }
  }

  Future<void> seleccionarImagen() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<String?> subirImagen(File image, String uid) async {
    final ref = FirebaseStorage.instance.ref().child('profile_images').child('$uid.jpg');
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  Future<void> guardarCambios() async {
    
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    String? url = _currentPhotoURL;

    if (_imageFile != null) {
      url = await subirImagen(_imageFile!, user.uid);
      print("Subiendo imagen como: profile_images/${user.uid}.jpg");

    }

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'name': _nameController.text,
      'photoURL': url,
    });

    Navigator.pop(context); // Regresa al perfil
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: seleccionarImagen,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : (_currentPhotoURL != null && _currentPhotoURL!.isNotEmpty
                        ? NetworkImage(_currentPhotoURL!)
                        : null) as ImageProvider?,
                child: _imageFile == null && (_currentPhotoURL == null || _currentPhotoURL!.isEmpty)
                    ? Icon(Icons.camera_alt, size: 50)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: guardarCambios,
              icon: Icon(Icons.save),
              label: Text('Guardar Cambios'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            )
          ],
        ),
      ),
    );
  }
}
