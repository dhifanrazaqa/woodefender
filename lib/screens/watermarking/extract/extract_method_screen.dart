import 'dart:io';
import 'package:flutter/material.dart';
import 'package:woodefender/screens/watermarking/extract/extract_preview_screen.dart';
import 'package:woodefender/screens/watermarking/success_wm_screen.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class ExtractMethodScreen extends StatefulWidget {
  const ExtractMethodScreen({
    super.key,
    required this.image,
    required this.imageWm,
    required this.title,
    required this.wm_url,
  });
  final image;
  final imageWm;
  final title;
  final wm_url;

  @override
  State<ExtractMethodScreen> createState() => _ExtractMethodScreenState();
}

class _ExtractMethodScreenState extends State<ExtractMethodScreen> {
  Color BtnColor = Colors.grey[200]!;
  Color TextBtnColor = Colors.grey;
  String method = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future<dynamic> saveImageToGallery() async {
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final imagePath = '$dir/file_name${DateTime.now()}.png';
      final capturedFile = File(imagePath);
      await capturedFile.writeAsBytes(widget.imageWm);

      final result = await ImageGallerySaver.saveFile(
        capturedFile.path,
        name: widget.title
      );

      return result;
    }

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
                    color: Colors.red,
                    width: width * 0.29,
                    height: 5,
                  )
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Original Image',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        width: width * 0.38,
                        height: height * 0.25,
                        padding: EdgeInsets.all(8),
                        child: Image.file(
                          File(widget.image),
                          fit: BoxFit.cover,
                        )
                      )
                    ]
                  ),
                  Image.asset('assets/images/arrowicon.png'),
                  Column(
                    children: [
                      const Text(
                        'Original Watermark',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        width: width * 0.38,
                        height: height * 0.25,
                        padding: EdgeInsets.all(8),
                        child: Image.network(widget.wm_url,
                          fit: BoxFit.cover,
                        )
                      ),
                      const Text(
                        'Current Watermark',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        width: width * 0.38,
                        height: height * 0.25,
                        padding: EdgeInsets.all(8),
                        child: Image.memory(widget.imageWm,
                          fit: BoxFit.cover,
                        )
                      )
                    ]
                  ),
                ] 
              ),
              const SizedBox(height: 60,),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.black),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  overlayColor: MaterialStatePropertyAll(Colors.grey[200]),
                  elevation: MaterialStatePropertyAll(2),
                  fixedSize: MaterialStatePropertyAll(Size(width, 40)),
                  backgroundColor: const MaterialStatePropertyAll(Colors.white)
                ),
                onPressed: () async {
                  final msg = await saveImageToGallery();
                  print(msg);
                  if(msg['isSuccess']) {
                    const snackBar = SnackBar(
                      content: Text('Image saved to gallery!'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download, size: 20),
                    const SizedBox(width: 12,),
                    Text(
                      'Download Watermark Image',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.black),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  overlayColor: MaterialStatePropertyAll(Colors.grey[200]),
                  elevation: MaterialStatePropertyAll(2),
                  fixedSize: MaterialStatePropertyAll(Size(width, 40)),
                  backgroundColor: const MaterialStatePropertyAll(Colors.white)
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ExtractPreviewScreen(
                        imageWm: widget.imageWm,
                        wm_url: widget.wm_url,
                      ),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.remove_red_eye, size: 20),
                    const SizedBox(width: 12,),
                    Text(
                      'Preview Watermark Image',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  overlayColor: MaterialStatePropertyAll(Colors.grey),
                  elevation: MaterialStatePropertyAll(2),
                  fixedSize: MaterialStatePropertyAll(Size(width, 40)),
                  backgroundColor: const MaterialStatePropertyAll(Colors.black)
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SuccessWmScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}