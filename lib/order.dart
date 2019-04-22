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

  @override
   void initState() {
    super.initState();
    setState(() {
      for (category _categoryplaceholder in category.categoryDatabase.values){
        if (category.cbValues[_categoryplaceholder.id]){
          for (question _questionplaceholder in question.questionDatabase.values){
            if (_categoryplaceholder.id == _questionplaceholder.cat_id) {
              order.addOrder(_questionplaceholder.id, _questionplaceholder.cat_id, _questionplaceholder.type_id, _questionplaceholder.subtype_id, 1, 1);
            }
          }
        }
      }
      randomQuestionID = random.nextInt(order.orderDB.length);
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
                  question.getQuestionText(order.getQuestionID(randomQuestionID), 'm')
              ),
            ),
            FloatingActionButton(
              child: Icon(Icons.cached),
              onPressed: () {
                randomQuestionID = random.nextInt(order.orderDB.length);
                setState(() {});
              },
            )
          ]
        )
        ),
      onWillPop: () async => false
    );
  }
}