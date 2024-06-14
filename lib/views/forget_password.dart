import 'package:booking_project/views/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/reusable_widget.dart';

class ForgetPassword extends StatefulWidget{
  const ForgetPassword({Key? key}) : super(key: key);
  @override

  _MyForgetPassword createState() => _MyForgetPassword();
}

  class _MyForgetPassword extends State<ForgetPassword> {
 TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/llogin.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
      ),
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
                    top: MediaQuery.of(context).size.height * 0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child:
                       Column(
                        children: [
                          
                          TextField(
                           controller: _emailTextController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                
                                border: OutlineInputBorder(
                                  
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          
                          const SizedBox(height: 30),
                  firebaseUIButton(context, "Modifier Mot De Passe ", () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailTextController.text)
                      .then((value) => Navigator.of(context).pop());
                })
                          
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
      ]
       )
       
        )
        );
}} 