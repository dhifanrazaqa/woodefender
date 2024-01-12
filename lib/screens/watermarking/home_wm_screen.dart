import 'package:flutter/material.dart';
import 'package:woodefender/screens/watermarking/frag_wm_screen.dart';

class WmScreen extends StatelessWidget {
  const WmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FragileWmScreen(),
              ),
            );
          }, child: Text('Fragile Wm')),
          ElevatedButton(onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FragileWmScreen(),
              ),
            );
          }, child: Text('Robust Wm'))
        ]
      ),
    );
  }
}