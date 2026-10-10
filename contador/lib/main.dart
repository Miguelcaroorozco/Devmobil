import 'package:flutter/material.dart';
import 'package:contador/homeScreen.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const new({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue
      ),
      home: HomeScreen(),
    );
  }
}