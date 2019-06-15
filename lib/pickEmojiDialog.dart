import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'player.dart';

Widget pickEmojiDialog(BuildContext context)  {

  return SimpleDialog(
    children: <Widget>[
      Wrap(
        alignment: WrapAlignment.center,
        children:
          List.generate(player.iconDB.length, (index) {
            String emojiplaceholder = player.iconDB.elementAt(index);
            return IconButton(
             icon: Text(
                 player.iconDB.elementAt(index)),
              onPressed: () {
               player.selectedIcon = player.iconDB.elementAt(index);
               Navigator.of(context).pop();
              },
            );
          })
      )
    ],
  );
}