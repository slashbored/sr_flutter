import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      if(question.questionbase[0]==null){
        buildDatabase();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _disclaimerread();
  }

  _disclaimerread() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int dcr = (prefs.getInt('dcr'));
    if (dcr==null||dcr==0){
      await prefs.setInt('dcr', 1);
      Navigator.push(context, MaterialPageRoute(builder: (context) => viewDisclaimer()));
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => viewOverview()));
    }
  }

}