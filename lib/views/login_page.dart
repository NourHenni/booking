import 'package:booking_project/views/mypage.dart';
import 'package:booking_project/views/forget_password.dart';
import 'package:booking_project/views/location_page.dart';

import 'package:booking_project/views/register_page.dart';
import 'package:booking_project/views/homeHote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/Homebar.dart';
import '../components/reusable_widget.dart';
import 'admin.dart';
import 'client.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<LoginPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/llogin.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 60),
              
            ),
            SingleChildScrollView(
              
              
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3),
                child: Form (
                   key: _formkey,
                   child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                   
                          const SizedBox(height: 50),
                    Container(
                      
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child:
                       Column(
                        children: [
                          
                          TextFormField(
                           controller: _emailTextController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.email),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                
                                border: OutlineInputBorder(
                                  
                                  borderRadius: BorderRadius.circular(10),
                                )),
                                validator: (value) {
                            if (value!.length == 0) {
                              return "L'email ne peut pas être vide";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Veuillez entrer un email valide");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _emailTextController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                          
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordTextController,
                            style: TextStyle(),
                            obscureText: _isObscure3,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(_isObscure3
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure3 = !_isObscure3;
                                  });
                                }),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                enabled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                                validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Le mot de passe ne peut pas être vide";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("veuillez entrer un mot de passe valide minimum 6 caractères");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _passwordTextController.text = value!;
                          },
                           keyboardType: TextInputType.emailAddress,
                        ),
                         
                          const SizedBox(height: 30),
                          MaterialButton(
                            minWidth: 320.0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          
                          height: 50,
                          onPressed: () {
                            setState(() {
                              visible = true;
                            });
                            signIn(
                                _emailTextController.text, _passwordTextController.text);
                          },
                          child: Text(
                            "Se connecter",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        
                      
                    Padding(
                      padding: EdgeInsets.only(left: 160.0, top: 12.0, bottom: 12.0),
                  
                   child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                 ForgetPassword(),));
                                },
                                child: Text(
                                  'Mot De Passe Oublié ',
                                  textAlign: TextAlign.center,
                                  
                                  style: TextStyle(
                                    height: -1,
                                    decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 14),
                                ),
                                style: ButtonStyle(),
                              ),
                            ]),
                ),
                            
                         Padding(
                      padding: EdgeInsets.only(left: 80.0, top: 12.0, bottom: 12.0),
                      child:  Row (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                 registerpage(),));
                                },
                                child: Text(
                                  "Je n'ai pas de compte",
                                  textAlign: TextAlign.center,
                                  
                                  style: TextStyle(
                                    height: -1,
                                    decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 14),
                                ),
                                style: ButtonStyle(),
                              ),
                            ]),
                          
                        ) ],
                      ),
                    )
                  ],
                ),
              ),
            ),
         ) ],
        ),
        
      ),
     
    );
    
  }
  
  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "Propriétaire") {
           Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  MyPage(),
          ),
        );
        }else if(documentSnapshot.get('rool') == "Client"){
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  client(),
          ),
        );
        } else {
                  Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  admin(),
          ),
        );
        }
      } else  {
        print('Document does not exist on the database');
      }
    });
  }
  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
        showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("No user found for that email."),
        actions: <Widget>[
          ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
        } else if (e.code == 'wrong-password') {
          showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("user introuvable !"),
        actions: <Widget>[
          ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
        }
      }
    }
  }


  }

  