import 'package:flutter/material.dart';

import '../Widgets/postBottombar.dart';
import '../Widgets/postbar.dart';

class PostScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        
      ),
      child: Scaffold(
        backgroundColor: Color(0xFFFDF2F6),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: PostAppBar(),
        )
        ,
        bottomNavigationBar: postBottomBar(),
        
        
        ),
    );
  }
}