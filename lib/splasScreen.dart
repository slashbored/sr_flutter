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
      _disclaimerread();
    });
  }

  @override
  Widget build(BuildContext context) {
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
    await Future.delayed(const Duration(seconds: 5), (){});
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