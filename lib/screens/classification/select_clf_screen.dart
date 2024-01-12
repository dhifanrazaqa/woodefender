import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woodefender/screens/classification/classification_screen.dart';

class SelectClassificationScreen extends StatefulWidget {
  const SelectClassificationScreen({super.key});

  @override
  State<SelectClassificationScreen> createState() => _SelectClassificationScreenState();
}

class _SelectClassificationScreenState extends State<SelectClassificationScreen> {
  final imagePicker = ImagePicker();
  String? imagePath;
  bool cameraIsAvailable = Platform.isAndroid || Platform.isIOS;
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: height * 0.35),
          child: Column(
            children: [
              if (cameraIsAvailable)
                InkWell(
                  onTap: () async {
                    final result = await imagePicker.pickImage(
                      source: ImageSource.camera,
                    );

                    if(result != null) {
                    imagePath = result.path;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ClassificationScreen(
                          imageFile: imagePath,
                        ),
                      ),
                    );
                  }
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/images/takepicture.png'),
                ),
              const SizedBox(height: 14,),
              InkWell(
                onTap: () async {
                  final result = await imagePicker.pickImage(
                    source: ImageSource.gallery,
                  );

                  if(result != null) {
                    imagePath = result.path;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ClassificationScreen(
                          imageFile: imagePath,
                        ),
                      ),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/images/selectgallery.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}