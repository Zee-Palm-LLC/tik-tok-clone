import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String username;
  String profilePic;
  String email;
  String uid;

  UserModel(
      {required this.username,
      required this.email,
      required this.uid,
      required this.profilePic});

  Map<String, dynamic> toJson() => {
        "username": username,
        "profilePic": profilePic,
        "email": email,
        "uid": uid,
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot['email'],
      profilePic: snapshot['profilePic'],
      uid: snapshot['uid'],
      username: snapshot['username'],
    );
  }
}
