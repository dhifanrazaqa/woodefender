import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woodefender/models/User.dart';

class Comment {
  String? id;
  String? message;
  DateTime? createdAt;
  DocumentReference? postId;
  DocumentReference? userId;
  User? user;

  Comment({
    this.id,
    this.message,
    this.createdAt,
    this.postId,
    this.userId,
    this.user,
  });

  Comment copyWith({
    String? id,
    String? message,
    DateTime? createdAt,
    DocumentReference? postId,
    DocumentReference? userId,
    User? user,
  }) {
    return Comment(
      id: id ?? this.id,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      user: user ?? this.user,
    );
  }
}