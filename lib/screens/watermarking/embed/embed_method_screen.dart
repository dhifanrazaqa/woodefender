import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:woodefender/screens/watermarking/embed/embed_ori_screen.dart';

class EmbedMethodScreen extends StatefulWidget {
  const EmbedMethodScreen({super.key});

  @override
  State<EmbedMethodScreen> createState() => _EmbedMethodScreenState();
}

class _EmbedMethodScreenState extends State<EmbedMethodScreen> {
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
                    color: Colors.grey[300],
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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    color: Colors.black,
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
                            backgroundColor: const MaterialStatePropertyAll(Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const EmbedOriScreen(
                                  method: 'Robust',
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Select',
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
                    color: Colors.black
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
                            backgroundColor: const MaterialStatePropertyAll(Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const EmbedOriScreen(
                                  method: 'Fragile',
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Select',
                            style: TextStyle(
                              fontSize: 14
                            ),
                          )
                        )
                      ],
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}