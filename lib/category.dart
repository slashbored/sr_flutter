import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'menuDrawer.dart';

class category{
  int id;
  String descr;
  String title_german;
  int allowedAmount;
  static int cic = 0;
  static var categoryDatabase = {};
  static bool ranOnce;
  static var cbAllowed = {};
  static bool grpallowed = false;
  static bool ownallowed = false;

  category(this.id, this.descr, this.title_german, this.allowedAmount);

  category.addCategory(int id, String descr, String title_german){
    category newCategory = new category(id, descr, title_german, 0);
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

  static int getCategoryAllowedAmount(int id) {
    category _categoryplaceholder = category.categoryDatabase[id];
    return _categoryplaceholder.allowedAmount;
  }

  static void setCategoryAllowedAmount(int id, int amount) {
    category _categoryplaceholder = category.categoryDatabase[id];
    _categoryplaceholder.allowedAmount = amount ;
  }
  
}

class type{
  int id;
  String descr;
  static int tid = 0;
  static var typeDatabase = {};

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
  static var subtypeDatabase  = {};

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

  static String amountIndicator;

  @override
  Widget build(BuildContext context) {
    if (category.ranOnce!=true){
      for(category _categoryplaceholder in category.categoryDatabase.values){
        category.cbAllowed[_categoryplaceholder.id] = false;
      }
      //category.grpallowed=false;
    }
    category.ranOnce=true;

    return new Scaffold(
      appBar: new AppBar(
        title: Text('Kategorien bearbeiten'),
        centerTitle: true,
      ),
      drawer: menuDrawer(context),
      body: Center(
          child:new FractionallySizedBox(
            alignment: Alignment.center,
            heightFactor: 0.75,
            widthFactor: 0.75,
              child: new Column(
                children: <Widget>[
                  new Expanded(child: new ListView(
                    children: <Widget>[
                      ListView.builder(itemCount: category.categoryDatabase.length,
                        itemBuilder: (BuildContext context, int index){
                          return new ListTile(
                              title: new Text(category.getCatergoryTitle_german(index+1)),
                              trailing: new Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove_circle),
                                    color: Colors.red,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: () {
                                      if (index+1!=7) {
                                        if  (category.getCategoryAllowedAmount(index+1)!=0)    {
                                          category.setCategoryAllowedAmount(index+1, category.getCategoryAllowedAmount(index+1)-1);
                                          if  (category.getCategoryAllowedAmount(index+1)==0)  {
                                            category.cbAllowed[index+1] = false;
                                          }
                                        }
                                        setState(() {
                                          category.cic=0;
                                          for (bool selectedCategory in category.cbAllowed.values) {
                                            (selectedCategory)?category.cic++:null;
                                          }
                                        });
                                      }
                                    },
                                  ),
                                  Text(getAmountIndicator(category.getCategoryAllowedAmount(index+1))),
                                  IconButton(
                                      icon: Icon(Icons.add_circle),
                                      color: Colors.green,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed: () {
                                        if (index+1!=7&&category.getCategoryAllowedAmount(index+1)<=2) {
                                          category.setCategoryAllowedAmount(index+1, category.getCategoryAllowedAmount(index+1)+1);
                                          category.cbAllowed[index+1] = true;
                                          setState(() {
                                            category.cic=0;
                                            for (bool selectedCategory in category.cbAllowed.values) {
                                              (selectedCategory)?category.cic++:null;
                                            }
                                          });
                                        }
                                      }
                                  )],
                                mainAxisSize: MainAxisSize.min,
                              )
                          );
                        },
                        shrinkWrap: true,
                      )
                    ],
                  )
                  ),
                  new Container(
                    child: new Text('Erklärung:\n😑 = ausgeschaltet, 😊 = normale Häufigkeit,\n😳 = doppelte Häufigkeit, 😱 = dreifache Häufigkeit', textAlign: TextAlign.center,)
                  )
                ],
              )
      )
      ),
      );
  }

  String getAmountIndicator(int Amount) {
    switch  (Amount)  {
      case 0: {
        return '😑';
      }
      case 1: {
        return '😊';
      }
      case 2: {
        return '😳';
      }
      case 3: {
        return '😱';
      }
    }
  }
}
