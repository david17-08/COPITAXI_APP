import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copitaxi_app/screens/login_screen.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Función para cerrar sesión
  void _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // Función para ver perfil del administrador
  void _showProfile() {
    User? user = _auth.currentUser;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Perfil del Administrador"),
        content: Text("Correo: ${user?.email ?? 'Desconocido'}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  // Función para aceptar/rechazar choferes
  void _updateDriverStatus(String driverId, bool accept) async {
    await _firestore.collection('users').doc(driverId).update({
      'approved': accept,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(accept ? "Chofer aprobado ✅" : "Chofer rechazado ❌"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Obtener choferes pendientes
  Stream<QuerySnapshot> getPendingDrivers() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'driver') // Solo choferes
        .where('approved', isEqualTo: false) // Solo los pendientes
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panel de Administrador"),
        backgroundColor: const Color.fromARGB(255, 211, 208, 27),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 30),
            onPressed: _showProfile,
          ),
          IconButton(
            icon: Icon(Icons.logout, size: 30, color: Colors.redAccent),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Solicitudes de Choferes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: getPendingDrivers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var drivers = snapshot.data!.docs;

                  if (drivers.isEmpty) {
                    return Center(
                      child: Text(
                        "No hay solicitudes pendientes 🚗",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: drivers.length,
                    itemBuilder: (context, index) {
                      var driver = drivers[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey[300],
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(
                            driver['email'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Pendiente de aprobación"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.check_circle, color: Colors.green, size: 30),
                                onPressed: () => _updateDriverStatus(driver.id, true),
                              ),
                              IconButton(
                                icon: Icon(Icons.cancel, color: Colors.red, size: 30),
                                onPressed: () => _updateDriverStatus(driver.id, false),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
