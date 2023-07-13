import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    descriptionController = TextEditingController(text: widget.user.description);
    super.initState();
  }

  @override
  void dispose() {
    titleController?.dispose();
    descriptionController?.dispose();
    super.dispose();
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
                labelText: 'Enter title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: descriptionController,
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
                firestoreHelper
                    .update(UserModel(
                  id: widget.user.id,
                  title: titleController!.text,
                  description: descriptionController!.text,
                ))
                    .then((value) => Navigator.pop(context));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.green;
                    return Colors.pink;
                  },
                ),
              ),
              child: Text("Update"),
            )
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
      id: docRef.id,
      title: user.title,
      description: user.description,
    ).toJson();

    try {
      await docRef.set(newUser);
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
