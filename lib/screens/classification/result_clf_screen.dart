import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:woodefender/screens/community/add_comm_screen.dart';

class ResultClassificationScreen extends StatelessWidget {
  const ResultClassificationScreen({
    super.key,
    this.image,
    this.classification
  });
  final image;
  final classification;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Result',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Classification',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Center(child: Image.file(File(image))),
                    const SizedBox(height: 16,),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(5)
                          ),
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 10,),
                        const Text(
                          "Original",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${(classification[0].value * 100).toStringAsFixed(1)}%",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey[200],),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 10,),
                        const Text(
                          "Edited",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${(classification[1].value * 100).toStringAsFixed(1)}%",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey[200],),
                  ],
                ),
              ),
              Divider(color: Colors.grey[200], thickness: 12),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  width: width,
                  height: 150,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Post to Report Page',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Container(
                            width: width * 0.85,
                            child: const Text(
                              'invite others to help report the source of the image abuse',
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
                                  builder: (context) => AddPostScreen(
                                    text: 'Original: ${(classification[0].value * 100).toStringAsFixed(1)}%\nEdited: ${(classification[1].value * 100).toStringAsFixed(1)}%\n',
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Try Now!',
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
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  width: width,
                  height: 150,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '#StopNCII',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Container(
                            width: width * 0.85,
                            child: const Text(
                              'A community that will help you to evaluate content abuse and remove it',
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
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => const SelectClassificationScreen(),
                              //   ),
                              // );
                            },
                            child: Text(
                              'Try Now!',
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
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  width: width,
                  height: 150,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'The Authorities',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Container(
                            width: width * 0.85,
                            child: const Text(
                              'Forward the report to the authorities to be followed up as a violation of the UU ITE.',
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
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => const SelectClassificationScreen(),
                              //   ),
                              // );
                            },
                            child: Text(
                              'Try Now!',
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
              ),
              Padding(
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
                    backgroundColor: const MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                    // Navigator.of(context).pop();
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 14
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}