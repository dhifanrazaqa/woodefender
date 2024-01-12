import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:woodefender/helper/image_classification_helper.dart';
import 'package:woodefender/screens/classification/result_clf_screen.dart';
import 'package:woodefender/services/image_service.dart';

class ClassificationScreen extends StatefulWidget {
  const ClassificationScreen({
    super.key,
    required this.imageFile,
  });
  final imageFile;

  @override
  State<ClassificationScreen> createState() => _ClassificationScreenState();
}

class _ClassificationScreenState extends State<ClassificationScreen> {
  ImageClassificationHelper? imageClassificationHelper;
  final imagePicker = ImagePicker();
  String? imagePath;
  Uint8List? elaImg;
  img.Image? image;
  Map<String, double>? classification;
  bool cameraIsAvailable = Platform.isAndroid || Platform.isIOS;
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  Color BtnColor = Colors.grey[200]!;
  Color TextBtnColor = Colors.grey;

  @override
  void initState() {
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper!.initHelper();
    imagePath = widget.imageFile;
    _titleController.addListener(checkAllFieldsFilled);
    super.initState();
  }

  void checkAllFieldsFilled() {
    if (_titleController.text.isNotEmpty) {
      setState(() {
        BtnColor = Colors.black;
        TextBtnColor = Colors.white;
      });
    }
  }

  // Clean old results when press some take picture button
  void cleanResult() {
    imagePath = null;
    image = null;
    elaImg = null;
    classification = null;
    setState(() {});
  }

  // Process picked image
  Future<void> processImage() async {
    if (imagePath != null) {
      // Read image bytes from file
      final imageData = elaImg;

      // Decode image using package:image/image.dart (https://pub.dev/image)
      image = img.decodeImage(imageData!);
      setState(() {});
      classification = await imageClassificationHelper?.inferenceImage(image!);
      setState(() {});
    }
  }

  @override
  void dispose() {
    imageClassificationHelper?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Preview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Title',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
                          ),
                          hintText: 'Enter your title for image',
                          hintStyle: TextStyle(
                            color: Colors.grey[400]
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Image.file(File(imagePath!)),
                    const SizedBox(height: 20,),
                    _isLoading ? const CircularProgressIndicator(color: Colors.black,) : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Colors.black)
                              ),
                            ),
                            overlayColor: MaterialStatePropertyAll(Colors.grey),
                            fixedSize: MaterialStatePropertyAll(Size(width * 0.4, 40)),
                            backgroundColor: MaterialStatePropertyAll(Colors.white),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 14
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            overlayColor: MaterialStatePropertyAll(Colors.grey),
                            fixedSize: MaterialStatePropertyAll(Size(width * 0.4, 40)),
                            backgroundColor: MaterialStatePropertyAll(BtnColor),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) { 
                              setState(() {
                                _isLoading = true;
                              });

                              elaImg = await sendImage(imagePath!);
                              
                              await processImage();

                              setState(() {
                                _isLoading = false;
                              });
                              if(classification != null) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => ResultClassificationScreen(
                                      image: widget.imageFile,
                                      classification: classification!.entries.toList(),
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: TextBtnColor,
                              fontSize: 14
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}