import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class add_promotion extends StatefulWidget {
  const add_promotion({super.key});

  @override
  State<add_promotion> createState() => _add_promotionState();
}

class _add_promotionState extends State<add_promotion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _image = TextEditingController();
  final TextEditingController _titre = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _prix = TextEditingController();
  late XFile imageFile;
  late String _imageUrl;
  XFile? pickedFile;
  late String downloadUrl;
  Color _borderColor = Color(0xAA000000);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                 padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titre,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "titre",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: _description,
                        style: TextStyle(),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "description",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: _prix,
                        style: TextStyle(),
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "prix",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () async {
                          String uniqueFileName =
                              DateTime.now().microsecondsSinceEpoch.toString();
                          final picker = ImagePicker();
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.gallery);
                          Reference reference = FirebaseStorage.instance.ref();
                          Reference referenceImageToupload =
                              reference.child("hotel/${_titre.text}.jpg");
                          try {
                            referenceImageToupload
                                .putFile(File(pickedFile!.path));
                            _imageUrl =
                                await referenceImageToupload.getDownloadURL();
                          } catch (error) {}
                          if (pickedFile != null) {
                            setState(() {
                              // _image.text = pickedFile.path;
                              _image.text = path.basename(pickedFile.path);
                              imageFile = pickedFile; // initialize the variable
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: _borderColor),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.attach_file),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: Text(
                                  _image.text.isEmpty
                                      ? 'No file selected'
                                      : _image.text,
                                  selectionColor: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        child: Text("Add Promotion"),
                        onPressed: () async {
                          try {
                            final CollectionReference promotionsRef =
                                FirebaseFirestore.instance.collection('hotel');
                            await promotionsRef.add({
                              'titre': _titre.text,
                              'description': _description.text,
                              'prix': _prix.text,
                              'image': _imageUrl.toString(),
                            });
                            setState(() {
                              _titre.clear();
                              _description.clear();
                              _prix.clear();
                              _image.clear();
                              imageFile;
                            });

                            Navigator.pop(context);
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}