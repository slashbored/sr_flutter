import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'menuDrawer.dart';

class player {
  int id;
  String name;
  String sex;
  int points;
  static int pic = 0;
  static var playerDatabase = {};
  static List playerIds = new List();

  player(this.id, this.name, this.sex, this.points);

  player.addPlayer(String newName, String newSex, int newPoints) {
    player newPlayer = new player(pic, newName, newSex, newPoints);
    playerDatabase[pic] = newPlayer;
    pic++;
  }


  static String getPlayerName(int id){
    player _playerplaceholder = player.playerDatabase[id];
    return _playerplaceholder.name.toString();
  }

  static String getPlayerSex(int id){
    player _playerplaceholder = player.playerDatabase[id];
    return _playerplaceholder.sex.toString();
  }

  static void setPlayerSex(int id, String sex)  {
    player _playerplaceholder = player.playerDatabase[id];
    sex=='m'?_playerplaceholder.sex='m':_playerplaceholder.sex='f';
    player.playerDatabase[id]=_playerplaceholder;
  }

  static int getPlayerPoints(int id){
    player _playerplaceholder = player.playerDatabase[id];
    return _playerplaceholder.points;
  }

  static int getPlayerIdFromList(int id){
    player _playerplaceholder = player.playerDatabase[playerIds[id]];
    return _playerplaceholder.id;
  }

}

class editPlayers extends StatefulWidget  {
  @override
  editPlayersState createState() => new editPlayersState();
}

class editPlayersState extends State<editPlayers> {
  final _txtaddPlayersController = new TextEditingController();
  String txtplayername;
  List playerlist;
  String _playerNamesAsString;
  final TextStyle _normalFont = const TextStyle(
      fontSize: 18.0, color: Colors.black);

  @override
  Widget build(BuildContext context)  {
    return new Scaffold(
      appBar:
        new AppBar(
          title: Text(
            'Spieler bearbeiten'
          ),
          centerTitle: true,
        ),
        drawer:
          menuDrawer(
            context
          ),
      body:
        new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Expanded(child:
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Expanded(
                  child:
                    _iconbuttonmale(),
                    flex: 250
                  ),
                new Expanded(
                  child:
                    _txtaddPlayers(),
                    flex: 500
                ),
                new Expanded(
                    child:
                      _iconbuttonfemale(),
                      flex: 250
                )

              ]
            ),
            flex: 2
          ),
          new Expanded(
            child:
              new Container(
                child:
                  _buildgridmid(),
              ),
              flex: 10,
          ),
          /*new Expanded(
            child:
              new Container(
                child: null
              ),
              flex: 1),
          new Expanded(
            child:
              new Container(
                child:
                  null),
              flex: 1)*/
          ]
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildgridmid() {

    if (player.playerDatabase.length>0){
      player.playerIds.clear();
      String _playerNamesAsString = '';
      int _playerCounter = 0;
      /*int modPlayerCounter;
      int timesPlayerCounter;
      int rowCounter;
      int columnCounter;*/
      for (player _playerplaceholder in player.playerDatabase.values){
        _playerNamesAsString = _playerNamesAsString + '${_playerplaceholder.name}, ';
        player.playerIds.add(_playerplaceholder.id);
        _playerCounter++;
      }
      /*timesPlayerCounter = playerCounter ~/ 3;
      modPlayerCounter = playerCounter % 3;*/
      return new GridView.count(
        crossAxisCount: 3,
        children: List.generate(_playerCounter, (index) {
              return GridTile(
                child: new Card(
                  child: new Center(
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:[
                          new Expanded(
                            child: new Container(
                            child: null
                            ),
                            flex: 1
                          ),
                          new Expanded(
                            child: new Center(
                              child: new Text(
                                  player.getPlayerName(player.playerIds[index]),
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: (player.getPlayerSex(player.playerIds[index]).toString()=='m')?Colors.blue:Colors.red
                                  )
                              )
                            ),
                            flex: 1
                          ),
                          new Expanded(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>  [
                                new IconButton(
                                  icon: Icon(Icons.repeat),
                                  color: Colors.green,
                                  onPressed: (){
                                    setState((){
                                      if (player.getPlayerSex(player.playerIds[index]).toString()=='m') {
                                        player.setPlayerSex(player.playerIds[index], 'f');
                                      }
                                      else  {
                                        player.setPlayerSex(player.playerIds[index], 'm');
                                      }
                                    });
                                  }
                              ),
                                new IconButton(icon: Icon(Icons.clear), onPressed: (){
                                  player.playerDatabase.remove(player.playerIds[index]);
                                  setState((){});
                                }
                                )
                              ]
                            ),
                            flex: 1
                          )
                        ]
                      )
                  )
                )
              );
        }
        )
      );
      setState((){});
    }
    else  {
      return new Center(
        child:
          new Text('Bitte einen Spieler hinzufügen.')
      );
    }

  }

  Widget _txtaddPlayers() {
    return new TextField(
      controller: _txtaddPlayersController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Name',
      ),
      textAlign: TextAlign.center,
      autocorrect: false,
      style: _normalFont,
      onChanged: (text) {
        txtplayername = (text.toString());
      },
    );
  }

  Widget _iconbuttonmale()  {
    return new IconButton(
      icon: Icon(Icons.add_circle),
      color: Colors.blue,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        if  (txtplayername==''||txtplayername==null||txtplayername=='null'){}
        else  {
        player.addPlayer(txtplayername, "m", 0);
        _buildgridmid();
        _txtaddPlayersController.clear();
        txtplayername = '';
        setState((){});
        }
      },
    );
  }

  Widget _iconbuttonfemale()  {
    return new IconButton(
      icon: Icon(Icons.add_circle),
      color: Colors.red,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        if  (txtplayername==''||txtplayername==null||txtplayername=='null'){}
        else {
          player.addPlayer(txtplayername, "f", 0);
          _buildgridmid();
          _txtaddPlayersController.clear();
          txtplayername = '';
          setState((){});
        }
      },
    );
  }

}