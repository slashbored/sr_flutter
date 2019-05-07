import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'player.dart';

Widget orderDrawer  (BuildContext context)  {
  return FractionallySizedBox(
    widthFactor:  0.35,
    child:  Drawer(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ExpansionTile(
            title:  new Text(
              'Spieler:',
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              ListView.builder(
                itemCount: player.playerDatabase.length,
                itemBuilder: (BuildContext context, int index)  {
                  return new ListTile(
                    title:  new Text(
                      player.getPlayerName(player.playerIds[index]),
                      textAlign: TextAlign.center,),
                    trailing: new Row(
                      children: <Widget>[
                      new Text(
                        player.getPlayerPoints(player.playerIds[index]).toString()
                      ),
                      new IconButton(
                        icon: Icon(Icons.remove_circle,),
                        color: Colors.red,
                        onPressed: null,)
                      ],
                      mainAxisSize: MainAxisSize.min,
                    ),
                  );
                },
                shrinkWrap: true,
              )
            ],
          )
        ],
      )
    )
  );
}