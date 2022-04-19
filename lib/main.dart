// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import "./screens/location_screen.dart";
import './screens/loading_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
