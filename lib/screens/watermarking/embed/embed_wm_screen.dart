import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woodefender/screens/watermarking/embed/embed_final_screen.dart';

class EmbedWmScreen extends StatefulWidget {
  const EmbedWmScreen({
    super.key,
    required this.imageOri,
    required this.title,
    required this.method,
  });
  final imageOri;
  final title;
  final method;

  @override
  State<EmbedWmScreen> createState() => _EmbedWmScreenState();
}

class _EmbedWmScreenState extends State<EmbedWmScreen> {
  final imagePicker = ImagePicker();
  String? imagePath;
  bool cameraIsAvailable = Platform.isAndroid || Platform.isIOS;

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
                    'Choose method',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '(Fragile/Robust)',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600]
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    color: Colors.red,
                    width: width * 0.3,
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
                    '(Original)',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600]
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    color: Colors.red,
                    width: width * 0.3,
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
                    '(Watermark)',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600]
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Container(
                    color: Colors.red,
                    width: width * 0.3,
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
                        'Embed Feature',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      const Text(
                        'Select the watermark image',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey
                        )
                      ),
                      const SizedBox(height: 30,),
                      if (cameraIsAvailable)
                        InkWell(
                          onTap: () async {
                            final result = await imagePicker.pickImage(
                              source: ImageSource.camera,
                            );
          
                            imagePath = result?.path;
                            setState(() {
                              
                            });
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
                    const SizedBox(height: 20,),
                    Image.file(File(imagePath!)),
                    const SizedBox(height: 20,),
                    Row(
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
                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          onPressed: () async {
                              if(imagePath != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EmbedFinalScreen(
                                      imageOri: widget.imageOri,
                                      imageWm: imagePath,
                                      title: widget.title,
                                      method: widget.method,
                                    ),
                                  ),
                                );
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