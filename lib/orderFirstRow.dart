import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'player.dart';
import 'question.dart';
import 'category.dart';
import 'order.dart';


final TextStyle _maletitlestyle = const TextStyle(
    fontSize: 36,
    color: Colors.blue
);

final TextStyle _femaletitlestyle = const TextStyle(
    fontSize: 36,
    color: Colors.red
);

Widget buildfirstRow(BuildContext context, firstPlayer, player secondPlayer, question finalQuestion) {
  if (finalQuestion.type_id==4) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
            child: RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: firstPlayer.name,
                          style: firstPlayer.sex== 'm'
                              ? _maletitlestyle
                              : _femaletitlestyle
                      ),
                      TextSpan(
                          text: " " + firstPlayer.icon,
                          style: TextStyle(
                              fontSize: 36
                          )
                      ),
                      TextSpan(
                          text: ' fängt an:',
                          style: TextStyle(
                              fontSize: 36,
                              color: Colors.green
                          )
                      )
                    ]
                )
            )
        )
      ],
    );
  }
  if (finalQuestion.type_id==5) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
            child: RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Allesamt:',
                          style: TextStyle(
                              fontSize: 36,
                              color: Colors.green
                          )
                      )
                    ]
                )
            )
        )
      ],
    );
  }
  if (finalQuestion.type_id==6) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Center(
            child: new Container(
              child: new RichText(
                text: new TextSpan(
                    children: <TextSpan>[
                      new TextSpan(
                        text: 'Abstimmen, Verlierer trinken:',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.green,
                        ),
                      ),
                    ]
                ),
                textAlign: TextAlign.center,
              ),
              width: MediaQuery.of(context).size.width*0.75,
            )
        )
      ],
    );
  }
  else {
    if (secondPlayer == null) {
      return new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Expanded(
              child: new RichText(
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: firstPlayer.name,
                        style: firstPlayer.sex == 'm'
                            ? _maletitlestyle
                            : _femaletitlestyle,
                      ),
                      TextSpan(
                          text: " " + firstPlayer.icon,
                          style: TextStyle(
                              fontSize: 36
                          )
                      ),
                    ]
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ]
      );
    }
    else {
      return new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Expanded(
                child: new RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: firstPlayer.name,
                            style: firstPlayer.sex == 'm'
                                ? _maletitlestyle
                                : _femaletitlestyle
                        ),
                        TextSpan(
                            text: " " + firstPlayer.icon,
                            style: TextStyle(
                                fontSize: 36
                            )
                        ),
                        TextSpan(
                            text: '\n&\n',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.black
                            )
                        ),
                        TextSpan(
                            text: secondPlayer.name,
                            style: secondPlayer.sex == 'm'
                                ? _maletitlestyle
                                : _femaletitlestyle
                        ),
                        TextSpan(
                            text: " " + secondPlayer.icon,
                            style: TextStyle(
                                fontSize: 36
                            )
                        ),
                      ]
                  ),
                  textAlign: TextAlign.center,
                ),
                flex: 1
            ),
          ]
      );
    }
  }
}