import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'menuDrawer.dart';

class viewOverview extends StatefulWidget{
  @override
  viewOverviewState createState() => new viewOverviewState();
}

class viewOverviewState extends State<viewOverview>{

  Future<bool> onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Tschüsschen?',
          textAlign: TextAlign.center,),
        content: new Text('Willst du die App wirklich beenden?',
          textAlign: TextAlign.center,),
        actions: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Ja'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Nein'),
              ),
            ]
          )

        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(onWillPop: onWillPop,
      child: new Scaffold(
        appBar: new AppBar(
          //automaticallyImplyLeading: false,
          title: Text('Übersicht'),
          centerTitle: true,
        ),
        drawer: menuDrawer(context),
        body: new Text('Hier steht die Übersicht.',
          textAlign: TextAlign.center,
        )
    )
    );
  }
}