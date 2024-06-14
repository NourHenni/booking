import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/Homebar.dart';
import '../components/reusable_widget.dart';
import 'logSuite.dart';
import 'logi.dart';
import 'login_page.dart';

class registerpage extends StatefulWidget{
  const registerpage({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<registerpage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
   TextEditingController _phoneTextController = TextEditingController();
    TextEditingController _dateTextController = TextEditingController();
    TextEditingController _ppasswordTextController = TextEditingController();
bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _isObscure = true;
  bool _isObscure2 = true;
  var options = [
    'Client',
    'Propriétaire',
  ];
  var _currentItemSelected = "Client";
  var rool = "Client";

  
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/samii.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        backgroundColor: Colors.transparent,
        
        body: Stack(
          children: [
            
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              
            ),
            
            SingleChildScrollView(
              
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.24),
                child: Form( 
                   key: _formkey,
                   child: Column(
                  
                  
                  children: [
                    Container(
                      
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: 
                       Column(
                        children: [
                          
                          TextFormField(
                             controller: _userNameTextController,
                            style: TextStyle(color: Colors.black),
                           
                            decoration: InputDecoration(
                            
                              suffixIcon: Icon(Icons.person_outline),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Nom & Prenom",
                                
                                border: OutlineInputBorder(
                                  
                                  borderRadius: BorderRadius.circular(10),
                                )),
                                validator: (value) {
                            if (value!.length == 0) {
                              return "Le champ ne peut pas être vide";
                            }
                           else {
                              return null;
                            }},onChanged: (value) {},
                          keyboardType: TextInputType.name,
                          ),
                          
                          SizedBox(
                            height: 10,
                          ),
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
                            }},onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                        ),
                          
                          
                          
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                           controller: _phoneTextController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                               suffixIcon: Icon(Icons.phone),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Numero de téléphone",
                                
                                border: OutlineInputBorder(
                                  
                                  borderRadius: BorderRadius.circular(10),
                                )),
                                validator: (value) {
                            if (value!.length == 0) {
                              return "Le champ ne peut pas être vide";
                            }
                           else {
                              return null;
                            }},onChanged: (value) {},
                          keyboardType: TextInputType.phone,
                          
                          ),
                          
                          SizedBox(
                            height: 10,
                          ),
                          
                          
                          TextFormField(
                           readOnly: true,
                             controller: _dateTextController,
                           decoration: InputDecoration(
                            suffixIcon: Icon(Icons.calendar_month),
                              hintText: 'Date De Naissance ',
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(
                                  
                                  borderRadius: BorderRadius.circular(10),
                                ),
                           ),
                           
                           onTap: () async {
                           var date =  await showDatePicker(
                            context: context, 
                            initialDate:DateTime.now(),
                             firstDate:DateTime(1900),
                            lastDate: DateTime(2100));
                          _dateTextController.text = date.toString().substring(0,10);  
                             
                           },
                           validator: (value) {
                            if (value!.length == 0) {
                              return "Le champ ne peut pas être vide";
                            }
                           else {
                              return null;
                            }},onChanged: (value) {},
                          keyboardType: TextInputType.datetime,
                          ),
                          
                        
                          
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _passwordTextController,
                            style: TextStyle(),
                            obscureText: _isObscure,
                            
                    //Do something with the user input.
                              
                            decoration: InputDecoration(
                             suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                enabled: true,
                                hintText: "Mot De Passe",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                                validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return("Le mot de passe ne peut pas être vide") ;
                            }
                            if (!regex.hasMatch(value)) {
                              return ("veuillez entrer un mot de passe valide minimum 6 caractères");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 10),
                          TextFormField(
                            controller: _ppasswordTextController,
                            style: TextStyle(),
                            obscureText: _isObscure2,
                            decoration: InputDecoration(
                               suffixIcon: IconButton(
                                icon: Icon(_isObscure2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                }),
                                    
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Confirmer Mot De Passe",
                                enabled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                                validator: (value) {
                            if (_ppasswordTextController.text != _passwordTextController.text) {
                              return "Le mot de passe ne correspond pas";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          ),
                          const SizedBox(height: 10),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vous etes ? : ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            DropdownButton<String>(
                              dropdownColor: Colors.grey.shade100,
                              isDense: true,
                              isExpanded: false,
                              iconEnabledColor: Colors.black,
                              focusColor: Colors.black,
                              items: options.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                setState(() {
                                  _currentItemSelected = newValueSelected!;
                                  rool = newValueSelected;
                                });
                              },
                              value: _currentItemSelected,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
    
                  Row(     
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MaterialButton(
                              minWidth: 310.0,
                             
                              shape: RoundedRectangleBorder(
                                
                                 borderRadius: BorderRadius.circular(10),),
                              
                              
                              height: 50,
                              onPressed: () {
                                setState(() {
                                  showProgress = true;
                                });
                                signUp(_emailTextController.text,
                                    _passwordTextController.text, rool);
                              },
                              child: Text(
                                "S'inscrire",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            
                            
                          ],
                        ),
                        const SizedBox(height: 10),

                         Padding(
                      padding: EdgeInsets.only(left: 87.0, top: 20.0, bottom: 12.0),
                      child:  Row (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                 LoginPage(),));
                                },
                                child: Text(
                                  "J' ai déja un compte",
                                  textAlign: TextAlign.center,
                                  
                                  style: TextStyle(
                                    height: -2,
                                    decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 15),
                                ),
                                style: ButtonStyle(),
                              ),
                            ]),)
                        
                  ]) ) ]
                      ),

              ),
            )),
        ],
        ),
       
      ),
      
    );
  }
  void signUp(String email, String password, String rool) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, rool)})
          .catchError((e) {});
    }
  }
  postDetailsToFirestore(String email, String rool) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': _emailTextController.text, 'rool': rool});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}

