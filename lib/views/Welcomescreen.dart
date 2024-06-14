import 'package:booking_project/views/page.dart';
import 'package:flutter/material.dart';
import 'package:booking_project/views/login_page.dart';

import 'homePage.dart';


class Welcomescreen extends StatelessWidget{
  @override 
  Widget build(BuildContext context ){
    return Container(
      decoration: BoxDecoration( 
        image:DecorationImage(
        image: AssetImage("images/hottel.jpg"),
        fit:BoxFit.cover,
        opacity: 0.7,
      )) ,
      child: Material(
        color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 65,horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
             
              children: [
                Text("Bienvenue",style:TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5
                ),),
                  SizedBox(height: 2,),
                  
                  
                  
                  
            SizedBox(height: 12,),
                  InkWell(onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PageHome(),
                    ));
                  },
                  child: Ink(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration( color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                
                  ),
                  child: Icon(Icons.arrow_forward_ios,
                  color: Colors.black54,
                  size : 20
                  )

             ) )],
            ),
          ),

      )
    );
  }
}