import 'package:flutter/material.dart';
import 'menuDrawer.dart';
import 'overView.dart';
import 'player.dart';
import 'category.dart';
import 'extras.dart';
import 'order.dart';

class testPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return testPageState();
  }
}

class testPageState extends State<testPage> {

  int bottomSelectedIndex = 0;

  TextStyle _normalStyleInverted = TextStyle(
    color: Colors.white,
    fontSize: 10
  );

  void pageChanged(int index)  {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged (index);
      },
      children: <Widget>[
        viewOverview(),
        editPlayers(),
        editCategories(),
        editExtras(),
        viewOverview()
      ],
    );
  }


  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Testpage"
        )
      ),
      drawer: menuDrawer(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        onTap: (index)  {
          bottomTapped(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
            ),
            activeIcon: new Icon(
              Icons.home,
              color: Colors.deepOrangeAccent,
            ),
            title: new Text(
              "Übersicht",
              style: _normalStyleInverted,
            ),
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.person,
            ),
            activeIcon: new Icon(
              Icons.person,
              color: Colors.green,
            ),
            title: new Text(
              "Spieler",
              style: _normalStyleInverted,
            ),
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.clear_all),
            activeIcon: new Icon(
              Icons.clear_all,
              color: Colors.blue,
            ),
            title: new Text(
              "Kategorien",
              style: _normalStyleInverted,
            ),
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.star,
            ),
            activeIcon: new Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            title: new Text(
              "Extras",
              style: _normalStyleInverted,
            ),
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.arrow_forward_ios,
            ),
            activeIcon: new Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
            ),
            title: new Text(
              "Feuer!",
              style: _normalStyleInverted,
            ),
            backgroundColor: Colors.black
          )
        ],
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: buildPageView(),
    );
  }
}