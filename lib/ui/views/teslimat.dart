import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Teslimat extends StatefulWidget {
  const Teslimat({super.key});

  @override
  State<Teslimat> createState() => _TeslimatState();
}

class _TeslimatState extends State<Teslimat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset("assest/animations/animation.json")),
    );
  }
}
