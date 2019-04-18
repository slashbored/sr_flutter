import 'package:flutter/material.dart';

Widget menuDrawer(){
  return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
         DrawerHeader(
            child: Text('Drawer Header',
              style: TextStyle(
                color: Colors.white,
              ),
            textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
         ListTile(
           title: Text('Übersicht'),
           onTap: () {
           },
         ),
          ListTile(
            title: Text('Spieler'),
            onTap: () {
            },
          ),
          ListTile(
            title: Text('Kategorien'),
            onTap: () {
            },
          ),
          ListTile(
            title: Text('Extras'),
            onTap: () {
            },
          ),
        ],
      ),
    );
}