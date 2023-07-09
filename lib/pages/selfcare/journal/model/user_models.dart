import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? title;
  final String? description;
  final String? id;

  UserModel({this.title, this.description, this.id});

  factory UserModel.fromSnapShot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        id: snapshot['id'],
        title: snapshot['title'],
        description: snapshot['description']);
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "id": id,
      };
}
