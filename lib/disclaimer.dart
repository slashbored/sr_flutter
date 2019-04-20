import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'overView.dart';

class viewDisclaimer extends StatefulWidget{
  @override
  viewDisclaimerState createState() => new viewDisclaimerState();
}

class viewDisclaimerState extends State<viewDisclaimer>{

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
          automaticallyImplyLeading: false,
          title: Text('Vorwort'),
          centerTitle: true,
        ),
    //drawer: menuDrawer(context),
        body: Center(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Text('Dieses Spiel sollte mit Vorsicht genossen werden.\n'
                  'Der Entwickler und alle, die an der Entwicklung beteiligt waren übernehmen keinerlei Haftung für jegliche Folgen.\n'
                  'Desweiteren werden die eingegeben Daten nur lokal und nicht online verarbeitet.\n'
                  'Die Onlineverbindung dient lediglich zum Download und zur Aktualisierung des Aufgabenkatalogs.',
                style: TextStyle(
                    fontSize: 18
                ),
                textAlign: TextAlign.center,
              ),
                _closeButton(),
              ]
          )
        )
      )
    );
  }

  Widget _closeButton(){
    return new IconButton(icon: Icon(Icons.clear),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => viewOverview()));
      }
    );
  }
}