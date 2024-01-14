import 'dart:io';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:woodefender/screens/watermarking/success_wm_screen.dart';

class EmbedResultScreen extends StatefulWidget {
  const EmbedResultScreen({
    super.key,
    required this.imageResult,
    required this.title,
  });
  final imageResult;
  final title;

  @override
  State<EmbedResultScreen> createState() => _EmbedResultScreenState();
}

class _EmbedResultScreenState extends State<EmbedResultScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future<dynamic> saveImageToGallery() async {
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final imagePath = '$dir/file_name${DateTime.now()}.png';
      final capturedFile = File(imagePath);
      await capturedFile.writeAsBytes(widget.imageResult);

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
          title: Text(
            'Result',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Image.memory(widget.imageResult),
                const SizedBox(height: 24,),
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
                        'Download Image',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}