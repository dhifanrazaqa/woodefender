import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/material.dart';

class ResultWmScreen extends StatefulWidget {
  const ResultWmScreen({
    super.key,
    required this.resImg,
  });
  final Uint8List resImg;

  @override
  State<ResultWmScreen> createState() => _ResultWmScreenState();
}

class _ResultWmScreenState extends State<ResultWmScreen> {
  Future<void> saveImageToGallery() async {
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(widget.resImg));
      print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.memory(
            widget.resImg,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: saveImageToGallery,
            child: Text('Save to Gallery'),
          ),
        ],
      ),
    );
  }
}