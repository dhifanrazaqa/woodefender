import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woodefender/screens/watermarking/extract/extract_method_screen.dart';
import 'package:woodefender/services/image_service.dart';

class ExtractWmScreen extends StatefulWidget {
  const ExtractWmScreen({
    super.key,
    required this.wm_size,
    required this.type
  });
  final wm_size;
  final type;

  @override
  State<ExtractWmScreen> createState() => _ExtractWmScreenState();
}

class _ExtractWmScreenState extends State<ExtractWmScreen> {
  final imagePicker = ImagePicker();
  String? imagePath;
  bool cameraIsAvailable = Platform.isAndroid || Platform.isIOS;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    'Select the config',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '(Configuration)',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600]
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    color: Colors.red,
                    width: width * 0.29,
                    height: 5,
                  )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Select the image',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '(Original + Watermark)',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600]
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    color: Colors.red,
                    width: width * 0.29,
                    height: 5,
                  )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Extracting',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '(Watermark)',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600]
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    color: Colors.grey[300],
                    width: width * 0.29,
                    height: 5,
                  )
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 18.0),
            child: Column(
              children: [
                if(imagePath == null)
                Padding(
                  padding: EdgeInsets.only(top: height * 0.2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Extract Feature',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      const Text(
                        'Select the image',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey
                        )
                      ),
                      const SizedBox(height: 30,),
                      InkWell(
                        onTap: () async {
                          final result = await imagePicker.pickImage(
                            source: ImageSource.gallery,
                          );
          
                          imagePath = result?.path;
                          setState(() {
                            
                          });
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset('assets/images/selectgallery.png'),
                      ),
                    ],
                  ),
                ),
                if(imagePath != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 12.0),
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
                            backgroundColor: const MaterialStatePropertyAll(Colors.black),
                          ),
                          onPressed: () async {
                            if(imagePath != null) {
                              if(widget.type == 'Fragile') {
                                setState(() {
                                  _isLoading = true;
                                });

                                final img = await extrFragileWm(imagePath!);

                                setState(() {
                                  _isLoading = false;
                                });

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ExtractMethodScreen(
                                      image: imagePath,
                                      imageWm: img
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text(
                            'Confirm',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 14
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}