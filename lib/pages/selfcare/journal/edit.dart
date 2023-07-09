import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project/pages/selfcare/journal/model/user_models.dart';

class EditPage extends StatefulWidget {
  final UserModel user;
  const EditPage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController? titleController;
  TextEditingController? descriptionController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.user.title);
    descriptionController =
        TextEditingController(text: widget.user.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Tasks"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  labelText: 'Enter title', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                  labelText: 'Enter description', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  firestoreHelper
                      .update(UserModel(
                          id: widget.user.id,
                          title: titleController!.text,
                          description: descriptionController!.text))
                      .then((value) => {Navigator.pop(context)});
                },
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.green;
                  return Colors.pink;
                })),
                child: Text("Update"))
          ],
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
