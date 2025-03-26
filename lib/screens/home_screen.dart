import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:copitaxi_app/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bienvenido a COPITAXI"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () { 
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          )
        ],
      ),
      body: Center(child: Text("Has iniciado sesión correctamente 🚖")),
    );
  }
}
