import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woodefender/models/Comment.dart';
import 'package:woodefender/models/User.dart';
import 'package:woodefender/services/auth_service.dart';
import 'package:woodefender/services/post_service.dart';

class CommentService with ChangeNotifier {
  final CollectionReference _commentsCollection =
      FirebaseFirestore.instance.collection('comments');

  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  Future<void> fetchCommentsByPostId(String postId) async {
    try {
      DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
      QuerySnapshot querySnapshot = await _commentsCollection.where('postId', isEqualTo: postRef).orderBy('createdAt', descending: true).get();
      _comments = [];

      for (DocumentSnapshot doc in querySnapshot.docs) {
        User? user = await getUserByReference(doc['userId']);

        Comment comment = Comment(
          id: doc.id,
          message: doc['message'] ?? '',
          createdAt:  (doc['createdAt'] as Timestamp).toDate(),
          postId: doc['postId'] ?? '',
          userId: doc['userId'] ?? '',
          user: user
        );

        _comments.add(comment);
      }
      notifyListeners();
    } catch (e) {
      print("Error fetching comments: $e");
    }
  }

  Future<User?> getUserByReference(DocumentReference userReference) async {
    try {
      DocumentSnapshot userSnapshot = await userReference.get();

      if (userSnapshot.exists) {
        return User(
          id: userSnapshot.id,
          email: userSnapshot['email'] ?? '',
          username: userSnapshot['username'] ?? '',
          imageUrl: userSnapshot['imageUrl'] ?? ''
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting user by reference: $e");
      return null;
    }
  }

  Future<void> addComment(String message, String postId) async {
    try {
      // Menambahkan commentingan baru ke Firestore
      DocumentReference currentUser = AuthService().getCurrentUserReference();
      DocumentReference currentPost = PostService().getPostReference(postId);
      await _commentsCollection.add({
        'message': message,
        'createdAt':  DateTime.now(),
        'postId': currentPost,
        'userId': currentUser,
      });
      // Mengambil ulang data commentingan setelah penambahan
      // await fetchCommentsByPostId();
    } catch (e) {
      print("Error adding comment: $e");
    }
  }
}