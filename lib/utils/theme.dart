﻿import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData basicTheme() => ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.white, //текст в outined bontton
      onPrimary: Colors.red,
      secondary: Colors.red,
      onSecondary: Colors.red,
      error: Colors.red,
      onError: Colors.red,
      background: Colors.red,
      onBackground: Colors.red,
      surface: Colors.transparent, // + шапка скафолда
      onSurface: Color(0xFFA7E98F), //Текст шапки
    ),

    //brightness: Brightness.light, //не работает при перешлючении на DARK

    bottomAppBarColor: Colors.red,
    cardColor: Color(0xFF1A021A),
    primaryColor: Colors.white, //Цвет контуров
    backgroundColor: Colors.red, //
    scaffoldBackgroundColor: Color(0xFF1A021A),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.red),
      bodyText2: TextStyle(color: Colors.white), //просто текст
      headline1: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      headline3: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Fraunces'),
      headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
      headline6: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'Fraunces'),
    ));

var iconColor = Color(0xFFA7E98F);
var primaryGreen = Color(0xFFA7E98F);
var secondaryWhite = Colors.white;

var cardGrey = Color(0x200F21);
var mainScreenIconsSize = 40.0;

var rulesTextStyle = TextStyle(
    fontFamily: "Roboto",
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: secondaryWhite);

var rulesOutlinedButtonStyle = OutlinedButton.styleFrom(
  backgroundColor: Colors.transparent,
  primary: Colors.white,
  textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15))),
  side: BorderSide(color: Color(0xFFA7E98F), width: 1.0),
  padding: const EdgeInsets.all(10), //по
);

var activeStartButtonStyle = OutlinedButton.styleFrom(
    backgroundColor: Color(0xFFFF8D5B),
    primary: Colors.black,
    textStyle:
        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold), //по умолчанию
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    //side: BorderSide(color: Colors.white, width: 1.0),
    side: BorderSide.none,
    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0));

var inactiveStartButtonStyle = OutlinedButton.styleFrom(
    backgroundColor: Colors.transparent,
    primary: Colors.white,
    textStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 253, 115, 73)), //по умолчанию
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    side: BorderSide(color: Color(0xFFFF8D5B), width: 1.0),
    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0));

var activeLocationButtonStyle = OutlinedButton.styleFrom(
  backgroundColor: Color(0xFFA7E98F),
  side: BorderSide.none,
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15))),
  primary: Colors.black,
);

var inactiveLocationButtonStyle = OutlinedButton.styleFrom(
    backgroundColor: Colors.transparent,
    primary: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    side: BorderSide(color: Colors.white, width: 1.0));

var emojiStyle = GoogleFonts.notoEmoji(textStyle: TextStyle(fontSize: 20));

Decoration cardDecoration(context) {
  return BoxDecoration(
    //border: Border.all(color: Color(0xE8E8E8)),
    border: Border.all(
        color: Theme.of(context).primaryColor,
        width: 1), // Wi // Will work, width: 1),
    borderRadius: BorderRadius.circular(15),
    color: Color(0xFF200F21),
    //color: Theme.of(context).scaffoldBackgroundColor,
  );
}

EdgeInsetsGeometry cardPaddding() => EdgeInsets.all(20);
EdgeInsetsGeometry cardMargin() =>
    EdgeInsets.symmetric(vertical: 10, horizontal: 20);
