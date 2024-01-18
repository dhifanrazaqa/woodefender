import 'package:flutter/material.dart';
import 'dart:async';

import 'package:woodefender/screens/main_screen.dart';

class SuccessWmScreen extends StatefulWidget {
  const SuccessWmScreen({super.key});

  @override
  State<SuccessWmScreen> createState() => _SuccessWmScreenState();
}

class _SuccessWmScreenState extends State<SuccessWmScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainScreen(pageIndex: 1,),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset('assets/images/Body-wm.png')
        )
      )
    );
  }
}