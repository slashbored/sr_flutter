import 'package:flutter/material.dart';
import 'overView.dart';

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
    return new WillPopScope(onWillPop: () async => false,
      child: new Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          title: Text('Vorwort'),
          centerTitle: true,
        ),
    //drawer: menuDrawer(context),
        body: Center(
          child: new Column(
              children: [
                new Text('Dieses Spiel sollte mit Vorsicht genossen werden.\n'
                  'Der Entwickler und alle, die an der Entwicklung beteiligt waren übernehmen keinerlei Haftung für jegliche Folgen.\n'
                  'Desweiteren werden die eingegeben Daten nur lokal und nicht online verarbeitet.\n'
                  'Die Onlineverbindung dient lediglich zum Download und zur Aktualisierung des Fragenkatalogs.',
                style: TextStyle(
                    fontSize: 18
                ),
                textAlign: TextAlign.center,
              ),
                _closeButton()
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