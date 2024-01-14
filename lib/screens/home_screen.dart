import 'package:flutter/material.dart';
import 'package:woodefender/screens/classification/classification_screen.dart';
import 'package:woodefender/screens/classification/select_clf_screen.dart';
import 'package:woodefender/screens/history/classification_hist_screen.dart';
import 'package:woodefender/screens/history/watermark_hist_screen.dart';
import 'package:woodefender/screens/watermarking/home_wm_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              color: Colors.black,
              width: width,
              height: height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    width: width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.white
                      )
                    ),
                    child: const Text(
                      'Protect Yourself',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "You have two reliable features here to safeguard your privacy from naughty digital content. They are experts in warding off changes to your personal data, so you're safe!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
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
                          'Classification',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        const Text(
                          'Stay Cool Online! Digital Content\nDetection Feature to Keep Your\nActivities Fun and Safe',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey
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
                            visualDensity: VisualDensity.compact,
                            elevation: MaterialStatePropertyAll(2),
                            fixedSize: MaterialStatePropertyAll(Size(110, 5)),
                            backgroundColor: const MaterialStatePropertyAll(Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SelectClassificationScreen(),
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
                    Spacer(),
                    VerticalDivider(color: Colors.grey,),
                    const SizedBox(width: 12,),
                    Image.asset('assets/images/klasifikasi.png'),
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
                          'Watermarking',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        const Text(
                          'Cool! Watermarking Feature to\nProtect Content, Making Your Online\nExperience Safe and Comfortable',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey
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
                            visualDensity: VisualDensity.compact,
                            elevation: MaterialStatePropertyAll(2),
                            fixedSize: MaterialStatePropertyAll(Size(110, 5)),
                            backgroundColor: const MaterialStatePropertyAll(Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const WmScreen(),
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
                    Spacer(),
                    VerticalDivider(color: Colors.grey,),
                    const SizedBox(width: 12,),
                    Image.asset('assets/images/watermark.png'),
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
                height: 180,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'History',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        const Text(
                          'Display all classification and\nwatermarking history for the last\n30 days',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                          )
                        ),
                        TextButton(
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
                                builder: (context) => const ClassificationHistScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Classification',
                            style: TextStyle(
                              fontSize: 12
                            ),
                          )
                        ),
                        TextButton(
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
                                builder: (context) => const WatermarkHistScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Watermark',
                            style: TextStyle(
                              fontSize: 12
                            ),
                          )
                        )
                      ],
                    ),
                    Spacer(),
                    VerticalDivider(color: Colors.grey,),
                    const SizedBox(width: 12,),
                    Image.asset('assets/images/history.png'),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}