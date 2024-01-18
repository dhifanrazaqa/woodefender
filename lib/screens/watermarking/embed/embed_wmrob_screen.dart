import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:woodefender/screens/watermarking/embed/embed_final_screen.dart';
import 'package:woodefender/services/image_service.dart';

class EmbedWmRobScreen extends StatefulWidget {
  const EmbedWmRobScreen({
    super.key,
    required this.imageOri,
    required this.title,
    required this.method,
  });
  final imageOri;
  final title;
  final method;    

  @override
  State<EmbedWmRobScreen> createState() => _EmbedWmRobScreenState();
}

class _EmbedWmRobScreenState extends State<EmbedWmRobScreen> {
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  Color BtnColor = Colors.grey[200]!;
  Color TextBtnColor = Colors.grey;

  Uint8List? imageWm;

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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Watermark',
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
                      hintText: 'Enter your watermark text',
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
                if(imageWm != null)
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      width: width,
                      height: height * 0.5,
                      padding: EdgeInsets.all(8),
                      child: Image.memory(
                        imageWm!,
                        fit: BoxFit.fitWidth,
                      )
                    ),
                    const SizedBox(height: 20,)
                  ]
                ),
                _isLoading ? const CircularProgressIndicator(color: Colors.black,) : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          imageWm =  await getWm(_titleController.text);

                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: const Text(
                        'Get Watermark',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
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
                        backgroundColor: imageWm != null ? 
                        MaterialStatePropertyAll(Colors.black)
                        :
                        MaterialStatePropertyAll(Colors.grey[200]),
                      ),
                      onPressed: () async {
                        if(imageWm != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EmbedFinalScreen(
                                imageOri: widget.imageOri,
                                imageWm: imageWm,
                                title: widget.title,
                                method: widget.method,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: imageWm != null ? Colors.white : Colors.grey,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ),
        )
      ),
    );
  }
}