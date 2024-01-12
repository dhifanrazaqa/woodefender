import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woodefender/models/Like.dart';
import 'package:woodefender/models/User.dart';
import 'package:woodefender/services/auth_service.dart';
import 'package:woodefender/services/post_service.dart';

class LikeService with ChangeNotifier {
  final CollectionReference _likesCollection =
      FirebaseFirestore.instance.collection('likes');

  List<Like> _likes = [];
  List<Like> get likes => _likes;

  int _likesCount = 0;
  int get likesCount => _likesCount;

  Future<void> fetchLikes() async {
    try {
      QuerySnapshot querySnapshot = await _likesCollection.get();
      _likes = [];

      for (DocumentSnapshot doc in querySnapshot.docs) {
        Like like = Like(
          userId: doc['userId'] ?? '',
          postId: doc['postId'] ?? '',
          createdAt:  (doc['createdAt'] as Timestamp).toDate(),
        );

        _likes.add(like);
      }
      notifyListeners();
    } catch (e) {
      print("Error fetching posts: $e");
    }
  }

  Future<int?> fetchLikeByPostId(String postId) async {
    try {
      DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
      QuerySnapshot querySnapshot = await _likesCollection.where('postId', isEqualTo: postRef).get();
      
      return querySnapshot.size;
    } catch (e) {
      print("Error fetching likes: $e");
    }
  }

  Future<bool> isPostLikedByUser(String postId, String userId) async {
  try {
    DocumentReference userRef = AuthService().getCurrentUserReference();
    DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(postId);

    QuerySnapshot querySnapshot = await _likesCollection
        .where('postId', isEqualTo: postRef)
        .where('userId', isEqualTo: userRef)
        .get();
    return querySnapshot.size > 0; // Mengembalikan true jika dokumen like ditemukan
  } catch (e) {
    print("Error checking if post is liked by user: $e");
    return false;
  }
}

  Future<void> addLike(String postId) async {
    try {
      // Menambahkan likeingan baru ke Firestore
      DocumentReference currentUser = AuthService().getCurrentUserReference();
      DocumentReference currentPost = PostService().getPostReference(postId);
      
      final createdAt = DateTime.now();

      _likes.add(Like(
        postId: currentPost,
        userId: currentUser,
        createdAt: createdAt
      ));
      notifyListeners();

      await _likesCollection.add({
        'createdAt':  createdAt,
        'postId': currentPost,
        'userId': currentUser,
      });
    } catch (e) {
      print("Error adding like: $e");
    }
  }

  Future<void> deleteLike(String postId) async {
    try {
      // Menambahkan likeingan baru ke Firestore
      DocumentReference currentUser = AuthService().getCurrentUserReference();
      DocumentReference currentPost = PostService().getPostReference(postId);

      _likes.removeWhere((like) => like.userId == currentUser && like.postId == currentPost);
      notifyListeners();

      QuerySnapshot querySnapshot = await _likesCollection
        .where('userId', isEqualTo: currentUser)
        .where('postId', isEqualTo: currentPost)
        .limit(1)
        .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        print('Like removed successfully.');
      } else {
        print('Like not found.');
      }
    } catch (e) {
      print("Error delete like: $e");
    }
  }
}