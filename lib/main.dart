import 'package:flutter/material.dart';
import 'disclaimer.dart';
import 'overView.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shitroulette',
      theme: new ThemeData(
        primaryColor: Colors.black,
      ),
      home: new viewDisclaimer(),
    );
  }
}

