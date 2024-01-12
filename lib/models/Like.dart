import 'package:cloud_firestore/cloud_firestore.dart';

class Like {
  String? id;
  DateTime? createdAt;
  DocumentReference? userId;
  DocumentReference? postId;

  Like({
    this.id,
    this.createdAt,
    this.userId,
    this.postId,
  });

  Like copyWith({
    String? id,
    DateTime? createdAt,
    DocumentReference? userId,
    DocumentReference? postId,
  }) {
    return Like(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
    );
  }
}