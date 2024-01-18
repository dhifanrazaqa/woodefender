import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:woodefender/services/history_service.dart';
import 'package:woodefender/services/image_service.dart';
import 'package:woodefender/screens/watermarking/embed/embed_result_screen.dart';
import 'package:path_provider/path_provider.dart';

class EmbedFinalScreen extends StatefulWidget {
  const EmbedFinalScreen({
    super.key,
    required this.imageOri,
    required this.imageWm,
    required this.title,
    required this.method,
  });
  final imageOri;
  final imageWm;
  final title;
  final method;

  @override
  State<EmbedFinalScreen> createState() => _EmbedFinalScreenState();
}

class _EmbedFinalScreenState extends State<EmbedFinalScreen> {
  Color BtnColor = Colors.grey[200]!;
  Color TextBtnColor = Colors.grey;
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
                const SizedBox(height: 12,),
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
                      width: width,
                      height: height * 0.3,
                      padding: EdgeInsets.all(8),
                      child: Image.file(
                        File(widget.imageOri),
                        fit: BoxFit.cover,
                      )
                    )
                  ]
                ),
                const SizedBox(height: 12,),
                Image.asset('assets/images/plusicon.png'),
                const SizedBox(height: 12,),
                Column(
                  children: [
                    const Text(
                      'Watermark Image',
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
                      width: width,
                      height: height * 0.3,
                      padding: EdgeInsets.all(8),
                      child: widget.imageWm is Uint8List ? 
                      Image.memory(
                        widget.imageWm,
                        fit: BoxFit.cover,
                      )
                      : 
                      Image.file(
                        File(widget.imageWm),
                        fit: BoxFit.cover,
                      )
                    )
                  ]
                ),
                const SizedBox(height: 20,),
              ]
            ),
          ),
        ),
        bottomNavigationBar: _isLoading ? const Center(child: CircularProgressIndicator(color: Colors.black,)) : Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.white),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              overlayColor: MaterialStatePropertyAll(Colors.grey),
              elevation: MaterialStatePropertyAll(2),
              fixedSize: MaterialStatePropertyAll(Size(width, 40)),
              backgroundColor: MaterialStatePropertyAll(Colors.black)
            ),
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              if(widget.method == 'Fragile') {
                final img = await addFragileWm(widget.imageOri, widget.imageWm);

                await HistoryService().addHistoryWatermark(
                  widget.title,
                  widget.method,
                  '',
                  File(widget.imageWm)
                );

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => EmbedResultScreen(
                      imageResult: img,
                      title: widget.title
                    ),
                  ),
                );
              } else {
                final img = await addRobustWm(widget.imageOri, widget.imageWm);
                final String dir = (await getApplicationDocumentsDirectory()).path;
                final imagePath = '$dir/file_name${DateTime.now()}.png';
                final capturedFile = File(imagePath);
                await capturedFile.writeAsBytes(widget.imageWm);

                await HistoryService().addHistoryWatermark(
                  widget.title,
                  widget.method,
                  '',
                  capturedFile
                );

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => EmbedResultScreen(
                      imageResult: img,
                      title: widget.title
                    ),
                  ),
                );
              }
              setState(() {
                _isLoading = false;
              });
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => EmbedResultScreen(imageResult: widget.imageOri,),
              //   ),
              // );
            },
            child: const Text(
              'Confirm',
              style: TextStyle(
                fontSize: 14,
                color:Colors.white,
              ),
            )
          ),
        ),
      ),
    );
  }
}