import 'package:flutter/material.dart';
import 'menuDrawer.dart';

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
        body: new Text('Hier stehen die Extras.',
          textAlign: TextAlign.center)
    );
  }
}