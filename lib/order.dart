import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';
import 'package:async/async.dart';
import 'dart:math';
import 'player.dart';
import 'question.dart';
import 'category.dart';
import 'dart:async';
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
  static int uoic = 0;
  static var orderDatabase = {};

  order(this.id,  this.questionID, this.catID, this.typeID, this.subtypeID, this.allowedAmount, this.usedAmount);

  order.addOrder(int questionID, int catID, int typeID, int subtypeID, int allowedAmount, int usedAmount){
    order _orderplaceholder = new order(oic, questionID, catID, typeID, subtypeID,  allowedAmount, usedAmount);
    orderDatabase[oic] = _orderplaceholder;
    oic++;
  }

  order.setAllowedAmount(int id, int amount){
    order _orderplaceholder = orderDatabase[id];
    _orderplaceholder.allowedAmount = amount;
    orderDatabase[id] = _orderplaceholder;
  }

  order.setUsedAmount(int id, int amount){
    order _orderplaceholder = orderDatabase[id];
    _orderplaceholder.usedAmount = amount;
    orderDatabase[id] = _orderplaceholder;
  }

  /*order.getOrder(int id){
    order _orderplaceholder = orderDB[id];
  }*/

  static int getQuestionID(int id){
    order _orderplaceholder = orderDatabase[id];
    return _orderplaceholder.questionID;
  }

}

class countdown extends AnimatedWidget {
  countdown({ Key key, this.animation }) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context){
    return new Text(
      animation.value.toString(),
      style: new TextStyle(fontSize: 150.0),
    );
  }
}

class viewOrder extends StatefulWidget{
  @override
  viewOrderState createState() => new viewOrderState();
}

class viewOrderState extends State<viewOrder> with TickerProviderStateMixin{

  // Randomblock
  static Random random = new Random();
  static int randomQuestionID;
  static int randomSelectorID;
  static int randomFirstPlayerID;
  static int randomSecondPlayerID;
  static String randomSelectorChar;

  //Avoid the same
  static int lastQuestionID;
  static int lastPlayerID;

  static Timer _timer;
  static var _timerbtnchild;
  static int _countdownSeconds = 0;
  static bool running;

  //Final block
  static player finalFirstPlayer;
  static player finalSecondPlayer;
  static question finalQuestion;
  static String finalOrderString;

  static Row firstRow;
  static RichText secondRow;
  static Row thirdRow;

  final TextStyle _maletitlestyle = const TextStyle(
    fontSize: 36,
    color: Colors.blue
  );

  final TextStyle _maleorderstyle = const TextStyle(
      fontSize: 24,
      color: Colors.blue
  );

  final TextStyle _femaletitlestyle = const TextStyle(
      fontSize: 36,
      color: Colors.red
  );

  final TextStyle _femaleorderstyle = const TextStyle(
      fontSize: 24,
      color: Colors.red
  );

  final TextStyle _orderstyle = const TextStyle(
    fontSize: 24,
    color: Colors.black
  );


