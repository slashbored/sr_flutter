import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'player.dart';
import 'category.dart';
import 'menuDrawer.dart';
import 'order.dart';

class viewOverviewOld extends StatefulWidget{
  @override
  viewOverviewOldState createState() => new viewOverviewOldState();
}

class viewOverviewOldState extends State<viewOverviewOld>{

  static IconButton playerCounterIcon;
  static IconButton categoryCounterIcon;



  @override
  void initState() {
    super.initState();

    setState(() {
    });
  }

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
    _getIcons();
    return new WillPopScope(onWillPop: onWillPop,
      child: new Scaffold(
        appBar: new AppBar(
          //automaticallyImplyLeading: false,
          title: Text('Übersicht'),
          centerTitle: true,
        ),
        //drawer: menuDrawer(context),
        body: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Spacer(
                        flex: 125
                      ),
                      new Expanded(
                          child: new Text('Kategorienanzahl: ' + category.cic.toString(),
                              style: TextStyle(
                                  fontSize: 36,
                              ),
                            textAlign: TextAlign.center,
                      ),
                      flex: 750
                      ),
                      new Expanded(
                        child: categoryCounterIcon,
                        flex: 125
                      )
                    ]
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Spacer(
                      flex: 125
                    ),
                    new Expanded(
                      child: new Text('Spieleranzahl: ' + player.playerDatabase.length.toString(),
                      style: TextStyle(
                        fontSize: 36,
                      ),
                      textAlign: TextAlign.center,
                      ),
                      flex: 750
                      ),
                    new Expanded(
                      child: playerCounterIcon,
                      flex: 125
                    )
                  ]
                ),
                new FloatingActionButton(
                  onPressed: (){
                    if (player.playerDatabase.length>=3&&category.cic>=3){
                      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight, DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
                        SystemChrome.setEnabledSystemUIOverlays([]);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => viewOrder()));
                      });
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ]
          )
        )
    );
  }

  void _getIcons(){
    if(player.playerDatabase.length<3){
      playerCounterIcon = IconButton(
          icon: Icon(Icons.close),
          color: Colors.red,
          disabledColor: Colors.red,
          onPressed: null);
    }
    else{
      playerCounterIcon = IconButton(
          icon: Icon(Icons.check),
          color: Colors.green,
          disabledColor: Colors.green,
          onPressed: null);
    }
    if(category.cic<3){
      categoryCounterIcon = IconButton(
          icon: Icon(Icons.close),
          color: Colors.red,
          disabledColor: Colors.red,
          onPressed: null);
    }
    else{
      categoryCounterIcon = IconButton(
          icon: Icon(Icons.check),
          color: Colors.green,
          disabledColor: Colors.green,
          onPressed: null);
    }
  }


}