import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'player.dart';
import 'question.dart';
import 'category.dart';
import 'orderFirstRow.dart';
import 'orderSecondRow.dart';
import 'orderDrawer.dart';

FloatingActionButton timerbtn;
Timer foregroundTimer;
var timerbtnchild;
int secondsLeft;
int secondsLeftHalted;
bool running;
bool halted;
Timer backgroundTimer;
var orderStack = {};