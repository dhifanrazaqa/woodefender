import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExtractPreviewScreen extends StatefulWidget {
  const ExtractPreviewScreen({
    super.key,
    required this.imageWm,
    required this.wm_url,
  });
  final imageWm;
  final wm_url;

  @override
  State<ExtractPreviewScreen> createState() => _ExtractPreviewScreenState();
}

class _ExtractPreviewScreenState extends State<ExtractPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Preview',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Original Watermark',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  width: width,
                  child: Image.network(
                    widget.wm_url,
                    width: width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(height:30),
                const Text(
                  'Current Watermark',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  width: width,
                  child: Image.memory(
                    widget.imageWm,
                    width: width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(height:50),
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
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Back',
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
      )
    );
  }
}