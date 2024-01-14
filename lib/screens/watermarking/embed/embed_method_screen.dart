import 'dart:io';
import 'package:flutter/material.dart';
import 'package:woodefender/services/history_service.dart';
import 'package:woodefender/services/image_service.dart';
import 'package:woodefender/screens/watermarking/embed/embed_result_screen.dart';

class EmbedMethodScreen extends StatefulWidget {
  const EmbedMethodScreen({
    super.key,
    required this.imageOri,
    required this.imageWm,
    required this.title,
  });
  final imageOri;
  final imageWm;
  final title;

  @override
  State<EmbedMethodScreen> createState() => _EmbedMethodScreenState();
}

class _EmbedMethodScreenState extends State<EmbedMethodScreen> {
  Color BtnColor = Colors.grey[200]!;
  Color TextBtnColor = Colors.grey;
  String method = '';
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
                    width: 120,
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
                    width: 100,
                    height: 5,
                  )
                ],
              ),
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
                    width: 100,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12,),
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
                            File(widget.imageOri),
                            fit: BoxFit.cover,
                          )
                        )
                      ]
                    ),
                    Image.asset('assets/images/plusicon.png'),
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
                          width: width * 0.38,
                          height: height * 0.25,
                          padding: EdgeInsets.all(8),
                          child: Image.file(
                            File(widget.imageWm),
                            fit: BoxFit.cover,
                          )
                        )
                      ]
                    ),
                  ] 
                ),
                const SizedBox(height: 20,),
                const Text(
                  'Choose the method for watermarking',
                  style: TextStyle(
                    fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(height: 12,),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: method == 'Robust' ? Colors.black :Colors.grey[200]!,
                    ),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  width: width,
                  height: 180,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Robust',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Container(
                            width: width * 0.78,
                            child: const Text(
                              'Robust watermarks are designed to be resistant to attacks, such as compression, brightness changes, and color changes. This makes them suitable for protecting valuable works, such as copyrighted images and videos.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                              )
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(Colors.white),
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              overlayColor: MaterialStatePropertyAll(Colors.grey),
                              visualDensity: VisualDensity.compact,
                              elevation: MaterialStatePropertyAll(2),
                              fixedSize: MaterialStatePropertyAll(Size(110, 5)),
                              backgroundColor: method == 'Robust' ?
                                const MaterialStatePropertyAll(Colors.black)
                                :
                                MaterialStatePropertyAll(Colors.grey[500])
                                ,
                            ),
                            onPressed: () {
                              setState(() {
                                method = 'Robust';
                              });
                            },
                            child: Text(
                              method == 'Robust' ? 'Selected':'Select',
                              style: TextStyle(
                                fontSize: 14
                              ),
                            )
                          )
                        ],
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 12,),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: method == 'Fragile' ? Colors.black :Colors.grey[200]!,
                    ),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  width: width,
                  height: 180,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Fragile',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Container(
                            width: width * 0.78,
                            child: const Text(
                              'Fragile watermarks are designed to be easily damaged by editing, revealing any tampering. This makes them ideal for authenticating images and protecting their integrity.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                              )
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(Colors.white),
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              overlayColor: MaterialStatePropertyAll(Colors.grey),
                              visualDensity: VisualDensity.compact,
                              elevation: MaterialStatePropertyAll(2),
                              fixedSize: MaterialStatePropertyAll(Size(110, 5)),
                              backgroundColor: method == 'Fragile' ?
                                const MaterialStatePropertyAll(Colors.black)
                                :
                                MaterialStatePropertyAll(Colors.grey[500])
                                ,
                            ),
                            onPressed: () {
                              setState(() {
                                method = 'Fragile';
                              });
                            },
                            child: Text(
                              method == 'Fragile' ? 'Selected':'Select',
                              style: const TextStyle(
                                fontSize: 14
                              ),
                            )
                          )
                        ],
                      ),
                    ],
                  )
                ),
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
              backgroundColor: method != '' ?
              const MaterialStatePropertyAll(Colors.black)
              :
              MaterialStatePropertyAll(Colors.grey[200]!),
            ),
            onPressed: () async {
              if(method != '') {
                setState(() {
                  _isLoading = true;
                });
                if(method == 'Fragile') {
                  final img = await addFragileWm(widget.imageOri, widget.imageWm);

                  await HistoryService().addHistoryWatermark(
                    widget.title,
                    method,
                    ''
                  );

                  Navigator.of(context).push(
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
              }
            },
            child: Text(
              'Confirm',
              style: TextStyle(
                fontSize: 14,
                color: method != '' ? Colors.white : Colors.grey,
              ),
            )
          ),
        ),
      ),
    );
  }
}