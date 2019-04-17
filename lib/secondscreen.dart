import 'package:flutter/material.dart';

Widget theDrawer(){
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
            title: Text('Players'),
            onTap: () {
            },
          ),
          ListTile(
            title: Text('Categories'),
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