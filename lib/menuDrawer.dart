import 'package:flutter/material.dart';
import 'overView.dart';
import 'player.dart';
import 'category.dart';
import 'extras.dart';
import 'order.dart';

Widget menuDrawer(BuildContext context){
  return FractionallySizedBox(
    widthFactor: 0.35,
    child: Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: Container(
                  child: Text('',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
              //color: Colors.black,
                  ),
                ),
            ),
         ListTile(
           title: Text('Übersicht',
               style: TextStyle(
                   color: Colors.white,
                 //backgroundColor: Colors.black
               ),
               textAlign: TextAlign.center
           ),
           onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => viewOverview()));
           },
         ),
          ListTile(
              title: Text('Spieler',
                  style: TextStyle(
                      color: Colors.white,
                      //backgroundColor: Colors.black
                  ),
                  textAlign: TextAlign.center
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => editPlayers()));
              },
          ),
          ListTile(
            title: Text('Kategorien',
                style: TextStyle(
                    color: Colors.white,
                    //backgroundColor: Colors.black
                ),
                textAlign: TextAlign.center
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => editCategories()));
            },
          ),
            ListTile(
              title: Text('Extras',
                  style: TextStyle(
                    color: Colors.white,
                    //backgroundColor: Colors.black
                  ),
                  textAlign: TextAlign.center
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => editExtras()));
              },
            ),
         ListTile(
           title: Text('Feuer!',
            style: TextStyle(
                color: Colors.red,
                //backgroundColor: Colors.black
            ),
           textAlign: TextAlign.center
           ),
           onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => viewOrder()));
           },
         )
        ],
      ),
    )
  )
  );
}