import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'menuDrawer.dart';

class player {
  int id;
  String name;
  String sex;
  String icon;
  int points;
  static int pic = 0;
  static var playerDatabase = {};
  static List playerIds = new List();

  player(this.id, this.name, this.sex, this.icon, this.points);

  player.addPlayer(String newName, String newSex, String newIcon, int newPoints) {
    player newPlayer = new player(pic, newName, newSex, newIcon, newPoints);
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

  static void swapSex(int id) {
    player _playerplaceholder = player.playerDatabase[id];
    _playerplaceholder.sex=='f'?_playerplaceholder.sex='m':_playerplaceholder.sex='f';
    player.playerDatabase[id]=_playerplaceholder;
  }

  static String getPlayerIcon(int id) {
    player _playerplaceholder = player.playerDatabase[id];
    return _playerplaceholder.icon;
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

  final TextStyle _normalFont = const TextStyle(
      fontSize: 15.0,
      color: Colors.black
  );

  final TextStyle _normalFontInverted = const TextStyle(
      fontSize: 15.0,
      color: Colors.white
  );

  Set<String> iconDB = {" ", "🍆", "🍻", "🤤", "💩", "🦄", "🐽", "🤓", "👻", "🍑", "🍌", "🎈", "💯", "🍓", "🔥", "👑", "👀"};
  String dropdownValue;
  Row inputChipLabel = new Row(
  );



  @override
  Widget build(BuildContext context)  {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
            'Spieler bearbeiten'
        ),
        centerTitle: true,
      ),
      //drawer: menuDrawer(context),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Expanded(
                  child:  _iconbuttonmale(),
                  flex: 250
                ),
                new Spacer(
                  flex: 125
                ),
                new Expanded(
                  child:  _txtaddPlayers(),
                  flex: 400
                ),
                new Expanded(
                  child: _iconbuttonicon(),
                  flex: 125
                ),
                new Expanded(
                  child:  _iconbuttonfemale(),
                  flex: 250
                )
              ]
            ),
            flex: 2
          ),
          new Expanded(
            child: new Container(
              child: _buildgridmid(),
            ),
            flex: 10,
          ),
          new Expanded(
            child: new InputChip(
              label: Text(
                "abc"
              ),
              avatar: CircleAvatar(
                child: Text(
                  "ab"
                ),
              ),
            ),
          )
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
      for (player _playerplaceholder in player.playerDatabase.values){
        _playerNamesAsString = _playerNamesAsString + '${_playerplaceholder.name}, ';
        player.playerIds.add(_playerplaceholder.id);
        _playerCounter++;
      }
      return Center(
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
            alignment: WrapAlignment.center,
            children:  List.generate(_playerCounter, (index) {
              return Transform.scale(scale: 0.75,child: Chip(
                  avatar: CircleAvatar(
                    child: Text(
                      player.getPlayerIcon(player.playerIds[index]),
                      style: _normalFontInverted,
                    ),
                    backgroundColor: getSexcolor(player.playerIds[index]),
                  ),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                          player.getPlayerName(player.playerIds[index]),
                          style: _normalFontInverted
                      ),
                      IconButton(
                        icon: Icon(Icons.autorenew),
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            player.swapSex(player.playerIds[index]);
                          });
                        },
                      ),
                    ],
                  ),
                  backgroundColor: getSexcolor(player.playerIds[index]),
                  deleteIconColor: Colors.white,
                  deleteIcon: Icon(Icons.close),
                  onDeleted: () {
                    setState(() {
                      iconDB.add(player.getPlayerIcon(player.playerIds[index]));
                      player.playerDatabase.remove(player.playerIds[index]);
                    });
                  }
              ),);
            }
            )
        ),
      );
      /*return new GridView.count(
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
                          player.getPlayerName(player.playerIds[index]) + " " + player.getPlayerIcon(player.playerIds[index]),
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
                            iconDB.add(player.getPlayerIcon(player.playerIds[index]));
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
        })
      )*/
      }
    else  {
      return new Center(
        child:
          new Text(
              'Bitte einen Spieler hinzufügen.'
          )
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

  Widget _iconbuttonicon()  {
    return new DropdownButton<String>(
        value: dropdownValue,
        onChanged: (String newValue) {
      setState(() {
        dropdownValue = newValue;
      });
    },
    //items: <String>["🍆", "🍻", "🤤", "💩", "🦄", "🐽", "🤓", "👻", "🍑", "🍌", "🎈", "💯", "🍓", "🔥", "👑", "👀"]
        items: iconDB.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
    value: value,
    child: Text(value),
    );
    }).toList());
  }

  Widget _iconbuttonmale()  {
    return new IconButton(
      icon: new Icon(Icons.add_circle),
      color: Colors.blue,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed:  ()  {
        if  (txtplayername!=''&&txtplayername!=null&&txtplayername!='null'&&dropdownValue!=" ") {
          player.addPlayer(txtplayername, "m", dropdownValue, 0);
          _buildgridmid();
          _txtaddPlayersController.clear();
          txtplayername = '';
          setState((){
            iconDB.remove(dropdownValue);
            dropdownValue=" ";
          });
        }
      },
    );
  }

  Widget _iconbuttonfemale()  {
    return new IconButton(
      icon: new Icon(Icons.add_circle),
      color: Colors.red,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        if  (txtplayername!=''&&txtplayername!=null&&txtplayername!='null'&&dropdownValue!=" ") {
          player.addPlayer(txtplayername, "f", dropdownValue, 0);
          _buildgridmid();
          _txtaddPlayersController.clear();
          txtplayername = '';
          setState((){
            iconDB.remove(dropdownValue);
            dropdownValue=" ";
          });
        }
      },
    );
  }

  TextStyle getTextstyle(int id)  {
    TextStyle styleplaceholder =   TextStyle(
      fontSize: 18.0,
      color: getSexcolor(id)
    );
    return styleplaceholder;
  }

  Color getSexcolor(int id) {
    Color colorplaceholder = player.getPlayerSex(id)=="f"?Colors.red:Colors.blue;
    return colorplaceholder;
  }
}