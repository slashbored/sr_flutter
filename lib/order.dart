import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';
import 'package:async/async.dart';
import 'dart:math';
import 'menuDrawer.dart';
import 'player.dart';
import 'question.dart';
import 'category.dart';
import 'overView.dart';

class order{
  int id;
  int questionID;
  int catID;
  int typeID;
  int subtypeID;
  int allowedAmount;
  int usedAmount;
  static int oic = 0;
  static var orderDB = {};

  order(this.id,  this.questionID, this.catID, this.typeID, this.subtypeID, this.allowedAmount, this.usedAmount);

  order.addOrder(int questionID, int catID, int typeID, int subtypeID, int allowedAmount, int usedAmount){
    order _orderplaceholder = new order(oic, questionID, catID, typeID, subtypeID,  allowedAmount, usedAmount);
    orderDB[oic] = _orderplaceholder;
    oic++;
  }

  /*order.getOrder(int id){
    order _orderplaceholder = orderDB[id];
  }*/

  static int getQuestionID(int id){
    order _orderplaceholder = orderDB[id];
    return _orderplaceholder.questionID;
  }

}


class viewOrder extends StatefulWidget{
  @override
  viewOrderState createState() => new viewOrderState();
}

class viewOrderState extends State<viewOrder>{
  static Random random = new Random();
  static int randomQuestionID;
  static int randomSelectorID;
  static String randomSelectorChar;

  @override
   void initState() {
    super.initState();
    setState(() {
      for (category _categoryplaceholder in category.categoryDatabase.values){
        if (category.cbValues[_categoryplaceholder.id]){
          for (question _questionplaceholder in question.questionDatabase.values){
            if (_categoryplaceholder.id == _questionplaceholder.cat_id) {
              order.addOrder(_questionplaceholder.id, _questionplaceholder.cat_id, _questionplaceholder.type_id, _questionplaceholder.subtype_id, 1, 0);
            }
          }
        }
      }
    });
  }
  //String formattedOrder;

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: new Scaffold(
          appBar: new AppBar(
            title: new Text('Aufgabe'),
              actions:  <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  tooltip: 'Einstellungen',
                  onPressed: () {
                    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => viewOverview()));
                    });
                  },
                )
              ],
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
    //drawer: menuDrawer(context),
        body: new Column(
          children:[
            new Center(
              child: new Text(
                //sprintf(question.getQuestionText(7, 'm'), ["Herbert"])
                  //question.getQuestionText(order.getQuestionID(randomQuestionID), 'm')
                _buildorder()
              ),
            ),
            FloatingActionButton(
              child: Icon(Icons.cached),
              onPressed: () {
                setState(() {});
              },
            )
          ]
        )
        ),
      onWillPop: () async => false
    );
  }

  String _buildorder(){
    randomQuestionID = random.nextInt(order.orderDB.length);
    order _orderplaceholder = order.orderDB[randomQuestionID];
    if (_orderplaceholder.usedAmount<_orderplaceholder.allowedAmount) {
      question _questionplaceholder = question.questionDatabase[order.getQuestionID(randomQuestionID)];
      randomSelectorID = random.nextInt(5);
      switch (randomSelectorID) {
        case 0: {
          randomSelectorChar = 'a';
          break;
        }
        case 1: {
          randomSelectorChar = 'm';
          break;
        }
        case 2: {
          randomSelectorChar = 'y';
          break;
        }
        case 3: {
          randomSelectorChar = 't';
          break;
        }
        case 4: {
          randomSelectorChar = 'r';
          break;
        }
      }
      while (question.getQuestionText(order.getQuestionID(randomQuestionID), randomSelectorChar)==''||question.getQuestionText(order.getQuestionID(randomQuestionID), randomSelectorChar)==null){
        randomSelectorID = random.nextInt(4);
        switch (randomSelectorID) {
          case 0: {
            randomSelectorChar = 'a';
            break;
          }
          case 1: {
            randomSelectorChar = 'm';
            break;
          }
          case 2: {
            randomSelectorChar = 'y';
            break;
          }
          case 3: {
            randomSelectorChar = 't';
            break;
          }
          case 4: {
            randomSelectorChar = 'r';
            break;
          }
        }
      }
      return question.getQuestionText(order.getQuestionID(randomQuestionID), randomSelectorChar);
    }
    else{
      _buildorder();
    }
  }


}