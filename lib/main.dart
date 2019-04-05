import 'package:flutter/material.dart';

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
  String txtplayername;
  /*final Text _txtmid = new Text('Middle');*/
  final Text _txtbot = new Text('Bottom');
  final TextStyle _normalFont = const TextStyle(fontSize: 18.0, color: Colors.black);
  /*final _malebuttoncontainer = new InkWell(
      child:  Container(
        child:  new Icon(
            Icons.add_circle, color: Colors.blue
        ),
      ),
      onTap:  ()  {
        print("Tappy tap male!");
      }
  );*/
  /*final _femalbuttoncontainer = new InkWell(
      child:  Container(
          child:  new Icon(
              Icons.add_circle, color: Colors.red
          ),
      ),
      onTap:  ()  {
        print("Tappy tap female!");
      }
  );*/


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
                    /*child: _malebuttoncontainer*/
                    child: _iconbuttonmale(),
                    flex: 1
                  ),
                  new Expanded(
                    child: _txtaddPlayers(),
                    flex: 1
                  ),
                  new Expanded(
                    /*child: _femalbuttoncontainer*/
                    child: _iconbuttonfemale(),
                  flex: 1
                  )
                ]
              ),
            ),
            new Container(child: _buildgrid()),
            new Container(child: _txtbot),
            new Container(child: null)
          ]
        ),
        resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildgrid() {
    return new Row(children: _playerlist.map((item) => new Text(item)).toList());
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
      /* onSubmitted: (text) {
        print("Text is: $text");
        _playerlist.add(text);
        print(_playerlist);
        _buildgrid();
      }, */
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
        print(_playerlist);
        _buildgrid();
        _txtaddPlayersController.clear();
        setState((){});
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
        print(txtplayername);
        _playerlist.add(txtplayername);
        print(_playerlist);
        _buildgrid();
        _txtaddPlayersController.clear();
        setState((){});
      },
    );
  }
}