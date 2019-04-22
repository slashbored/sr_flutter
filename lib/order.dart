import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';
import 'package:async/async.dart';
import 'menuDrawer.dart';
import 'player.dart';
import 'question.dart';
import 'category.dart';
import 'overView.dart';


class viewOrder extends StatefulWidget{
  @override
  viewOrderState createState() => new viewOrderState();
}

class viewOrderState extends State<viewOrder>{
  //String formattedOrder;

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: new Scaffold(
          appBar: new AppBar(
            title: new Text('Aufgabe'),
              actions:  <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  tooltip: 'Einstellungen',
                  onPressed: () {
                    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => viewOverview()));
                    });
                  },
                )
              ],
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
    //drawer: menuDrawer(context),
        body: new Text(
          sprintf(question.getQuestionText(7, 'm'), ["Herbert"])
        )
        ),
      onWillPop: () async => false
    );
  }
}