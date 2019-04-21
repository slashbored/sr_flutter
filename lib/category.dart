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

  static String getCatergoryDescr(int id){
    category _categoryplaceholder = category.categoryDatabase[id];
    return _categoryplaceholder.descr.toString();
  }
  
  static String getCatergoryTitle_german(int id){
    category _categoryplaceholder = category.categoryDatabase[id];
    return _categoryplaceholder.title_german.toString();
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
  bool ranOnce = false;
  var cbValues = {};

  @override
  Widget build(BuildContext context) {
    if (ranOnce==false){
      for(category _categoryplaceholder in category.categoryDatabase.values){
        cbValues[_categoryplaceholder.id] = false;
      }
    }
    ranOnce=true;

    return new Scaffold(
      appBar: new AppBar(
        title: Text('Kategorien bearbeiten'),
        centerTitle: true,
      ),
      drawer: menuDrawer(context),
      body: new Column(
          children: [
            new Spacer(flex: 1),
            new Flexible(
              child: new Row(
                children:[
                  new Spacer(flex: 1),
                  new Flexible(
                    child: new ListView(
                        children: <Widget>[
                          ListView.builder(itemCount: category.categoryDatabase.length,
                            itemBuilder: (BuildContext context, int index){
                              return new SwitchListTile(
                                  title: new Text(category.getCatergoryTitle_german(index+1)),
                                  value: cbValues[index+1],
                                  onChanged: (bool newCBValue) {
                                    setState(() {
                                      cbValues[index+1]==true?newCBValue=false:newCBValue=true;
                                      cbValues[index+1]=newCBValue;
                                    });
                                  }
                              );
                            },
                            shrinkWrap: true,
                          )
                        ]
                    ),
                    flex: 7,
                  ),
                  new Spacer(flex: 1)
                ],
              ),
              flex: 5,
            ),
            new Spacer(flex: 1)
          ]
      )
    );
  }
}

/*

                children: category.categoryDatabase.map((int _id){
                  return new SwitchListTile(
                      title: new Text(category.getCatergoryTitle_german(_id)),
                      value: 
                      onChanged: null)
                })
 */