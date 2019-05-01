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

class viewOrderState extends State<viewOrder> with TickerProviderStateMixin {

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

  //Buttonblock
  static FloatingActionButton _acceptedbtn;
  static FloatingActionButton _deniedbtn;

  //Timerbutton & -block
  static FloatingActionButton _timerbtn;
  static Timer _foregroundTimer;
  static var _timerbtnchild;
  static int _secondsLeft;
  static int _secondsLeftHalted;
  static bool _running;
  static bool _halted;
  static Timer _backgroundTimer;
  static var _orderStack = {};

  //Finalblock
  static player finalFirstPlayer;
  static player finalSecondPlayer;
  static question finalQuestion;
  static String finalOrderString;

  //Rowblock
  static Row firstRow;
  static RichText secondRow;
  static Row thirdRow;

  static int i=0;

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


  @override
  void initState() {
    super.initState();
    setState(() {
      for (category _categoryplaceholder in category.categoryDatabase.values) {
        if(_categoryplaceholder.allowedAmount>0)  {
          for (question _questionplaceholder in question.questionDatabase
              .values) {
            if (_categoryplaceholder.id == _questionplaceholder.cat_id) {
              order.addOrder(
                  _questionplaceholder.id, _questionplaceholder.cat_id,
                  _questionplaceholder.type_id, _questionplaceholder.subtype_id,
                  _categoryplaceholder.allowedAmount, 0);
            }
          }
        }
        /*if (category.cbAllowed[_categoryplaceholder.id]) {
          for (question _questionplaceholder in question.questionDatabase
              .values) {
            if (_categoryplaceholder.id == _questionplaceholder.cat_id) {
              order.addOrder(
                  _questionplaceholder.id, _questionplaceholder.cat_id,
                  _questionplaceholder.type_id, _questionplaceholder.subtype_id,
                  1, 0);
            }
          }
        }*/
      }
      _running = false;
      _halted = false;
      _buildorder();
    });
  }

