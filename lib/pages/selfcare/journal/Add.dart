import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/pages/selfcare/journal/model/user_models.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add an Entry"),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Enter title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: descriptionController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Enter description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                User? user = auth.currentUser;
                String? userId = user?.uid;
                firestoreHelper
                    .create(UserModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      id: userId
                    ))
                    .then((_) => Navigator.pop(context));
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF111634)),
              ),
              child: Text("Add Entry"),
            ),
          ],
        ),
      ),
    );
  }
}

class firestoreHelper {
  static Stream<QuerySnapshot<Map<String, dynamic>>> read() {
    final userCollection = FirebaseFirestore.instance.collection("journal");
    return userCollection.snapshots();
  }

  static Future<void> create(UserModel user) async {
 
    final userCollection = FirebaseFirestore.instance.collection("journal");

    final docRef = userCollection.doc();

    final newUser = UserModel(
      id: user.id,
      title: user.title,
      description: user.description,
    ).toJson();

    try {
      await docRef.set(newUser);
      log("added to database");
    } catch (e) {
      print("Some error occurred: $e");
    }
  }

  static Future<void> update(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection("journal");

    final docRef = userCollection.doc(user.id);

    final newUser = UserModel(
      id: user.id,
      title: user.title,
      description: user.description,
    ).toJson();

    try {
      await docRef.update(newUser);
    } catch (e) {
      print("Some error occurred: $e");
    }
  }

  static Future<void> delete(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection("journal");

    final docRef = userCollection.doc(user.id);
    await docRef.delete();
  }
}
