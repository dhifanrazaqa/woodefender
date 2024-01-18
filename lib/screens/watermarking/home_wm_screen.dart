import 'package:flutter/material.dart';
import 'package:woodefender/screens/watermarking/embed/embed_method_screen.dart';
import 'package:woodefender/screens/watermarking/embed/embed_ori_screen.dart';
import 'package:woodefender/screens/watermarking/extract/extract_select_screen.dart';
import 'package:woodefender/screens/watermarking/extract/extract_wm_screen.dart';
import 'package:woodefender/screens/watermarking/frag_wm_screen.dart';

class WmScreen extends StatelessWidget {
  const WmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Watermarking Feature',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 18,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[200]!,
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
                        'Embed',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Container(
                        width: width * 0.78,
                        child: const Text(
                          'The embed function is used to add a watermark to an image. The purpose of watermarking is to protect the copyright of an image or to mark an image as belonging to someone.',
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
                          backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const EmbedMethodScreen(),
                            ),
                          );
                        },
                        child: const Text(
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
            const SizedBox(height: 18,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[200]!,
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
                        'Extract',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Container(
                        width: width * 0.78,
                        child: const Text(
                          'The extract function is used to remove a watermark from an image. The watermark can be removed for the purpose of identification, authentication, or even to remove the watermark.',
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
                          backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ExtractSelectScreen(),
                            ),
                          );
                        },
                        child: const Text(
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
          ]
        ),
      ),
    );
  }
}