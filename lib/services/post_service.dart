import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woodefender/models/Post.dart';
import 'package:woodefender/models/User.dart';
import 'package:woodefender/services/auth_service.dart';
import 'package:woodefender/services/like_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostService with ChangeNotifier {
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<void> fetchPosts() async {
    try {
      print("Sini");
      DocumentReference currentUser = AuthService().getCurrentUserReference();
      QuerySnapshot querySnapshot = await _postsCollection.orderBy('createdAt', descending: true).get();
      _posts = [];

      for (DocumentSnapshot doc in querySnapshot.docs) {
        // Mendapatkan jumlah like untuk masing-masing post
        int? likesCount = await LikeService().fetchLikeByPostId(doc.id);
        bool? isLiked = await LikeService().isPostLikedByUser(doc.id, currentUser.id);
        User? user = await getUserByReference(doc['userId']);

        Post post = Post(
          id: doc.id,
          message: doc['message'] ?? '',
          type: doc['type'] ?? '',
          link: doc['link'] ?? '',
          imageUrl: doc['imageUrl'] ?? '',
          likeCount: likesCount,
          isLiked: isLiked,
          createdAt:  (doc['createdAt'] as Timestamp).toDate(),
          user: user,
        );

        _posts.add(post);
      }
      notifyListeners();
    } catch (e) {
      print("Error fetching posts: $e");
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
          imageUrl: userSnapshot['imageUrl'] ?? '',
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting user by reference: $e");
      return null;
    }
  }

  DocumentReference getPostReference(String postId) {
    return FirebaseFirestore.instance.collection('posts').doc(postId);
  }

  Future<String?> uploadImage(File? image) async {
    try {
      // Mendapatkan referensi Firebase Storage
      Reference storageReference = FirebaseStorage.instance.ref().child('uploads/${DateTime.now().toString()}');

      // Upload file ke Firebase Storage
      await storageReference.putFile(image!);

      // Mendapatkan URL download file yang diupload
      return await storageReference.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<void> addPost(Post post, File? image) async {
    try {
      String? imageUrl = '';
      if (image != null) {
        imageUrl = await uploadImage(image);
      }

      await _postsCollection.add({
        'message': post.message,
        'type': post.type,
        'link': post.link,
        'imageUrl': imageUrl,
        'createdAt':  post.createdAt,
        'userId': post.userId,
      });

      // await fetchPosts();
    } catch (e) {
      print("Error adding post: $e");
    }
  }

  Future<void> updatePost(
      {required String postId, required String title, required String content}) async {
    try {
      // Memperbarui postingan di Firestore
      await _postsCollection.doc(postId).update({
        'title': title,
        'content': content,
      });
      // Mengambil ulang data postingan setelah pembaruan
      await fetchPosts();
    } catch (e) {
      print("Error updating post: $e");
    }
  }

  Future<void> deletePost({required String postId}) async {
    try {
      // Menghapus postingan dari Firestore
      await _postsCollection.doc(postId).delete();
      // Mengambil ulang data postingan setelah penghapusan
      await fetchPosts();
    } catch (e) {
      print("Error deleting post: $e");
    }
  }
}