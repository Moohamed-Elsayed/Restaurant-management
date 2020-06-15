import 'package:flutter/material.dart';
import 'package:food/style/theme.dart' as Theme;

const kBoxButton = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
  boxShadow: <BoxShadow>[
    BoxShadow(
      color: Theme.Colors.loginGradientStart,
      offset: Offset(1.0, 6.0),
      blurRadius: 20.0,
    ),
    BoxShadow(
      color: Theme.Colors.loginGradientEnd,
      offset: Offset(1.0, 6.0),
      blurRadius: 20.0,
    ),
  ],
  gradient: LinearGradient(
      colors: [Theme.Colors.loginGradientEnd, Theme.Colors.loginGradientStart],
      begin: const FractionalOffset(0.2, 0.2),
      end: const FractionalOffset(1.0, 1.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp),
);

const kNameShared = 'Access';

//  background
const kBackground = BoxDecoration(
  gradient: LinearGradient(
      colors: [Theme.Colors.loginGradientStart, Theme.Colors.loginGradientEnd],
      begin: FractionalOffset(0.0, 0.0),
      end: FractionalOffset(1.0, 1.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp),
);

// InputDecoration
const kInputTextField = InputDecoration(
  filled: true,
  hintStyle: TextStyle(color: Colors.black54),
  fillColor: Colors.white,
  errorStyle: TextStyle(color: Colors.white),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kBackgroundAdminLight, width: 2.0),
  ),
);

// color
const kBackgroundAdmin = Color(0xff392850);
const kBackgroundAdminLight = Color(0xff453658);
const kBackgroundAdminMoreLight = Color(0xff746883);
const Color kYellow = Color.fromRGBO(255, 187, 70, 1);
const Color kBlue = Color.fromRGBO(76, 139, 245, 1);
const Color kGrey = Color.fromRGBO(207, 207, 207, 1);
