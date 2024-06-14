import 'package:booking_project/views/logSuite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class admin extends StatefulWidget {
  const admin({Key? key}) : super(key: key);



  @override
  State<admin> createState() => _admin();
}

class _admin extends State<admin> {
  final email = FirebaseAuth.instance.currentUser!.email;

  String? _email;
  String? _name;
  String? address;
 
 
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("Dashboard"),
        centerTitle: true,
        
     ),
      );}
      Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
}
      
              
            
            
            
        
  }