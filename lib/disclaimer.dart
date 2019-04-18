import 'package:flutter/material.dart';
import 'menuDrawer.dart';
import 'question.dart';
import 'dataBase.dart';

class viewDisclaimer extends StatefulWidget{
  @override
  viewDisclaimerState createState() => new viewDisclaimerState();
}

class viewDisclaimerState extends State<viewDisclaimer>{

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
        title: Text('Vorwort'),
        centerTitle: true,
      ),
      drawer: menuDrawer(context),
      body: new Text('Hier steht das Vorwort.',
        textAlign: TextAlign.center
      )
    );
  }
}