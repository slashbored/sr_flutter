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

  @override
  Widget build(BuildContext context)  {
    return new Scaffold(
      /* appBar: new AppBar(
        title: Text('SR'),
        centerTitle: true,
      ), */
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
          _txtaddPlayers()
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