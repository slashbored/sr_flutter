import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'menuDrawer.dart';

class category{
  int id;
  String descr;
  String title_german;
  static int cic = 0;
  static var categoryDatabase = {};

  category(this.id, this.descr, this.title_german);

  category.addCategory(int id, String descr, String title_german){
    category newCategory = new category(id, descr, title_german);
    categoryDatabase[id] = newCategory;
  }
}

class type{
  int id;
  String descr;
  static int tid = 0;
  static var typeDatabase ={};

  type(this.id, this.descr);

  type.addType(int id, String descr){
    type newType = new type(id, descr);
    typeDatabase[id] = newType;
  }
}

class subtype{
  int id;
  String descr;
  static int stid = 0;
  static var subtypeDatabase ={};

  subtype(this.id, this.descr);

  subtype.addSubtype(int id, String descr){
    subtype newSubtype = new subtype(id, descr);
    subtypeDatabase[id] = newSubtype;
  }
}

class editCategories extends StatefulWidget{
  @override
  editCategoriesState createState() => new editCategoriesState();
}

class editCategoriesState extends State<editCategories>{
  bool setIt = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Kategorien bearbeiten'),
        centerTitle: true,
      ),
      drawer: menuDrawer(context),
      body: new Center(
        child: new Row(
          children:[
            new Spacer(flex: 1),
            new Flexible(
              child: new SwitchListTile(
                title: const Text('Animate Slowly'),
                onChanged: (bool newValue) {
                  setState(() {
                    setIt==true?newValue=false:newValue=true;
                    setIt=newValue;
                  });
                },
                value: setIt,
              ),
              flex: 7,
            ),
            new Spacer(flex: 1)
          ]
        )

      )
    );
  }
}