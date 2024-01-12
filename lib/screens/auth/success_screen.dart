import 'package:flutter/material.dart';
import 'dart:async';

import 'package:woodefender/screens/main_screen.dart';

class SuccesScreen extends StatefulWidget {
  const SuccesScreen({
    super.key,
    required this.type,
  });
  final type;

  @override
  State<SuccesScreen> createState() => _SuccesScreenState();
}

class _SuccesScreenState extends State<SuccesScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(pageIndex: 0,)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: widget.type == 'Daftar' ?
          Image.asset('assets/images/Body-daftar.png')
          :
          Image.asset('assets/images/Body-login.png')
        )
      )
    );
  }
}