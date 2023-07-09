
import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/pages/blog/assets.dart';
import 'package:project/pages/blog/sections/widgets/avatar.dart';

class StatusSection extends StatelessWidget {

  final _textController = TextEditingController();
  String userPost = '';


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Avatar(displayImage: dulquer, displayStatus: false),
      title: TextField(
        controller: _textController,
        decoration: InputDecoration(
          hintText: "What's on your mind?",
          hintStyle: TextStyle(color: Colors.black),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () {
             
            },
            icon: const Icon(Icons.send,color: primary,),
          )
          ),
      ),
      
  
    );
    Expanded(child: Container(
            child: Text(userPost),
          ));
  }
}
