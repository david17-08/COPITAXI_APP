import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedRole;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _register() async {
    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, selecciona un rol")),
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': emailController.text.trim(),
        'role': selectedRole,
        'approved': selectedRole == 'driver' ? false : true,
      });

      if (selectedRole == 'driver') {
        _sendNotificationToAdmin();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registro exitoso, esperando aprobación del administrador")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registro exitoso, puedes iniciar sesión")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  void _sendNotificationToAdmin() async {
    DocumentSnapshot adminTokenDoc = await _firestore.collection('admin_tokens').doc('admin_main').get();
    if (adminTokenDoc.exists) {
      String adminToken = adminTokenDoc['token'];

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'key=213326261794'
      };

      var body = jsonEncode({
        'to': adminToken,
        'notification': {
          'title': 'Nuevo Chofer Registrado',
          'body': 'Un nuevo chofer ha solicitado acceso.',
        },
      });

      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: headers,
        body: body,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Correo Electrónico")),
            SizedBox(height: 10),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Contraseña"), obscureText: true),
            SizedBox(height: 20),
            Text("Selecciona tu rol:"),
            RadioListTile(
              title: Text("Usuario Normal"),
              value: 'user',
              groupValue: selectedRole,
              onChanged: (value) {
                setState(() {
                  selectedRole = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Chofer"),
              value: 'driver',
              groupValue: selectedRole,
              onChanged: (value) {
                setState(() {
                  selectedRole = value.toString();
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _register,
                child: Text("Registrarse"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}