import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/pages/selfcare/journal/model/user_models.dart';

class firestoreHelper {
  static Stream<QuerySnapshot<Map<String, dynamic>>> read(String userId) {
    final userCollection = FirebaseFirestore.instance.collection("journal");
    return userCollection.where("userId", isEqualTo: userId).snapshots();
  }

  static Future<void> create(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection("journal");

    final uid = userCollection.doc().id;
    final docRef = userCollection.doc(uid);

    final newUser = UserModel(
      id: user.id,
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

      FirebaseAuth auth = FirebaseAuth.instance;
    User? users = auth.currentUser;
    String? userId = users?.uid;
    final userCollection = FirebaseFirestore.instance.collection("journal");

    final docRef = userCollection.doc(user.id);
  

    final newUser = UserModel(
      id: userId,
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
