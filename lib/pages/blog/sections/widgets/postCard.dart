
import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/pages/blog/sections/headerButtonSection.dart';
import 'package:project/pages/blog/sections/widgets/avatar.dart';
import 'package:project/pages/blog/sections/widgets/headerButton.dart';

class PostCard extends StatelessWidget {
  final String avatar;
  final String name;
  final String publishedAt;
  
  final String postData;
  final bool showBlueTick;
  final String likeCount;
  final String shareCount;
  final String commentCount;

  PostCard(
      {required this.avatar,
      required this.name,
      required this.publishedAt,
     
      required this.postData,
      this.showBlueTick = false,
      required this.likeCount,
      required this.shareCount,
      required this.commentCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          
          postCardHeader(),
          
          imageSection(),
          footerSection(),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
          HeaderButtonSection(
            buttonOne: headerButton(
              buttonAction: () {
                print("like this post!!");
              },
              buttonColor: Color.fromARGB(255, 146, 142, 142),
              buttonIcon: Icons.thumb_up_alt_outlined,
              buttonText: "Like",
            ),
            buttonTwo: headerButton(
              buttonAction: () {
                print("like this post!!");
              },
              buttonColor: Color.fromARGB(255, 146, 142, 142),
              buttonIcon: Icons.message_outlined,
              buttonText: "Comment",
            ),
            buttonThree: headerButton(
              buttonAction: () {
                print("like this post!!");
              },
              buttonColor: Color.fromARGB(255, 146, 142, 142),
              buttonIcon: Icons.share_outlined,
              buttonText: "Share",
            ),
          ),
        ],
      ),
    );
  }

  Widget displayText(@required String label) {
    return Text(
      label == null ? "" : label,
      style: TextStyle(
        color: Colors.grey[700],
      ),
    );
  }

  Widget footerSection() {
    return Container(
      height: 50,
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Container(
          child: Row(
            children: [ Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.thumb_up,
              color: Colors.white,
              size: 10,
            ),
          ),
          SizedBox(width: 5,),
          displayText(likeCount),
          ],
          ),
         ),
          
          Container(
            child: Row(
              children: [
                displayText(commentCount),
                SizedBox(width: 5,),
                displayText("Comments"),
                SizedBox(width: 10,),
                displayText(shareCount),
                SizedBox(width: 5,),
                displayText("Shares"),
                SizedBox(width: 10,),
                Avatar(displayImage: avatar
                , displayStatus: false, width: 25, height: 25,),
                SizedBox(width: 5,),
                IconButton( onPressed: () { 
                  print("dropdown pressed");}, icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700],)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget imageSection() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Text(postData),
    );
  }

  

  Widget postCardHeader() {
    return ListTile(
      leading: Avatar(displayImage: avatar, displayStatus: false),
      title: Row(
        children: [
          Text(
            name,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          
        ],
      ),
      subtitle: Row(
        children: [
          Text(publishedAt == null ? "" : publishedAt),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.public,
            color: Colors.grey[700],
            size: 15,
          ),
        ],
      ),
      trailing: IconButton(
          onPressed: () {
            print("open more menu!");
          },
          icon: Icon(
            Icons.more_horiz,
            color: Colors.grey[700],
          )),
    );
  }
}
