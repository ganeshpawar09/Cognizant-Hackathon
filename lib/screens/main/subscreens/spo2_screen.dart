import 'package:flutter/material.dart';

class SPO2Screen extends StatefulWidget {
  const SPO2Screen({super.key});

  @override
  State<SPO2Screen> createState() => _SPO2ScreenState();
}

class _SPO2ScreenState extends State<SPO2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pulse Oximeter")),
      body: Container(),
    );
  }
}
