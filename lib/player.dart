import 'package:flutter/material.dart';
import 'menuDrawer.dart';

class player {
  int id;
  String name;
  String sex;
  int points;
  static int pic = 0;
  static var playerbase = {};

  player(this.id, this.name, this.sex, this.points);

  player.addPlayer(String newName, String newSex, int newPoints) {
    player newPlayer = new player(pic, newName, newSex, newPoints);
    playerbase[pic] = newPlayer;
    pic++;
  }

}

class editPlayers extends StatefulWidget  {
  @override
  editPlayersState createState() => new editPlayersState();
}

class editPlayersState extends State<editPlayers> {
  final _txtaddPlayersController = new TextEditingController();
  final TextStyle _normalFont = const TextStyle(
      fontSize: 18.0, color: Colors.black);
  String txtplayername;

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
          new Container(child:
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Expanded(
                  child:
                    _iconbuttonmale(),
                    flex: 1
                  ),
                new Expanded(
                  child:
                    _txtaddPlayers(),
                    flex: 1
                ),
                new Expanded(
                    child:
                      _iconbuttonfemale(),
                      flex: 1
                )

              ]
            ),
          ),
          new Container(
            child:
              _buildgridmid()),
          new Container(
            child:
              null),
          new Container(
            child:
              null)
          ]
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildgridmid() {
  }

  Widget _buildgrilowerdmid() {
  }

  Widget _txtaddPlayers() {
    return new TextField(
      controller: _txtaddPlayersController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Bitte gib einen Namen ein',
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
        player.addPlayer(txtplayername, "m", 0);
        _buildgridmid();
        _txtaddPlayersController.clear();
        setState((){});
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
        player.addPlayer(txtplayername, "f", 0);
        _buildgridmid();
        _txtaddPlayersController.clear();
        setState((){});
      },
    );
  }

}