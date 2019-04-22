import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'menuDrawer.dart';
import 'player.dart';
import 'question.dart';
import 'category.dart';
import 'package:sprintf/sprintf.dart';

class viewOrder extends StatefulWidget{
  @override
  viewOrderState createState() => new viewOrderState();
}

class viewOrderState extends State<viewOrder>{
  //String formattedOrder;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Aufgabe'),
      ),
      drawer: menuDrawer(context),
      body: new Text(
        sprintf(question.getQuestionText(7, 'm'), ["Herbert"])
      )
    );
  }
}