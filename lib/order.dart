import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'player.dart';
import 'question.dart';
import 'category.dart';
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
  static FloatingActionButton _acceptedbtn;
  static Row _deniedbtnrow;
  static FloatingActionButton _deniedbtnfirstplayer;
  static FloatingActionButton _deniedbtnsecondplayer;
  static FloatingActionButton _deniedbtnboth;

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
  static Row fourthRow;

  static String scores;
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
            body:
                  /*new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ListView.builder(
                        itemCount: player.playerDatabase.length,
                        itemBuilder: (BuildContext context, int index)  {
                          return new ListTile(
                            title:  new Text(
                              player.getPlayerName(player.playerIds[index]),
                              textAlign: TextAlign.center,),
                            trailing: new Row(
                              children: <Widget>[
                                new Text(
                                    player.getPlayerPoints(player.playerIds[index]).toString()
                                ),
                                new IconButton(
                                  icon: Icon(Icons.remove_circle,),
                                  color: Colors.red,
                                  onPressed: null,)
                              ],
                              mainAxisSize: MainAxisSize.min,
                            ),
                          );
                        },
                        shrinkWrap: true,
                      )
                    ],
                  ),*/
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

  void _buildorder() {
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
        _buildorder();
      }
      else{
        lastFirstplayerID = finalFirstPlayer.id;
        finalSecondPlayer!=null?lastSecondplayerID = finalSecondPlayer.id:null;
        combo.addCombo(finalFirstPlayer.id, finalQuestion.id);
        combo.coic++;
        finalOrderString = question.getQuestionText(order.getQuestionID(randomQuestionID), randomSelectorChar);
        firstRow = _buildfirstRow(finalFirstPlayer, finalSecondPlayer);
        secondRow = _buildSecondRow(finalFirstPlayer, finalSecondPlayer);
        thirdRow = _buildThirdRow(finalQuestion);
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
  }

  Widget _buildSecondRow(player firstPlayer, player secondPlayer) {
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
  }

  Widget _buildThirdRow(question question) {
    _buildAcceptedbutton();
    _buildTimerbutton();
    _buildDeniedbuttonrow();
    if  (finalQuestion.type_id==4||finalQuestion.type_id==5)  {
      return new Row(
          children: [
            new Spacer(
                flex: 3
            ),
            new Expanded(
                child: _timerbtn,
                flex: 1
            ),
            new Spacer(
                flex: 3
            )
          ]
      );
    }
    if  (finalQuestion.type_id==6)  {
      return new Row(
          children: [
            new Expanded(
                child: _timerbtn,
                flex: 1
            ),
            new Expanded(
                child: _acceptedbtn,
              flex: 1
            )
          ]
      );
    }
    else {
      return new Row(
          children: [
            new Expanded(
                child: _deniedbtnrow,
                flex: 3
            ),
            new Expanded(
                child: _timerbtn,
                flex: 1
            ),
            new Expanded(
                child: _acceptedbtn,
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

  void  _buildDeniedbuttonrow  () {
    _deniedbtnfirstplayer = new FloatingActionButton(
        heroTag: "btn1",
        child: Icon(Icons.thumb_down),
        backgroundColor: Colors.red,
        onPressed: () {
          finalFirstPlayer.points = finalFirstPlayer.points + 2;
          _foregroundTimer==null?null:_foregroundTimer.cancel();
          _running = false;
          _buildorder();
          setState(() {});
        }
    );
    _deniedbtnrow = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _deniedbtnfirstplayer
      ],
    );
    if (finalSecondPlayer!=null)  {
       _deniedbtnfirstplayer = new FloatingActionButton(
           heroTag: "btn1",
           child: new Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               new Text(
                   finalFirstPlayer.name
               ),
               new Icon(Icons.thumb_down)
             ],
           ),
           backgroundColor: Colors.red,
           onPressed: () {
             finalFirstPlayer.points = finalFirstPlayer.points + 2;
             _foregroundTimer==null?null:_foregroundTimer.cancel();
             _running = false;
             _buildorder();
             setState(() {});
           }
       );
       _deniedbtnsecondplayer = new FloatingActionButton(
           heroTag: "btn2",
           child: new Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               new Text(
                   finalSecondPlayer.name
               ),
               new Icon(Icons.thumb_down)
             ],
           ),
           backgroundColor: Colors.red,
           onPressed: () {
             finalSecondPlayer.points = finalSecondPlayer.points + 2;
             _foregroundTimer==null?null:_foregroundTimer.cancel();
             _running = false;
             _buildorder();
             setState(() {});
           }
       );
       _deniedbtnboth = new FloatingActionButton(
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
             finalFirstPlayer.points = finalFirstPlayer.points + 2;
             finalSecondPlayer.points = finalSecondPlayer.points + 2;
             _foregroundTimer==null?null:_foregroundTimer.cancel();
             _running = false;
             _buildorder();
             setState(() {});
           }
       );
       _deniedbtnrow = new Row(
         mainAxisSize: MainAxisSize.min,
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
          new Expanded(
            child: Transform.scale(
              scale: 0.5,
              child: _deniedbtnfirstplayer,
            ),
            flex: 2
          ),
           new Expanded(
            child: _deniedbtnboth,
            flex :3
          ),
           new Expanded(
             child: Transform.scale(
               scale: 0.5,
               child: _deniedbtnsecondplayer,
               ),
             flex: 2


           )
         ],
       );
     }

  }


  void  _buildAcceptedbutton () {
      if (finalQuestion.type_id==6) {
        _acceptedbtn =  new FloatingActionButton(
          heroTag: "btn4",
          backgroundColor: Colors.green,
          child: Icon(Icons.play_arrow),
          onPressed: () {
            _foregroundTimer==null?null:_foregroundTimer.cancel();
            _running=false;
            _buildorder();
            setState(() {});
          },
        );
      }
      else  {
        _acceptedbtn =  new FloatingActionButton(
          heroTag: "btn4",
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
  }

  void _buildTimerbutton() {
    if  (finalQuestion.type_id==4||finalQuestion.type_id==5)  {
      _timerbtn =  new FloatingActionButton(
        heroTag: "btn5",
        backgroundColor: Colors.green,
        child: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          _buildorder();
          setState(() {});
        },
      );
    }
    else  {
      if (finalQuestion.type_id == 2||finalQuestion.type_id == 6) {       //if timed task
        _timerbtn = FloatingActionButton(
            heroTag: "btn5",
            backgroundColor: Colors.blue,
            child: Icon(Icons.timer),
            onPressed: () {
              _startForegroundtimer(finalQuestion.time);
              setState(() {});
            }
        );
        if (_running) {                       // if timer is running
          _timerbtn = FloatingActionButton(
              heroTag: "btn5",
              backgroundColor: Colors.blue,
              child: _timerbtnchild,
              onPressed: () {
                _haltTimer();
              }
          );
          if  (_halted) {                     //if timer is halted
            _timerbtn = FloatingActionButton(
                heroTag: "btn5",
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
            heroTag: "btn5",
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