import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splashScreen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counterBloc.dart';




void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

/*void main() {
    runApp(MyApp());
}*/

class MyApp extends StatefulWidget  {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shitroulette',
      theme: new ThemeData(
        primaryColor: Colors.black,
      ),
      home: viewSplashScreen()
    );
  }

  @override
  void dispose()  {
    super.dispose();
  }
}



