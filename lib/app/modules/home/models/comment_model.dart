import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String username;
  String comment;
  List likes;
  String profilePhoto;
  String uid;
  String id;

  CommentModel({
    required this.username,
    required this.comment,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': comment,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'id': id,
      };

  static CommentModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CommentModel(
      username: snapshot['username'],
      comment: snapshot['comment'],
      likes: snapshot['likes'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      id: snapshot['id'],
    );
  }
}
