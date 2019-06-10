import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'player.dart';
import 'question.dart';
import 'category.dart';
import 'orderFirstRow.dart';
import 'orderSecondRow.dart';
import 'orderDrawer.dart';

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

class combo {
  int playerId;
  int questionId;
  static int coic = 0;
  static var combohistory = {};

  combo(this.playerId, this.questionId);

  combo.addCombo(int playerId, int questionId) {
    combo _comboplaceholder = new combo(playerId, questionId);
    combohistory[coic] = _comboplaceholder;
    coic;
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
  static int lastFirstplayerID;
  static int lastSecondplayerID;
  static bool duplicate;

  //Buttonblock
  static FloatingActionButton acceptedbtn;
  static Row deniedbtnrow;
  static FloatingActionButton deniedbtnfirstplayer;
  static FloatingActionButton deniedbtnsecondplayer;
  static FloatingActionButton deniedbtnboth;

  //Timerbutton & -block
  static FloatingActionButton timerbtn;
  static Timer foregroundTimer;
  static var timerbtnchild;
  static int secondsLeft;
  static int secondsLeftHalted;
  static bool running;
  static bool halted;
  static Timer backgroundTimer;
  static var orderStack = {};

  //Finalblock
  static player finalFirstPlayer;
  static player finalSecondPlayer;
  static question finalQuestion;
  static String finalOrderString;

  //Rowblock
  static Row firstRow;
  static RichText secondRow;
  static Row thirdRow;
  static Row fourthRow;

  static String scores;
  static int i=0;

  /*final TextStyle maleorderstyle = const TextStyle(
      fontSize: 24,
      color: Colors.blue
  );*/

  /*final TextStyle femaleorderstyle = const TextStyle(
      fontSize: 24,
      color: Colors.red
  );*/

  /*final TextStyle orderstyle = const TextStyle(
      fontSize: 24,
      color: Colors.black
  );*/


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
      }
      running = false;
      halted = false;
      buildorder();
    });
  }

  @override
  void dispose() {
    foregroundTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: new Scaffold(
            body:
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        new Expanded(
                          child: new Center(
                            child: firstRow
                          ),
                          flex: 310
                        ),
                        new Expanded(
                          child: new Center(
                            child: secondRow
                          ),
                          flex: 310
                        ),
                        new Expanded(
                          child: thirdRow,
                          flex: 310
                        ),
                        new Expanded(
                          child: fourthRow,
                          flex: 70
                        )
                      ]
                  ),
        ),
        onWillPop: () async => false
    );
  }

  void buildorder() {
    //Questionblock
    randomQuestionID = random.nextInt(order.orderDatabase.length);
    order _orderplaceholder = order.orderDatabase[randomQuestionID];
    if (_orderplaceholder.usedAmount < _orderplaceholder.allowedAmount) {
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
        if(_orderplaceholder.subtypeID==2)  {
          _orderplaceholder.allowedAmount = 1;
          _orderplaceholder.usedAmount++;
        }
        else  {
          for (order _orderplaceholder2 in order.orderDatabase.values)  {
            _orderplaceholder2.subtypeID==_orderplaceholder.subtypeID?order.setUsedAmount(_orderplaceholder2.id, _orderplaceholder2.allowedAmount):null;
          }
        }
      }
      else  {
        _orderplaceholder.usedAmount++;
      }

      //Playerblock
      randomFirstPlayerID = random.nextInt(player.playerDatabase.length);
      while (randomFirstPlayerID == lastFirstplayerID) {
        randomFirstPlayerID = random.nextInt(player.playerDatabase.length);
      }
      finalFirstPlayer=player.playerDatabase[player.getPlayerIdFromList(randomFirstPlayerID)];


      if (randomSelectorID == 1) {
        while (randomSecondPlayerID == null ||
            randomSecondPlayerID == randomFirstPlayerID ||
            randomSecondPlayerID == lastSecondplayerID) {
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
      for (combo _comboplaceholder in combo.combohistory.values)  {
        if  (duplicate!=true) {
          combo _currentcombo = combo(finalFirstPlayer.id, finalQuestion.id);
          _currentcombo==_comboplaceholder?duplicate=true:duplicate=false;
        }
      }
      if (duplicate==true)  {
        buildorder();
      }
      else{
        lastFirstplayerID = finalFirstPlayer.id;
        finalSecondPlayer!=null?lastSecondplayerID = finalSecondPlayer.id:null;
        combo.addCombo(finalFirstPlayer.id, finalQuestion.id);
        combo.coic++;
        finalOrderString = question.getQuestionText(order.getQuestionID(randomQuestionID), randomSelectorChar);
        firstRow = buildfirstRow(context, finalFirstPlayer, finalSecondPlayer, finalQuestion);
        secondRow = buildSecondRow(finalFirstPlayer, finalSecondPlayer, finalOrderString);
        thirdRow = buildThirdRow(finalQuestion, finalFirstPlayer, finalSecondPlayer);
        fourthRow = _buildFourthRow();
      }
    }

    else {
      order.uoic++;
      if (order.uoic >= order.orderDatabase.length * 0.75) {
        for (order _orderplaceholder in order.orderDatabase.values) {
          if  (_orderplaceholder.subtypeID==1)  {
            order.setUsedAmount(_orderplaceholder.id, 0);
          }
        }
        order.uoic = 0;
      }
      buildorder();
    }
  }

  /* Widget buildfirstRow(player firstPlayer, player secondPlayer) {
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
                        text: " " + finalFirstPlayer.icon,
                          style: TextStyle(
                            fontSize: 36
                          )
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
    if (finalQuestion.type_id==6) {
      return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Center(
              child: new Container(
                child: new RichText(
                    text: new TextSpan(
                        children: <TextSpan>[
                          new TextSpan(
                            text: 'Abstimmen, Verlierer trinken:',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.green,
                            ),
                          ),
                        ]
                    ),
                  textAlign: TextAlign.center,
                ),
                width: MediaQuery.of(context).size.width*0.75,
              )
          )
        ],
      );
    }
   else {
     if (secondPlayer == null) {
       return new Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             /*new Expanded(
                 child: new Text(
                     firstPlayer.points.toString(),
                     textAlign: TextAlign.center,
                     style: TextStyle(
                         fontSize: 36
                     )
                 ),
                 flex: 1
             ),*/
             new Expanded(
                  child: new RichText(
                      text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: firstPlayer.name,
                              style: firstPlayer.sex == 'm'
                                  ? _maletitlestyle
                                  : _femaletitlestyle,
                            ),
                            TextSpan(
                                text: " " + finalFirstPlayer.icon,
                                style: TextStyle(
                                    fontSize: 36
                                )
                            ),
                          ]
                      ),
                    textAlign: TextAlign.center,
                  ),
             ),
           ]
       );
     }
     else {
       return new Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             /*new Expanded(
                 child: new Text(
                     firstPlayer.points.toString(),
                     textAlign: TextAlign.center,
                     style: TextStyle(
                         fontSize:36
                     )
                 ),
                 flex: 1
             ),*/
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
                             text: " " + finalFirstPlayer.icon,
                             style: TextStyle(
                                 fontSize: 36
                             )
                         ),
                         TextSpan(
                             text: '\n&\n',
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
                         ),
                         TextSpan(
                             text: " " + finalSecondPlayer.icon,
                             style: TextStyle(
                                 fontSize: 36
                             )
                         ),
                       ]
                   ),
                   textAlign: TextAlign.center,
                 ),
                 flex: 1
             ),
             /*new Expanded(
                 child: new Text(
                     secondPlayer.points.toString(),
                     textAlign: TextAlign.center,
                     style: TextStyle(
                         fontSize:36
                     )
                 ),
                 flex: 1
             )*/
           ]
       );
     }
   }
  } */

  /*Widget buildSecondRow(player firstPlayer, player secondPlayer) {
    List<String> _splitstring;
    int sipsp1;
    int sipsp2;
    if (secondPlayer == null) {
      if (finalOrderString.contains("\$pointholderone")) {
        sipsp1 = firstPlayer.points +2;
        finalOrderString = finalOrderString.replaceAll(new RegExp(r"\$pointholderone"), sipsp1.toString());
        /*if (sipsp1==1&&finalOrderString.contains("Schlücke")) {
          finalOrderString = finalOrderString.replaceAll(new RegExp(r"Schlücke"), "Schluck");
        }*/
      }
      return new RichText(
        text: TextSpan(
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
      if (finalOrderString.contains("\$pointholderone")) {
        sipsp1 = firstPlayer.points +2;
        sipsp2 = secondPlayer.points +2;
        finalOrderString = finalOrderString.replaceAll(new RegExp(r"\$pointholderone"), sipsp1.toString());
        finalOrderString = finalOrderString.replaceAll(new RegExp(r"\$pointholdertwo"), sipsp2.toString());
        /*if (sipsp2==1&&finalOrderString.contains("Schlücke")) {
          finalOrderString = finalOrderString.replaceAll(new RegExp(r"Schlücke"), "Schluck");
        }*/
      }
      _splitstring = finalOrderString.split("\$placeholder");
      _splitstring[1].replaceAll("\$placeholder", "");
      _splitstring[2].replaceAll("\$placeholder", "");
      return new RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: firstPlayer.name.toString(),
                  style: firstPlayer.sex=='m'?_maleorderstyle:_femaleorderstyle
              ),
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
              ),
              TextSpan(
                  text: secondPlayer.name.toString(),
                  style: secondPlayer.sex=='m'?_maleorderstyle:_femaleorderstyle
              ),
              TextSpan(
                  text: _splitstring[2],
                  style: _orderstyle
              )
            ],
          ),
          textAlign: TextAlign.center,
        );
    }
  }*/

  Widget buildThirdRow(question question, player firstPlayer, player secondPlayer) {
    _buildAcceptedbutton();
    _buildTimerbutton(question);
    _buildDeniedbuttonrow(firstPlayer, secondPlayer);
    if  (question.type_id==4||question.type_id==5)  {
      return new Row(
          children: [
            new Spacer(
                flex: 3
            ),
            new Expanded(
                child: timerbtn,
                flex: 1
            ),
            new Spacer(
                flex: 3
            )
          ]
      );
    }
    if  (question.type_id==6)  {
      return new Row(
          children: [
            new Expanded(
                child: timerbtn,
                flex: 1
            ),
            new Expanded(
                child: acceptedbtn,
              flex: 1
            )
          ]
      );
    }
    else {
      return new Row(
          children: [
            new Expanded(
                child: deniedbtnrow,
                flex: 3
            ),
            new Expanded(
                child: timerbtn,
                flex: 1
            ),
            new Expanded(
                child: acceptedbtn,
                flex: 3
            )
          ]
      );
    }
  }

  Widget _buildFourthRow()  {
    scores="";
    for (player _playerplaceholder in player.playerDatabase.values)  {
      scores = scores + " " + _playerplaceholder.icon + ":" + _playerplaceholder.points.toString() + " ";
    }
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
          scores,
          style: TextStyle(
            fontSize: 12
          ),
        )
      ],
    );
  }

  void  _buildDeniedbuttonrow  (player firstPlayer, player secondPlayer) {
    deniedbtnfirstplayer = new FloatingActionButton(
        heroTag: "btn1",
        child: Icon(Icons.thumb_down),
        backgroundColor: Colors.red,
        onPressed: () {
          firstPlayer.points = firstPlayer.points + 2;
          foregroundTimer==null?null:foregroundTimer.cancel();
          running = false;
          buildorder();
          setState(() {});
        }
    );
    deniedbtnrow = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        deniedbtnfirstplayer
      ],
    );
    if (secondPlayer!=null)  {
       deniedbtnfirstplayer = new FloatingActionButton(
           heroTag: "btn1",
           child: new Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               new Text(
                   firstPlayer.name
               ),
               new Icon(Icons.thumb_down)
             ],
           ),
           backgroundColor: Colors.red,
           onPressed: () {
             firstPlayer.points = firstPlayer.points + 2;
             foregroundTimer==null?null:foregroundTimer.cancel();
             running = false;
             buildorder();
             setState(() {});
           }
       );
       deniedbtnsecondplayer = new FloatingActionButton(
           heroTag: "btn2",
           child: new Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               new Text(
                   secondPlayer.name
               ),
               new Icon(Icons.thumb_down)
             ],
           ),
           backgroundColor: Colors.red,
           onPressed: () {
             secondPlayer.points = secondPlayer.points + 2;
             foregroundTimer==null?null:foregroundTimer.cancel();
             running = false;
             buildorder();
             setState(() {});
           }
       );
       deniedbtnboth = new FloatingActionButton(
           heroTag: "btn3",
           child: new Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               new Text(
                   'Beide'
               ),
               new Icon(Icons.thumb_down)
             ],
           ),
           backgroundColor: Colors.red,
           onPressed: () {
             firstPlayer.points = firstPlayer.points + 2;
             secondPlayer.points = secondPlayer.points + 2;
             foregroundTimer==null?null:foregroundTimer.cancel();
             running = false;
             buildorder();
             setState(() {});
           }
       );
       deniedbtnrow = new Row(
         mainAxisSize: MainAxisSize.min,
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
          new Expanded(
            child: Transform.scale(
              scale: 0.5,
              child: deniedbtnfirstplayer,
            ),
            flex: 2
          ),
           new Expanded(
            child: deniedbtnboth,
            flex :3
          ),
           new Expanded(
             child: Transform.scale(
               scale: 0.5,
               child: deniedbtnsecondplayer,
               ),
             flex: 2


           )
         ],
       );
     }

  }

  void  _buildAcceptedbutton () {
      if (finalQuestion.type_id==6) {
        acceptedbtn =  new FloatingActionButton(
          heroTag: "btn4",
          backgroundColor: Colors.green,
          child: Icon(Icons.play_arrow),
          onPressed: () {
            foregroundTimer==null?null:foregroundTimer.cancel();
            running=false;
            buildorder();
            setState(() {});
          },
        );
      }
      else  {
        acceptedbtn =  new FloatingActionButton(
          heroTag: "btn4",
          backgroundColor: Colors.green,
          child: Icon(Icons.thumb_up),
          onPressed: () {
            foregroundTimer==null?null:foregroundTimer.cancel();
            running=false;
            finalQuestion.type_id==3?addToStack(finalQuestion.time, finalFirstPlayer, finalQuestion.taskq):null;
            buildorder();
            setState(() {});
          },
        );
      }
  }

  void _buildTimerbutton(question question) {
    if  (question.type_id==4||question.type_id==5)  {
      timerbtn =  new FloatingActionButton(
        heroTag: "btn5",
        backgroundColor: Colors.green,
        child: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          buildorder();
          setState(() {});
        },
      );
    }
    else  {
      if (question.type_id == 2||question.type_id == 6) {       //if timed task
        timerbtn = FloatingActionButton(
            heroTag: "btn5",
            backgroundColor: Colors.blue,
            child: Icon(Icons.timer),
            onPressed: () {
              startForegroundtimer(question.time);
              setState(() {});
            }
        );
        if (running) {                       // if timer is running
          timerbtn = FloatingActionButton(
              heroTag: "btn5",
              backgroundColor: Colors.blue,
              child: timerbtnchild,
              onPressed: () {
                haltTimer();
              }
          );
          if  (halted) {                     //if timer is halted
            timerbtn = FloatingActionButton(
                heroTag: "btn5",
                backgroundColor: Colors.blue,
                child: timerbtnchild,
                onPressed: () {
                  resumeTimer();
                }
            );
          }
        }
      }
      else {                                  //if non timed question
        timerbtn = FloatingActionButton(
            heroTag: "btn5",
            backgroundColor: Colors.grey,
            child: Icon(Icons.timer),
            onPressed: () {}
        );
      }
    }
  }

  void haltTimer() {                       //halting the timer
    secondsLeftHalted = secondsLeft;
    foregroundTimer.cancel();
    halted = true;
    timerbtnchild= Icon(Icons.pause);
    setState(() {
      thirdRow = buildThirdRow(finalQuestion, finalFirstPlayer, finalSecondPlayer);
    });
  }

  void resumeTimer() {                     //resuming the timer
    startForegroundtimer(secondsLeftHalted);

  }

  void startForegroundtimer(int _duration) {         // starting the timer
    foregroundTimer = Timer.periodic(Duration(seconds: 1), (Timer t) =>
        setState(() {
          if (running == false||halted==true) {
            secondsLeft = _duration;
            running = true;
            halted = false;
          }
          secondsLeft--;
          timerbtnchild = Text('$secondsLeft');
          thirdRow = buildThirdRow(finalQuestion, finalFirstPlayer, finalSecondPlayer);
          if (secondsLeft == 0) {
            running = false;
            foregroundTimer.cancel();
            timerbtnchild = Icon(Icons.timer);
            thirdRow = buildThirdRow(finalQuestion, finalFirstPlayer, finalSecondPlayer);
          }
        })
    );
  }

  void addToStack(int duration, player player, String task) {
    List<String> _splitstring;
    _splitstring = task.split("\$placeholder");
    _splitstring[1].replaceAll("\$placeholder", "");
    RichText _qText = new RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: _splitstring[0],
              style: orderstyle
          ),
          TextSpan(
              text: player.name.toString(),
              style: player.sex == 'm'
                  ? maleorderstyle
                  : femaleorderstyle
          ),
          TextSpan(
              text: _splitstring[1],
              style: orderstyle
          )
        ],
      ),
      textAlign: TextAlign.center,
    );
    int pos;
    if (orderStack.length == 0) {
      pos = 0;
      orderStack[0] = _qText;
    }
    else  {
      pos = orderStack.length;
      orderStack[orderStack.length] = _qText;
    }
    startBackgroundtimer(duration, pos);
  }

  void  startBackgroundtimer(int duration, int pos) {
    backgroundTimer = Timer(Duration(seconds: duration), () {
      showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(child: orderStack[pos]),
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