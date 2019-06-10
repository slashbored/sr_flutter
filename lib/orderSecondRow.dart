import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'player.dart';
import 'question.dart';
import 'category.dart';
import 'order.dart';

final TextStyle orderstyle = const TextStyle(
    fontSize: 24,
    color: Colors.black
);

final TextStyle maleorderstyle = const TextStyle(
    fontSize: 24,
    color: Colors.blue
);

final TextStyle femaleorderstyle = const TextStyle(
    fontSize: 24,
    color: Colors.red
);

Widget buildSecondRow(firstPlayer, player secondPlayer, String orderString) {
  List<String> _splitstring;
  int sipsp1;
  int sipsp2;
  if (secondPlayer == null) {
    if (orderString.contains("\$pointholderone")) {
      sipsp1 = firstPlayer.points +2;
      orderString = orderString.replaceAll(new RegExp(r"\$pointholderone"), sipsp1.toString());
      /*if (sipsp1==1&&finalOrderString.contains("Schlücke")) {
          finalOrderString = finalOrderString.replaceAll(new RegExp(r"Schlücke"), "Schluck");
        }*/
    }
    return new RichText(
      text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: orderString,
              style: orderstyle,
            )
          ]
      ),
      textAlign: TextAlign.center,
    );
  }
  else {
    if (orderString.contains("\$pointholderone")) {
      sipsp1 = firstPlayer.points +2;
      sipsp2 = secondPlayer.points +2;
      orderString = orderString.replaceAll(new RegExp(r"\$pointholderone"), sipsp1.toString());
      orderString = orderString.replaceAll(new RegExp(r"\$pointholdertwo"), sipsp2.toString());
      /*if (sipsp2==1&&finalOrderString.contains("Schlücke")) {
          finalOrderString = finalOrderString.replaceAll(new RegExp(r"Schlücke"), "Schluck");
        }*/
    }
    _splitstring = orderString.split("\$placeholder");
    _splitstring[1].replaceAll("\$placeholder", "");
    _splitstring[2].replaceAll("\$placeholder", "");
    return new RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: firstPlayer.name.toString(),
              style: firstPlayer.sex=='m'?maleorderstyle:femaleorderstyle
          ),
          TextSpan(
              text: _splitstring[0],
              style: orderstyle
          ),
          TextSpan(
              text: secondPlayer.name.toString(),
              style: secondPlayer.sex=='m'?maleorderstyle:femaleorderstyle
          ),
          TextSpan(
              text: _splitstring[1],
              style: orderstyle
          ),
          TextSpan(
              text: secondPlayer.name.toString(),
              style: secondPlayer.sex=='m'?maleorderstyle:femaleorderstyle
          ),
          TextSpan(
              text: _splitstring[2],
              style: orderstyle
          )
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}