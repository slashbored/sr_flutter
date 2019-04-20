import 'package:flutter/material.dart';
import 'menuDrawer.dart';

class category{
  int id;
  String descr;
  static int cic = 0;
  static var categoryDatabase = {};
}

class type{
  int id;
  String descr;
  static int tid = 0;
  static var typeDatabase ={};
}

class subtype{
  int id;
  String descr;
  static int stid = 0;
  static var subtypeDatabase ={};
}

class editCategories extends StatefulWidget{
  @override
  editCategoriesState createState() => new editCategoriesState();
}

class editCategoriesState extends State<editCategories>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Kategorien bearbeiten'),
        centerTitle: true,
      ),
      drawer: menuDrawer(context),
      body: new Text('Hier stehen die Kategorien.',
        textAlign: TextAlign.center
      )
    );
  }
}