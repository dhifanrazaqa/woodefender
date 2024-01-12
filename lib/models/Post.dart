import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woodefender/models/User.dart';

class Post {
  String? id;
  String? message;
  String? type;
  String? link;
  String? imageUrl;
  int? likeCount;
  bool? isLiked;
  DateTime? createdAt;
  DocumentReference? userId;
  User? user;

  Post({
    this.id,
    this.message,
    this.type,
    this.link,
    this.imageUrl,
    this.likeCount,
    this.isLiked,
    this.createdAt,
    this.userId,
    this.user,
  });

  Post copyWith({
    String? id,
    String? message,
    String? type,
    String? link,
    String? imageUrl,
    int? likeCount,
    bool? isLiked,
    DateTime? createdAt,
    DocumentReference? userId,
    User? user,
  }) {
    return Post(
      id: id ?? this.id,
      message: message ?? this.message,
      type: type ?? this.type,
      link: link ?? this.link,
      imageUrl: imageUrl ?? this.imageUrl,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      user: user ?? this.user,
    );
  }
}