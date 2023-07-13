import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/pages/selfcare/categories.dart';
import 'package:project/pages/selfcare/journal/Add.dart';
import 'package:project/pages/selfcare/journal/edit.dart';
import 'package:project/pages/selfcare/journal/model/user_models.dart';

  class MainActivity extends StatefulWidget {
    bool isGuest = false;
    MainActivity({required this.isGuest, Key? key}) : super(key: key);

    @override
    State<MainActivity> createState() => _MainActivityState();
  }

class _MainActivityState extends State<MainActivity> {
  late String uid;
  String? userid;

  @override
  void initState() {
    super.initState();
    getUserID();
  }

  void getUserID() {
    FirebaseAuth auth = FirebaseAuth.instance;
                User? user = auth.currentUser;
                userid = user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Catagories()));
              },
              icon: Icon(Icons.arrow_back),
            ),
            Text("JOURNAL"),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(108, 149, 167, 183),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("journal")
              .where("id", isEqualTo: userid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(widget.isGuest) {
              return const Center(
                child: Text("Login required to acess this page", style: TextStyle(color: Colors.white, fontSize: 17),),
              );
            }
            if (snapshot.hasData) {
              log("message");
              // log()
              final userData = snapshot.data!.docs;
              return ListView.builder(
                itemCount: userData.length,
                itemBuilder: (context, index) {
                  final singleUser = UserModel.fromSnapShot(userData[index]);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditPage(
                            user: UserModel(
                              title: singleUser.title,
                              description: singleUser.description,
                              id: singleUser.id,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${singleUser.title}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${singleUser.description}",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddTask()));
        },
        child: Icon(
          Icons.add,
          color: primary,
        ),
      ),
    );
  }
}
