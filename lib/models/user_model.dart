import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String email;
  final String name;
  User({
    this.id,
    this.email,
    this.name,
  });
  factory User.fromDocument(DocumentSnapshot doc) {
    // DateTime date = DateTime.parse(doc["user_DOB"]);
    return User(
        id: doc['userId'],
        email: doc['Email'],
        name: doc['UserName'],
        );
  }
}
