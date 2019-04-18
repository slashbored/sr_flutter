import 'package:flutter/material.dart';
import 'menuDrawer.dart';
import 'question.dart';
import 'dataBase.dart';

class viewOverview extends StatefulWidget{
  @override
  viewOverviewState createState() => new viewOverviewState();
}

class viewOverviewState extends State<viewOverview>{

  /*@override
  void initState()  {
    super.initState();
    setState(() {
      if(question.questionbase[0]==null){
        buildDatabase();
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Übersicht'),
        centerTitle: true,
      ),
      drawer: menuDrawer(context),
      body: new Text('Hier steht die Übersicht.',
        textAlign: TextAlign.center,
      )
    );
  }
}