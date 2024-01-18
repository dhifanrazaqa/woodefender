import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woodefender/models/Post.dart';
import 'package:woodefender/screens/main_screen.dart';
import 'package:woodefender/services/auth_service.dart';
import 'package:woodefender/services/post_service.dart'; // Sesuaikan dengan nama file dan lokasi PostProvider Anda
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({
    super.key,
    required this.text,
  });
  final String text;

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  String _selectedType = 'Post';

  Color BtnColor = Colors.grey[200]!;
  Color TextBtnColor = Colors.grey;

  bool _isLoading = false;

  File? _selectedFile;
  final picker = ImagePicker();

  Future<void> _pickFile() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.text;
    _descriptionController.addListener(checkAllFieldsFilled);
    _linkController.addListener(checkAllFieldsFilled);
  }

  void checkAllFieldsFilled() {
    if (_selectedType == 'Post') {
      if (_descriptionController.text.isNotEmpty) {
        setState(() {
          BtnColor = Colors.black;
          TextBtnColor = Colors.white;
        });
      }
    } else {
      if (_descriptionController.text.isNotEmpty && _linkController.text.isNotEmpty) {
        setState(() {
          BtnColor = Colors.black;
          TextBtnColor = Colors.white;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    PostService postProvider = Provider.of<PostService>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Create a Post',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButton<String>(
                      value: _selectedType,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedType = newValue!;
                        });
                      },
                      underline: Container(),
                      items: <String>['Post', 'Report']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 8.0),
                    const Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 8,),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      maxLength: 1500,
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
                        hintText: "What's on your mind?",
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

                    if (_selectedType == 'Report')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.0),
                          const Text(
                            'Source',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 8.0),
                          TextFormField(
                            controller: _linkController,
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
                              hintText: 'Enter link to the report source (Facebook, X, TikTok, Instagram or YouTube)',
                              hintStyle: TextStyle(
                                color: Colors.grey[400]
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (!RegExp(
                                      r'^(https?://)?(www\.)?(twitter\.com|x\.com|vt.tiktok\.com|facebook\.com|instagram\.com|youtube\.com|tiktok\.com)/')
                                  .hasMatch(value)) {
                                return 'Please enter a valid social media link';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              _selectedFile != null ? 
              Column(
                children: [
                  const SizedBox(height: 16,),
                  Image.file(_selectedFile!),
                  const SizedBox(height: 16,),
                ],
              )
              :
              SizedBox(height: height * 0.15),
              InkWell(
                onTap: () async {
                  await _pickFile();
                },
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/images/unggah.png'),
              ),
              SizedBox(height: 16.0),
              _isLoading ? const CircularProgressIndicator(color: Colors.black,) : ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  fixedSize: MaterialStatePropertyAll(Size(width, 40)),
                  backgroundColor: MaterialStatePropertyAll(BtnColor),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) { 
                    setState(() {
                      _isLoading = true;
                    });
        
                    DocumentReference currentUserId = AuthService().getCurrentUserReference();
            
                    await postProvider.addPost(
                      Post(
                        message: _descriptionController.text,
                        type: _selectedType,
                        link: _linkController.text,
                        createdAt: DateTime.now(),
                        userId: currentUserId,
                      ),
                      _selectedFile
                    );

                    if(widget.text != '') {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(pageIndex: 1,),
                        ),
                      );
                    } else {
                      Navigator.pop(context, 'Success');
                    }
        
                    setState(() {
                      _isLoading = true;
                    });
                  }
                },
                child: Text(
                  'Post',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: TextBtnColor,
                    fontSize: 14
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
