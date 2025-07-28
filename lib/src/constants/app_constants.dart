import 'package:flutter/material.dart';

const Duration kDuration = Duration(milliseconds: 500);
const Duration kInstantDuration = Duration(microseconds: 1);
const Duration kLongDuration = Duration(seconds: 2);

const Curve kCurve = Curves.easeIn;
const Size kMagnifierSize = Size(77.37, 37.9);
const MagnifierDecoration kMagnifierDecoration = MagnifierDecoration(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(40)),
  ),
  shadows: <BoxShadow>[
    BoxShadow(
      blurRadius: 1.5,
      offset: Offset(0, 2),
      spreadRadius: 0.75,
      color: Color.fromARGB(25, 0, 0, 0),
    ),
  ],
);

const kDebounceDuration = Duration(milliseconds: 500);

class Delays {
  static const int bleScanLengthMs = 1100;
  static const int bleScanIntervalMs = 1000;
}
