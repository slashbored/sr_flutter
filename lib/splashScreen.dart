import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'disclaimer.dart';
import 'overView.dart';
import 'question.dart';
import 'dataBase.dart';

class viewSplashScreen extends StatefulWidget{
  @override
  viewSplashScreenState createState() => new viewSplashScreenState();
}

class viewSplashScreenState extends State<viewSplashScreen>{

  @override
  void initState()  {
    super.initState();
    setState(() {
      if(question.questionDatabase[0]==null){
        buildDatabase();
      }
      _disclaimerread();
    });
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return new Scaffold(
        /*appBar: new AppBar(
          title: Text('Extras'),
          centerTitle: true,
        ),*/
        body: Center(
          child: new Text('💩',
              style: TextStyle(
                fontSize: 54
              ),
              textAlign: TextAlign.center,
          )
        )
    );
  }

  _disclaimerread() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2  ), (){});
    int dcr = (prefs.getInt('dcr'));
    if (dcr==null||dcr==0){
      await prefs.setInt('dcr', 1);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => viewDisclaimer()));
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => viewOverview()));
    }
  }

}