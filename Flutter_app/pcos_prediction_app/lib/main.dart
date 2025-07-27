import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(PCOSPredictionApp());
}

class PCOSPredictionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PCOS Prediction App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}