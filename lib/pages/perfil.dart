import 'package:donutapp/pages/Login.dart';
import 'package:donutapp/pages/ModPerfil.dart';
import 'package:donutapp/pages/forgot_password_screen.dart';
import 'package:donutapp/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String photoURL = '';
  String nombre = '';
  String correo = '';

  @override
  void initState() {
    super.initState();
    obtenerDatosUsuario();
  }

  Future<void> obtenerDatosUsuario() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final uid = user.uid;
        final doc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (doc.exists) {
          setState(() {
            nombre = doc.data()?['name'] ?? 'Sin nombre';
            correo = doc.data()?['email'] ?? 'Sin correo';
            photoURL = doc.data()?['photoURL'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error al obtener datos del usuario: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.pinkAccent),
                child: Text('Menú',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                ),
              ),
              ListTile(
        leading: Icon(Icons.logout),
        title: Text('Cerrar sesión'),
        onTap: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LogIn()), // asegúrate de importar esta pantalla
          );
        },
      ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.grey[800]),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserPage()));
                  },
                  icon: Icon(Icons.person)),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          photoURL.isNotEmpty ? NetworkImage(photoURL) : null,
                      child: photoURL.isEmpty
                          ? Icon(Icons.account_circle,
                              size: 100, color: Colors.grey)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text("Nombre: $nombre", style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text("Correo: $correo", style: TextStyle(fontSize: 18)),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdatePasswordScreen()));
                    },
                    icon: const Icon(Icons.lock_reset),
                    label: const Text('Restablecer Contraseña'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()),
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Modificar Perfil'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
