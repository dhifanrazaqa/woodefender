import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woodefender/screens/watermarking/res_wm_screen.dart';
import 'package:woodefender/services/image_service.dart';


class FragileWmScreen extends StatefulWidget {
  const FragileWmScreen({super.key});

  @override
  State<FragileWmScreen> createState() => _FragilWmScreenState();
}

class _FragilWmScreenState extends State<FragileWmScreen> {
  final imagePicker = ImagePicker();
  String? imagePath1;
  String? imagePath2;
  bool cameraIsAvailable = Platform.isAndroid || Platform.isIOS;
  bool _isLoading = false;

  void cleanResult1() {
    imagePath1 = null;
    setState(() {});
  }

  void cleanResult2() {
    imagePath2 = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Text('Original Image'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (cameraIsAvailable)
                  TextButton.icon(
                    onPressed: () async {
                      cleanResult1();
                      final result = await imagePicker.pickImage(
                        source: ImageSource.camera,
                      );
      
                      imagePath1 = result?.path;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.camera,
                      size: 48,
                    ),
                    label: const Text("Take a photo"),
                  ),
                TextButton.icon(
                  onPressed: () async {
                    cleanResult1();
                    final result = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
      
                    imagePath1 = result?.path;
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.photo,
                    size: 48,
                  ),
                  label: const Text("Pick from gallery"),
                ),
              ],
            ),
            const Divider(color: Colors.black),
            Expanded(
                child: Stack(
              alignment: Alignment.center,
              children: [
                if (imagePath1 != null) Image.file(File(imagePath1!)),
                if (imagePath1 == null)
                  const Text("Take a photo or choose one from the gallery to "
                      "inference."),
              ],
            )),
            const Divider(color: Colors.black),
            Text('WM Image'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (cameraIsAvailable)
                  TextButton.icon(
                    onPressed: () async {
                      cleanResult2();
                      final result = await imagePicker.pickImage(
                        source: ImageSource.camera,
                      );
      
                      imagePath2 = result?.path;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.camera,
                      size: 48,
                    ),
                    label: const Text("Take a photo"),
                  ),
                TextButton.icon(
                  onPressed: () async {
                    cleanResult2();
                    final result = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
      
                    imagePath2 = result?.path;
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.photo,
                    size: 48,
                  ),
                  label: const Text("Pick from gallery"),
                ),
              ],
            ),
            const Divider(color: Colors.black),
            Expanded(
                child: Stack(
                alignment: Alignment.center,
                children: [
                  if (imagePath2 != null) Image.file(File(imagePath2!)),
                  if (imagePath2 == null)
                    const Text("Take a photo or choose one from the gallery to "
                        "inference."),
                ],
              )
            ),
            if(_isLoading)
              CircularProgressIndicator(),
            if(!_isLoading)
              ElevatedButton(onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                var resImg = await addFragileWm(imagePath1!, imagePath2!);
                setState(() {
                  _isLoading = false;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResultWmScreen(resImg: resImg!),
                    ),
                  );
                });
              }, child: Text('Embed Watermark'))
          ],
        ),
      ),
    );
  }
}