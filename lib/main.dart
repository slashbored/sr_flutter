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
  final List<String> _playerlist = <String>[];
  final TextStyle _normalFont = const TextStyle(fontSize: 18.0, color: Colors.black);
  final _malebuttoncontainer = new InkWell(
      child:  Container(
        child:  new Icon(
            Icons.add_circle, color: Colors.blue
        ),
      ),
      onTap:  ()  {
        print("Tappy tap male!");
      }
  );
  final _femalbuttoncontainer = new InkWell(
      child:  Container(
          child:  new Icon(
              Icons.add_circle, color: Colors.red
          ),
      ),
      onTap:  ()  {
        print("Tappy tap female!");
      }
  );
  final _textinputcontainer = new Container();


  @override
  Widget build(BuildContext context)  {
    return new Scaffold(
      /* appBar: new AppBar(
        title: Text('SR'),
        centerTitle: true,
      ), */
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _malebuttoncontainer,
                new Container(
                  child: new Flexible(
                    child: _txtaddPlayers()
                  )
                ),
                _femalbuttoncontainer,
              ]
            )
          ]
        )
    );
  }

  Widget _txtaddPlayers() {
    return new TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Please enter a name',
      ),
      textAlign: TextAlign.center,
      autocorrect: false,
      style: _normalFont,
      onChanged: (text) {
      },
      onSubmitted: (text) {
        print("Text is: $text");
        _playerlist.add(text);
        print(_playerlist);
      },
    );
  }

  void _donothing()  {

  }

}