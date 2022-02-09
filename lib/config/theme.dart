import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      primaryColor: Color(0xFFFAD7FFB),
      primaryColorDark: Color(0xFFF694F95),
      primaryColorLight: Color(0xFFFD1B7FE),
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Color(0xFFFF9FAFE),
      textTheme: TextTheme(
        headline1: TextStyle(
            color: Color(0xFF000000),
            fontWeight: FontWeight.bold,
            fontSize: 32),
        headline2: TextStyle(
            color: Color(0xFF2E0025),
            fontWeight: FontWeight.bold,
            fontSize: 24),
        headline3: TextStyle(
            color: Color(0xFF2E0025),
            fontWeight: FontWeight.bold,
            fontSize: 18),
        headline4: TextStyle(
            color: Color(0xFF2E0025),
            fontWeight: FontWeight.bold,
            fontSize: 16),
        headline5: TextStyle(
            color: Color(0xFF2E0025),
            fontWeight: FontWeight.bold,
            fontSize: 14),
        headline6: TextStyle(
            color: Color(0xFF2E0025),
            fontWeight: FontWeight.normal,
            fontSize: 14),
        bodyText1: TextStyle(
            color: Color(0xFF2E0025),
            fontWeight: FontWeight.normal,
            fontSize: 12),
        bodyText2: TextStyle(
            color: Color(0xFF2E0025),
            fontWeight: FontWeight.normal,
            fontSize: 10),
      ));
}
