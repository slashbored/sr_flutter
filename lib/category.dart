import 'package:flutter/material.dart';
import 'menuDrawer.dart';

class category{
  int id;
  String name;
  String description;
  static int i = 0;
  static var categorybase = {};
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