import 'package:flutter/material.dart';

class postBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      height: MediaQuery.of(context).size.height/2,
      padding: EdgeInsets.only(top: 20,left: 20,right: 20),
      decoration: BoxDecoration(
        color: Color(0xFFEDF2F6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),

        )
      ),
      child: ListView(
        children: [
          Padding(padding: EdgeInsets.only(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("city name ",style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                
                  ),),
                  Row(
                    children: [
                      Icon(Icons.star,color: Colors.yellow,size: 25,),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500",style: TextStyle(color: Colors.black26,fontSize: 16),),
            ],
          )
          )       ],
      ),
    );
  }
}