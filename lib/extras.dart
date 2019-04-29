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
      appBar: new AppBar(
        title: Text('Extras'),
        centerTitle: true,
      ),
      drawer: menuDrawer(context),
      body: new Center(
        child: new FractionallySizedBox(
          alignment: Alignment.center,
          heightFactor: 0.75,
          widthFactor: 0.75,
          child: new SwitchListTile(
            title: Text('Gruppenauswahl'),
            onChanged: (bool _newGrpvalue) {
              setState(() {
                category.grpallowed==true?_newGrpvalue=false:_newGrpvalue=true;
                category.grpallowed=_newGrpvalue;
              });
            },
            value: category.grpallowed
          ),
        )
      )
    );
  }
}