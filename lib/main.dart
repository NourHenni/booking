import 'package:booking_project/views/Welcomescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends  StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }
  @override 
  Widget build (BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme :ThemeData(
        scaffoldBackgroundColor: Color(0xFFFDF2F6),
      ),
       home: Welcomescreen(),
       
    );
  }       
}