import 'package:flutter/material.dart';
import 'player.dart';
import 'db.dart';
import 'question.dart';
import 'category.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shitroulette',
      theme: new ThemeData(
        primaryColor: Colors.black,
      ),
      home: new addPlayers(),
    );
  }
}

class addPlayers extends StatefulWidget  {
  @override
  addPlayersState createState() => new addPlayersState();
}

class addPlayersState extends State<addPlayers> {
  final _txtaddPlayersController = new TextEditingController();
  final List<String> _playerlist = <String>[];
  List<String> _questionlist = <String>[];
  String txtplayername;
  int mic;
  final Text _txtbot = new Text('Bottom');
  final TextStyle _normalFont = const TextStyle(
      fontSize: 18.0, color: Colors.black);

  @override
  void initState()  {
    super.initState();
    setState(() {
      if(player.playerbase[0]==null){
        builddb();
       /*         print('"${question.questionbase[question.qic].descr} + " has been pulled from the db!');
        for(var i = 0;i <= question.qic; i++){
          _questionlist.add(question.questionbase[i].descr.toString());
        }
        _buildgridbot();*/
      }
    });
  }

  @override
  Widget build(BuildContext context)  {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Add/remove players'),
        centerTitle: true,
      ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new Container(child:
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new Expanded(
                    child: _iconbuttonmale(),
                    flex: 1
                  ),
                  new Expanded(
                    child: _txtaddPlayers(),
                    flex: 1
                  ),
                  new Expanded(
                    child: _iconbuttonfemale(),
                  flex: 1
                  )
                ]
              ),
            ),
            new Container(child: _buildgridmid()),
            new Container(child: _buildgridbot()),
            new Container(child: null)
          ]
        ),
        resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildgridmid() {
    return new Row(children: _playerlist.map((item) => new Text(item)).toList());

  }

  Widget _buildgridbot(){
    return new Row(children: _questionlist.map((item) => new Text(item)).toList());
  }

  Widget _txtaddPlayers() {
    return new TextField(
      controller: _txtaddPlayersController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Enter a name',
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
        print("TAP TAP MALE");
        _playerlist.add(txtplayername);
        player.addPlayer(txtplayername, "m", player.pic);
        _playerlist.add(player.playerbase[player.pic].name.toString());
        //print('${player.playerbase[player.pic].name} + mofo!');x
        //builddb();
        print('"${question.questionbase[question.qic].descr} + " has been pulled from the db!');
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
        print("TAP TAP FEMALE");
        print(txtplayername);
        _playerlist.add(txtplayername);
        player.addPlayer(txtplayername, "f", player.pic);
        //print('${player.playerbase[player.pic].name} + mofo!');
        _buildgridmid();
        _txtaddPlayersController.clear();
        setState((){});
      },
    );
  }

}