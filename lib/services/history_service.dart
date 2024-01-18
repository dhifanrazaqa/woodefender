import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woodefender/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HistoryService {
  final CollectionReference _classificationCollection =
      FirebaseFirestore.instance.collection('classifications');
  final CollectionReference _watermarkCollection =
      FirebaseFirestore.instance.collection('watermarks');

  List<Map<String, dynamic>> _classifications = [];
  List<Map<String, dynamic>> _watermarks = [];

  List<Map<String, dynamic>> get classifications => _classifications;
  List<Map<String, dynamic>> get watermarks => _watermarks;

  Future<void> fetchClassificationsByUserId() async {
    try {
      final userRef = AuthService().getCurrentUserReference();
      QuerySnapshot querySnapshot = await _classificationCollection
      .where('userId', isEqualTo: userRef)
      .get();

      _classifications = [];

      for (DocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> classification = {
          'id': doc.id,
          'title': doc['title'] ?? '',
          'createdAt':  (doc['createdAt'] as Timestamp).toDate(),
          'original': doc['original'] ?? 0,
          'edited': doc['edited'] ?? 0,
          'userId': doc['userId'] ?? '',
        };
        _classifications.add(classification);
        print(_classifications);
      }
    } catch (e) {
      print("Error fetching historys: $e");
    }
  }

  Future<void> fetchWatermarksByUserId() async {
    try {
      final userRef = AuthService().getCurrentUserReference();
      QuerySnapshot querySnapshot = await _watermarkCollection
      .where('userId', isEqualTo: userRef)
      .get();
      _watermarks = [];

      for (DocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> watermark = {
          'id': doc.id,
          'title': doc['title'] ?? '',
          'createdAt':  (doc['createdAt'] as Timestamp).toDate(),
          'type': doc['type'] ?? '',
          'wm_size': doc['wm_size'] ?? 0,
          'wm_url': doc['wm_url'] ?? '',
          'userId': doc['userId'] ?? '',
        };
        _watermarks.add(watermark);
      }
    } catch (e) {
      print("Error fetching historys: $e");
    }
  }

  Future<void> addHistoryClassification(String title, double original, double edited) async {
    try {
      final currentUser = AuthService().getCurrentUserReference();

      await _classificationCollection.add({
        'title': title,
        'createdAt':  DateTime.now(),
        'original': original,
        'edited': edited,
        'userId': currentUser,
      });
    } catch (e) {
      print("Error adding history: $e");
    }
  }

  Future<String?> addImage(File? image) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('uploads/${DateTime.now().toString()}');

      await storageReference.putFile(image!);
      final imageUrl = await storageReference.getDownloadURL();

      return imageUrl;
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<void> addHistoryWatermark(String title, String type, String wmSize, File image) async {
    try {
      final wmUrl = await addImage(image);
      final currentUser = AuthService().getCurrentUserReference();
        await _watermarkCollection.add({
          'title': title,
          'createdAt':  DateTime.now(),
          'type': type,
          'wm_size': wmSize,
          'wm_url': wmUrl,
          'userId': currentUser,
        });
    } catch (e) {
      print("Error adding history: $e");
    }
  }
}