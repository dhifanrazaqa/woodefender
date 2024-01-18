import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woodefender/screens/watermarking/embed/embed_wm_screen.dart';
import 'package:woodefender/screens/watermarking/embed/embed_wmrob_screen.dart';
import 'package:image_cropper/image_cropper.dart';

class EmbedOriScreen extends StatefulWidget {
  const EmbedOriScreen({
    super.key,
    required this.method,
  });
  final method;

  @override
  State<EmbedOriScreen> createState() => _EmbedOriScreenState();
}

class _EmbedOriScreenState extends State<EmbedOriScreen> {
  final imagePicker = ImagePicker();
  String? imagePath;
  bool cameraIsAvailable = Platform.isAndroid || Platform.isIOS;

  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  Color BtnColor = Colors.grey[200]!;
  Color TextBtnColor = Colors.grey;

  @override
  void initState() {
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

  Future _cropImage() async { 
    if (imagePath != null) { 
      CroppedFile? cropped = await ImageCropper().cropImage( 
          sourcePath: imagePath!,
          aspectRatioPresets:  
               [ 
                  CropAspectRatioPreset.square, 
                  CropAspectRatioPreset.ratio3x2, 
                  CropAspectRatioPreset.original, 
                  CropAspectRatioPreset.ratio4x3, 
                  CropAspectRatioPreset.ratio16x9 
                ],
          uiSettings: [ 
            AndroidUiSettings( 
                toolbarTitle: 'Crop', 
                cropGridColor: Colors.black, 
                initAspectRatio: CropAspectRatioPreset.original, 
                lockAspectRatio: false), 
            IOSUiSettings(title: 'Crop') 
          ]); 
  
      if (cropped != null) { 
        setState(() { 
          imagePath = cropped.path; 
        }); 
      } 
    } 
  }

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
                    color: Colors.grey[300],
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
                        'Select the original image',
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
                              if(imagePath != null) {
                                if(widget.method == 'Robust') {
                                  
                                  CroppedFile? croppedFile = await ImageCropper().cropImage(
                                    sourcePath: imagePath!,
                                    aspectRatioPresets: [
                                      CropAspectRatioPreset.square,
                                    ],
                                    uiSettings: [
                                      AndroidUiSettings(
                                        toolbarTitle: 'Cropper',
                                        toolbarColor: Colors.deepOrange,
                                        toolbarWidgetColor: Colors.white,
                                        initAspectRatio: CropAspectRatioPreset.square,
                                        lockAspectRatio: true
                                      ),
                                    ],
                                  );

                                  imagePath = croppedFile?.path;

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EmbedWmRobScreen(
                                        imageOri: imagePath,
                                        title: _titleController.text,
                                        method: widget.method,
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EmbedWmScreen(
                                        imageOri: imagePath,
                                        title: _titleController.text,
                                        method: widget.method,
                                      ),
                                    ),
                                  );
                                }
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}