  static FloatingActionButton _timerbtn;

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
      running=false;
      _buildorder();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: new Scaffold(
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:[
            new Expanded(
              child: new Center(
                  child: firstRow
              )
            ),
            new Expanded(
              child: new Center(
                  child: secondRow
              )
            ),
            new Expanded(
              child: thirdRow
            )
          ]
        )
        ),
      onWillPop: () async => false
    );
  }

  void _buildorder(){

    //Questionblock
    randomQuestionID = random.nextInt(order.orderDatabase.length);
    order _orderplaceholder = order.orderDatabase[randomQuestionID];
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
      _orderplaceholder.usedAmount++;

      //Playerblock
      randomFirstPlayerID = random.nextInt(player.playerDatabase.length);
      while(randomFirstPlayerID==lastPlayerID){
        randomFirstPlayerID = random.nextInt(player.playerDatabase.length);
      }
      finalFirstPlayer = player.playerDatabase[player.getPlayerIdFromList(randomFirstPlayerID)];
      lastPlayerID = finalFirstPlayer.id;

      if(randomSelectorID==1){
        while(randomSecondPlayerID==null||randomSecondPlayerID==randomFirstPlayerID){
          randomSecondPlayerID = random.nextInt(player.playerDatabase.length);
        }
        finalSecondPlayer = player.playerDatabase[player.getPlayerIdFromList(randomSecondPlayerID)];
      }
      else  {
        finalSecondPlayer = null;
      }

      //Finalblock
      finalQuestion = question.questionDatabase[(order.getQuestionID(randomQuestionID))];
      finalOrderString = question.getQuestionText(order.getQuestionID(randomQuestionID), randomSelectorChar);
      firstRow = _buildfirstRow(finalFirstPlayer, finalSecondPlayer);
      secondRow = _buildSecondRow(finalFirstPlayer, finalSecondPlayer);
      thirdRow = _buildThirdRow(finalQuestion);

      //if (finalOrderString.contains('%s')){
      //  finalOrderString = sprintf(finalOrderString, [finalSecondPlayer.name]);
      //}
    }

    else{
      order.uoic++;
      if(order.uoic >= order.orderDatabase.length * 0.75){
        for(order _orderplaceholder in order.orderDatabase.values){
          order.setUsedAmount(_orderplaceholder.id, 0);
        }
        order.uoic=0;
      }
      _buildorder();
    }
  }

  Widget _buildfirstRow(player firstPlayer, player secondPlayer){
  if (secondPlayer==null) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        new Expanded(
          child: new Text(
            firstPlayer.points.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24
            )
            ),
            flex: 1
        ),
        new Expanded(
          child: new Text(
            firstPlayer.name,
            textAlign: TextAlign.center,
            style: firstPlayer.sex=='m'?_maletitlestyle:_femaletitlestyle
          ),
          flex: 1
        ),
        new Spacer(
          flex: 1
        )
      ]
    );
  }
  else{
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        new Expanded(
          child: new Text(
            firstPlayer.points.toString(),
            textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24
              )
          ),
          flex: 1
          ),
        new Expanded(
            child: new RichText(
              text: TextSpan(
                children: <TextSpan>  [
                  TextSpan(
                      text:finalFirstPlayer.name,
                      style: finalFirstPlayer.sex=='m'?_maletitlestyle:_femaletitlestyle
                  ),
                  TextSpan(
                    text:' & ',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.black
                    )
                  ),
                  TextSpan(
                      text:finalSecondPlayer.name,
                      style: finalSecondPlayer.sex=='m'?_maletitlestyle:_femaletitlestyle
                  )
                ]
              ),
              textAlign: TextAlign.center,
            ),
          flex: 1
          ),
        new Expanded(
          child: new Text(
            secondPlayer.points.toString(),
            textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24
              )
          ),
          flex: 1
          )
      ]
    );

  }
  }

  Widget _buildSecondRow(player firstPlayer, player secondPlayer){
    if (secondPlayer==null) {
      return new RichText(text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: finalOrderString,
                style: _orderstyle,
              )
            ]
          ),
            textAlign: TextAlign.center,
          );
    }
    else  {
      List<String> _splitstring;
      _splitstring = finalOrderString.split("\$placeholder");
      _splitstring[1].replaceAll("\$placeholder", "");
      return new RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: _splitstring[0],
                style: _orderstyle
              ),
              TextSpan(
                text: secondPlayer.name.toString(),
                style: secondPlayer.sex=='m'?_maleorderstyle:_femaleorderstyle
              ),
              TextSpan(
                  text: _splitstring[1],
                  style: _orderstyle
              )
            ],
          ),
          textAlign: TextAlign.center,
        );
    }
  }

  Widget _buildThirdRow(question question){
    running?null:_timerbtnchild = Icon(Icons.timer);
    if (finalQuestion.type_id==2){
      _timerbtn = FloatingActionButton(
          heroTag: "btn3",
          backgroundColor: Colors.blue,
          child: _timerbtnchild,
            onPressed: () {
            _starttimer();
          }
      );
      return new Row(
          children: [
            new Expanded(
                child: new FloatingActionButton(
                    heroTag: "btn1",
                    child: Icon(Icons.thumb_down),
                    backgroundColor: Colors.red,
                    onPressed: () {
                      finalFirstPlayer.points++;
                      finalSecondPlayer!=null?finalSecondPlayer.points++:null;
                      _buildorder();
                      setState(() {});
                    }
                )
            ),
            new Expanded(
                child: _timerbtn
            ),
            new Expanded(
              child: new FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Colors.green,
                child: Icon(Icons.thumb_up),
                onPressed: () {
                  _buildorder();
                  setState(() {});
                },
              ),
            )
          ]
      );
    }
    else  {
      _timerbtn = FloatingActionButton(
          heroTag: "btn3",
          backgroundColor: Colors.grey,
          child: Icon(Icons.timer),
          onPressed: () {
          }
      );
      return new Row(
          children: [
            new Expanded(
                child: new FloatingActionButton(
                    heroTag: "btn1",
                    child: Icon(Icons.thumb_down),
                    backgroundColor: Colors.red,
                    onPressed: () {
                      finalFirstPlayer.points++;
                      finalSecondPlayer!=null?finalSecondPlayer.points++:null;
                      _buildorder();
                      setState(() {});
                    }
                )
            ),
            new Expanded(
                child: _timerbtn
            ),
            new Expanded(
              child: new FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Colors.green,
                child: Icon(Icons.thumb_up),
                onPressed: () {
                  _buildorder();
                  setState(() {});
                },
              ),
            )
          ]
      );
    }
  }

  void _starttimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime()  {
    int duration = finalQuestion.time;
    setState(() {
        if (running=false){
          _countdownSeconds = duration;
          running = true;
        }
        _countdownSeconds--;
        _timerbtnchild = Text('$_countdownSeconds');
        thirdRow = _buildThirdRow(finalQuestion);
        if (_countdownSeconds == 0){
          running = false;
          _timer.cancel();
        }
    });
  }

}