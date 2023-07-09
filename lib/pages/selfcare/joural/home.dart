import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/pages/selfcare/catagories.dart';
import 'package:project/pages/selfcare/joural/remote_data/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/selfcare/joural/Add.dart';
import 'package:project/pages/selfcare/joural/edit.dart';
import 'package:project/pages/selfcare/joural/model/user_models.dart';

import '../../../colors.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  String uid = '';

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getuid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Row(
          children: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Catagories()));
            }, icon: Icon(Icons.arrow_back)),
            Text("JOURNAL"),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(108, 149, 167, 183),
      body: Container(
        child: Column(
          children: [
            StreamBuilder<List<UserModel>>(
                stream: firestoreHelper.read(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    final userData = snapshot.data;
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final singleUser = userData![index];
                          return Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: Text("Delete"),
                                        content: Text("Do you want to delete?"),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              firestoreHelper
                                                  .delete(singleUser)
                                                  .then((value) =>
                                                      {Navigator.pop(context)});
                                            },
                                            child: Text("Delete"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Cancel"),
                                          )
                                        ],
                                      );
                                    });
                              },
                              title: Text(
                                "${singleUser.title}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 27),
                              ),
                              subtitle: Text(
                                "${singleUser.description}",
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => EditPage(
                                                  user: UserModel(
                                                      title: singleUser.title,
                                                      description: singleUser
                                                          .description,
                                                      id: singleUser.id),
                                                )));
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )),
                            ),
                          );
                        },
                        itemCount: userData!.length,
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })
          ],
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

class firestoreHelper {
  static Stream<List<UserModel>> read() {
    final userCollection = FirebaseFirestore.instance.collection("journal");
    return userCollection.snapshots().map((QuerySnapshot) =>
        QuerySnapshot.docs.map((e) => UserModel.fromSnapShot(e)).toList());
  }

  static Future create(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection("journal");

    final uid = userCollection.doc().id;
    final docRef = userCollection.doc(uid);

    final newUser = UserModel(
      id: uid,
      title: user.title,
      description: user.description,
    ).toJson();

    try {
      await docRef.set(newUser);
    } catch (e) {
      print("some error occured");
    }
  }

  static Future update(UserModel user) async {
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
      print("some error occured");
    }
  }

  static Future delete(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection("journal");

    final docRef = userCollection.doc(user.id).delete();
  }
}
