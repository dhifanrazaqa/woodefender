import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:woodefender/models/User.dart' as user_data;
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  Future<String?> registration({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      await addAdditionalUserInfo(user!.uid, username, email);

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<user_data.User?> getUserData() async {
    DocumentSnapshot documentSnapshot = await getCurrentUserReference().get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;

      return user_data.User(
        email: userData['email'],
        username: userData['username'],
        imageUrl: userData['imageUrl'],
      );
    } else {
      return null;
    }
  }

  Future<void> addUserImage(File? image) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('uploads/${DateTime.now().toString()}');
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await storageReference.putFile(image!);
      final imageUrl = await storageReference.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'imageUrl': imageUrl
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  DocumentReference getCurrentUserReference() {
    User? user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance.collection('users').doc(user!.uid);
  }

  Future<void> addAdditionalUserInfo(String uid, String username, String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username,
        'email': email,
        'imageUrl': ''
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final uid = FirebaseAuth.instance.currentUser!.uid;

      await addAdditionalUserInfo(uid, googleUser!.displayName!, googleUser.email);
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-credential') {
        return 'Wrong email or password.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> isUserLoggedIn() async {
    final User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}