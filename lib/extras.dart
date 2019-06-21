import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'menuDrawer.dart';
import 'category.dart';

class editExtras extends StatefulWidget{
  @override
  editExtrasState createState() => new editExtrasState();
}

class editExtrasState extends State<editExtras>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*appBar: new AppBar(
        title: Text('Extras'),
        centerTitle: true,
      ),*/
      //drawer: menuDrawer(context),
      body: new Center(
        child: new FractionallySizedBox(
          alignment: Alignment.center,
          heightFactor: 0.75,
          widthFactor: 0.75,
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>  [
                SwitchListTile(
                    title: Text('Gruppenauswahl'),
                    onChanged: (bool _newGrpvalue) {
                      setState(() {
                        category.grpallowed==true?_newGrpvalue=false:_newGrpvalue=true;
                        category.grpallowed=_newGrpvalue;
                      });
                    },
                    value: category.grpallowed
                ),
                SwitchListTile(
                    title: Text('Eigene Auswahl'),
                    onChanged: (bool _newOwnvalue) {
                      setState(() {
                        category.ownallowed==true?_newOwnvalue=false:_newOwnvalue=true;
                        category.ownallowed=_newOwnvalue;
                      });
                    },
                    value: category.ownallowed
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Lizenzinfo"),
                          content: Text(
                            "Die Kategorieicons sind alle auf iconfinder.com gefunden worden.\n"
                            "Bis auf das Zelticon sind alle vom Benutzer \" Alpár-Etele Méder\" (thoseicons.com) und unterstehen zum Teil der Creative Commons License 3.0.\n"
                            "Das Zelticon ist vom Benutzer \"Pondok Multimedia\" (keine Webseite gefunden, ggf. pondokmultimedia.com).\n"
                            "Alle Icons wurden nicht in ihrem Inhalt modifiziert. Lediglich ihre Größe wurde geändert.",
                          textAlign: TextAlign.center
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("OK"),
                              onPressed:  () {Navigator.of(context).pop();},
                            )
                          ],
                        );
                      }
                    );
                  },
                )
              ],
            )
          ),
        )
      )
    );
  }
}

