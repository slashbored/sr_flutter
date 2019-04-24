import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'player.dart';
import 'category.dart';
import 'menuDrawer.dart';

class viewOverview extends StatefulWidget{
  @override
  viewOverviewState createState() => new viewOverviewState();
}

class viewOverviewState extends State<viewOverview>{

  static IconButton playerIcon;
  static IconButton categoryIcon;

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
        drawer: menuDrawer(context),
        body: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Text('Kategorienanzahl: ' + category.cic.toString()),
                  categoryIcon
                ]
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Text('Spieleranzahl: ' + player.playerDatabase.length.toString()),
                  playerIcon
                ]
              )
            ]
          )
        )
    )
    );
  }

  void _getIcons(){
    if(player.playerDatabase.length<3){
      playerIcon = IconButton(icon: Icon(Icons.close), color: Colors.red, onPressed: null);
    }
    else{
      playerIcon = IconButton(icon: Icon(Icons.check), color: Colors.green, onPressed: null);
    }
    if(category.cic<3){
      categoryIcon = IconButton(icon: Icon(Icons.close), color: Colors.red, onPressed: null);
    }
    else{
      categoryIcon = IconButton(icon: Icon(Icons.check), color: Colors.green, onPressed: null);
    }
  }


}