  @override
  void dispose() {
    _foregroundTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: new Scaffold(
            body: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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

  void _buildorder() {
    //Questionblock
    randomQuestionID = random.nextInt(order.orderDatabase.length);
    order _orderplaceholder = order.orderDatabase[randomQuestionID];
    if (_orderplaceholder.usedAmount < _orderplaceholder.allowedAmount) {
      //question _questionplaceholder = question.questionDatabase[order.getQuestionID(randomQuestionID)];
      randomSelectorID = random.nextInt(5);
      switch (randomSelectorID) {
        case 0:
          {
            randomSelectorChar = 'a';
            break;
          }
        case 1:
          {
            randomSelectorChar = 'm';
            break;
          }
        case 2:
          {
            category.ownallowed?randomSelectorChar = 'y':randomSelectorChar = '';
            break;
          }
        case 3:
          {
            category.grpallowed?randomSelectorChar = 't':randomSelectorChar = '';
            break;
          }
        case 4:
          {
            randomSelectorChar = 'r';
            break;
          }
      }

      while (randomSelectorChar==''
          ||question.getQuestionText(order.getQuestionID(randomQuestionID), randomSelectorChar) == ''
          ||question.getQuestionText(order.getQuestionID(randomQuestionID), randomSelectorChar)==null) {
        randomSelectorID = random.nextInt(5);
        switch (randomSelectorID) {
          case 0:
            {
              randomSelectorChar = 'a';
              break;
            }
          case 1:
            {
              randomSelectorChar = 'm';
              break;
            }
          case 2:
            {
              category.ownallowed?randomSelectorChar = 'y':randomSelectorChar = '';
              break;
            }
          case 3:
            {
              category.grpallowed?randomSelectorChar = 't':randomSelectorChar = '';
              break;
            }
          case 4:
            {
              randomSelectorChar = 'r';
              break;
            }
        }
      }
      i++;
      print(_orderplaceholder.questionID.toString() + ', ' + i.toString());
      if  (_orderplaceholder.subtypeID!=1)  {
        for (order _orderplaceholder2 in order.orderDatabase.values)  {
          _orderplaceholder2.subtypeID==_orderplaceholder.subtypeID?order.setUsedAmount(_orderplaceholder2.id, _orderplaceholder2.allowedAmount):null;
        }
      }
      else  {
        _orderplaceholder.usedAmount++;
      }

      //Playerblock
      randomFirstPlayerID = random.nextInt(player.playerDatabase.length);
      while (randomFirstPlayerID == lastPlayerID) {
        randomFirstPlayerID = random.nextInt(player.playerDatabase.length);
      }
      finalFirstPlayer=player.playerDatabase[player.getPlayerIdFromList(randomFirstPlayerID)];
      lastPlayerID = finalFirstPlayer.id;

      if (randomSelectorID == 1) {
        while (randomSecondPlayerID == null ||
            randomSecondPlayerID == randomFirstPlayerID) {
          randomSecondPlayerID = random.nextInt(player.playerDatabase.length);
        }
        finalSecondPlayer =
        player.playerDatabase[player.getPlayerIdFromList(randomSecondPlayerID)];
      }
      else {
        finalSecondPlayer = null;
      }

      //Finalblock
      finalQuestion = question.questionDatabase[(order.getQuestionID(randomQuestionID))];
      finalOrderString = question.getQuestionText(order.getQuestionID(randomQuestionID), randomSelectorChar);
      firstRow = _buildfirstRow(finalFirstPlayer, finalSecondPlayer);
      secondRow = _buildSecondRow(finalFirstPlayer, finalSecondPlayer);
      thirdRow = _buildThirdRow(finalQuestion);

    }

    else {
      order.uoic++;
      if (order.uoic >= order.orderDatabase.length * 0.75) {
        for (order _orderplaceholder in order.orderDatabase.values) {
          _orderplaceholder.subtypeID==1?order.setUsedAmount(_orderplaceholder.id, 0):null;
        }
        order.uoic = 0;
      }
      _buildorder();
    }
  }

  Widget _buildfirstRow(player firstPlayer, player secondPlayer) {
    if (finalQuestion.type_id==4) {
      return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: finalFirstPlayer.name,
                            style: finalFirstPlayer.sex== 'm'
                                ? _maletitlestyle
                                : _femaletitlestyle
                        ),
                        TextSpan(
                            text: ' fängt an:',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.green
                            )
                        )
                      ]
                  )
              )
          )
        ],
      );
    }
    if (finalQuestion.type_id==5) {
      return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Allesamt:',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.green
                            )
                        )
                      ]
                  )
              )
          )
        ],
      );
    }
   else {
     if (secondPlayer == null) {
       return new Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             new Expanded(
                 child: new Text(
                     firstPlayer.points.toString(),
                     textAlign: TextAlign.center,
                     style: TextStyle(
                         fontSize: 36
                     )
                 ),
                 flex: 1
             ),
             new Expanded(
              child: Center(
                  child: new RichText(
                      text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: firstPlayer.name,
                              style: firstPlayer.sex == 'm'
                                  ? _maletitlestyle
                                  : _femaletitlestyle,
                            )
                          ]
                      )
                  )
              ),
                 flex: 1
             ),
             new Spacer(
                 flex: 1
             )
           ]
       );
     }
     else {
       return new Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             new Expanded(
                 child: new Text(
                     firstPlayer.points.toString(),
                     textAlign: TextAlign.center,
                     style: TextStyle(
                         fontSize:36
                     )
                 ),
                 flex: 1
             ),
             new Expanded(
                 child: new RichText(
                   text: TextSpan(
                       children: <TextSpan>[
                         TextSpan(
                             text: finalFirstPlayer.name,
                             style: finalFirstPlayer.sex == 'm'
                                 ? _maletitlestyle
                                 : _femaletitlestyle
                         ),
                         TextSpan(
                             text: ' & ',
                             style: TextStyle(
                                 fontSize: 36,
                                 color: Colors.black
                             )
                         ),
                         TextSpan(
                             text: finalSecondPlayer.name,
                             style: finalSecondPlayer.sex == 'm'
                                 ? _maletitlestyle
                                 : _femaletitlestyle
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
                         fontSize:36
                     )
                 ),
                 flex: 1
             )
           ]
       );
     }
   }
  }

  Widget _buildSecondRow(player firstPlayer, player secondPlayer) {
    if (secondPlayer == null) {
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
    else {
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

  Widget _buildThirdRow(question question) {
    _buildAcceptedbutton();
    _buildTimerbutton();
    _buildDeniedbutton();
    if  (finalQuestion.type_id==4||finalQuestion.type_id==5)  {
      return new Row(
          children: [
            new Spacer(
                flex: 1
            ),
            new Expanded(
                child: _timerbtn,
                flex: 1
            ),
            new Spacer(
                flex: 1
            )
          ]
      );
    }
    else {
      return new Row(
          children: [
            new Expanded(
                child: _deniedbtn
            ),
            new Expanded(
                child: _timerbtn
            ),
            new Expanded(
                child: _acceptedbtn
            )
          ]
      );
    }
  }

  void  _buildDeniedbutton  () {
     _deniedbtn = new FloatingActionButton(
         heroTag: "btn1",
         child: Icon(Icons.thumb_down),
         backgroundColor: Colors.red,
         onPressed: () {
           finalFirstPlayer.points++;
           finalSecondPlayer!=null?finalSecondPlayer.points++:null;
           _foregroundTimer==null?null:_foregroundTimer.cancel();
           _running = false;

           _buildorder();
           setState(() {});
         }
     );
  }

  void  _buildAcceptedbutton () {
      _acceptedbtn =  new FloatingActionButton(
        heroTag: "btn2",
        backgroundColor: Colors.green,
        child: Icon(Icons.thumb_up),
        onPressed: () {
          _foregroundTimer==null?null:_foregroundTimer.cancel();
          _running=false;
          finalQuestion.type_id==3?_addToStack(finalQuestion.time, finalFirstPlayer, finalQuestion.taskq):null;
          _buildorder();
          setState(() {});
        },
      );
  }

  void _buildTimerbutton() {
    if  (finalQuestion.type_id==4||finalQuestion.type_id==5)  {
      _timerbtn =  new FloatingActionButton(
        heroTag: "btn3",
        backgroundColor: Colors.green,
        child: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          _buildorder();
          setState(() {});
        },
      );
    }
    else  {
      if (finalQuestion.type_id == 2) {       //if timed task
        _timerbtn = FloatingActionButton(
            heroTag: "btn3",
            backgroundColor: Colors.blue,
            child: Icon(Icons.timer),
            onPressed: () {
              _startForegroundtimer(finalQuestion.time);
            }
        );
        if (_running) {                       // if timer is running
          _timerbtn = FloatingActionButton(
              heroTag: "btn3",
              backgroundColor: Colors.blue,
              child: _timerbtnchild,
              onPressed: () {
                _haltTimer();
              }
          );
          if  (_halted) {                     //if timer is halted
            _timerbtn = FloatingActionButton(
                heroTag: "btn3",
                backgroundColor: Colors.blue,
                child: _timerbtnchild,
                onPressed: () {
                  _resumeTimer();
                }
            );
          }
        }
      }
      else {                                  //if non timed question
        _timerbtn = FloatingActionButton(
            heroTag: "btn3",
            backgroundColor: Colors.grey,
            child: Icon(Icons.timer),
            onPressed: () {}
        );
      }
    }
  }

  void _haltTimer() {                       //halting the timer
    _secondsLeftHalted = _secondsLeft;
    _foregroundTimer.cancel();
    _halted = true;
    _timerbtnchild= Icon(Icons.pause);
    setState(() {
      thirdRow = _buildThirdRow(finalQuestion);
    });
  }

  void _resumeTimer() {                     //resuming the timer
    _startForegroundtimer(_secondsLeftHalted);

  }

  void _startForegroundtimer(int _duration) {         // starting the timer
    _foregroundTimer = Timer.periodic(Duration(seconds: 1), (Timer t) =>
        setState(() {
          if (_running == false||_halted==true) {
            _secondsLeft = _duration;
            _running = true;
            _halted = false;
          }
          _secondsLeft--;
          _timerbtnchild = Text('$_secondsLeft');
          thirdRow = _buildThirdRow(finalQuestion);
          if (_secondsLeft == 0) {
            _running = false;
            _foregroundTimer.cancel();
            _timerbtnchild = Icon(Icons.timer);
            thirdRow = _buildThirdRow(finalQuestion);
          }
        })
    );
  }

  void _addToStack(int duration, player player, String task) {
    List<String> _splitstring;
    _splitstring = task.split("\$placeholder");
    _splitstring[1].replaceAll("\$placeholder", "");
    RichText _qText = new RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: _splitstring[0],
              style: _orderstyle
          ),
          TextSpan(
              text: player.name.toString(),
              style: player.sex == 'm'
                  ? _maleorderstyle
                  : _femaleorderstyle
          ),
          TextSpan(
              text: _splitstring[1],
              style: _orderstyle
          )
        ],
      ),
      textAlign: TextAlign.center,
    );
    int pos;
    if (_orderStack.length == 0) {
      pos = 0;
      _orderStack[0] = _qText;
    }
    else  {
      pos = _orderStack.length;
      _orderStack[_orderStack.length] = _qText;
    }
    _startBackgroundtimer(duration, pos);
  }

  void  _startBackgroundtimer(int duration, int pos) {
    _backgroundTimer = Timer(Duration(seconds: duration), () {
      showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(child: _orderStack[pos]),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('OK'),
                  onPressed: (){
                  Navigator.of(context).pop();
                  }
                )
              ]
            );
          },
      );
    });
  }
}