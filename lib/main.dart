import 'package:flutter/material.dart';

import 'player.dart';
import 'dataBase.dart';
import 'question.dart';
import 'category.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shitroulette',
      theme: new ThemeData(
        primaryColor: Colors.black,
      ),
      home: new editPlayers(),
    );
  }
}

