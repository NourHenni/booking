import 'package:booking_project/views/addpromotion.dart';
import 'package:booking_project/views/changerMotdePasse.dart';
import 'package:booking_project/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'logSuite.dart';


class userProfile extends StatefulWidget {
  const userProfile({Key? key}) : super(key: key);



  @override
  State<userProfile> createState() => _userProfile();
}

class _userProfile extends State<userProfile> {
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
        title: const Text("PROFILE"),
        centerTitle: true,
        
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          // COLUMN THAT WILL CONTAIN THE PROFILE
          Column(
            children: const [
              CircleAvatar(
                radius: 30,
               child: Icon (
            FontAwesomeIcons.user,
            
            )
                
              ),
            
            ],
            
          ),Row(
            children: [
              Text(
                textAlign: TextAlign.center,
                "Email: $email",
                style: TextStyle(fontSize: 18.0,),
              ),
            ],
          ),
         
        
          const SizedBox(height: 35),
          
          ...List.generate(
            customListTiles.length,
            (index) {
              final tile = customListTiles[index];
              if (tile.icon == Icons.password_rounded)
              {return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 4,
                  shadowColor: Color.fromARGB(31, 133, 82, 82),
                  child: ListTile(
                    onTap: (  ) => {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                 ChangePassword(),))
                       
                    },
                    leading: Icon(tile.icon),
                    title: Text(tile.title),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              );}
            
              else 
              {return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 4,
                  shadowColor: Color.fromARGB(31, 133, 82, 82),
                  child: ListTile(
                    
                    leading: Icon(tile.icon),
                    title: Text(tile.title),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              );}
              
            },
          )
        ],
      ),
      
    );
  }
}

class ProfileCompletionCard {
  final String title;
  final String buttonText;
  final IconData icon;
  ProfileCompletionCard({
    required this.title,
    required this.buttonText,
    required this.icon,
  });
}



class CustomListTile {
  final IconData icon;
  final String title;
  CustomListTile({
    required this.icon,
    required this.title,
  });
}




List<CustomListTile> customListTiles = [
  CustomListTile(
    icon: Icons.password_rounded,
    title: "Changer Mot De Passe",
  ),
  
];

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


class TextWidget extends StatelessWidget {
  TextWidget({
    Key? key,
    required this.text,
    required this.color,
    required this.textSize,
    this.isTitle = false,
    this.maxLines = 10,
  }) : super(key: key);
  final String text;
  final Color color;
  final double textSize;
  bool isTitle;
  int maxLines = 10;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: color,
          fontSize: textSize,
          fontWeight: isTitle ? FontWeight.bold : FontWeight.normal),
    );
  }


 
  
}