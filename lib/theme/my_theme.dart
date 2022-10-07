import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/colors.dart';

class AppTheme {
  static final myTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevation: 0,
      color: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: AllTexts.fontBolt,
        fontSize: 40,
        color: Colors.black,
      ),
    ),
    textTheme: const TextTheme(

      // normal text
      bodyText1: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontFamily: AllTexts.fontRegular,
      ),

      // bolt normal text
      bodyText2: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontFamily: AllTexts.fontBolt,
      ),

      // Title
      headline1: TextStyle(
        fontSize: 45,
        color: Colors.black,
        fontFamily: AllTexts.fontBolt,
      ),

      // error text
      headline2: TextStyle(
        fontSize: 15,
        color: AllColors.errorColor,
        fontFamily: AllTexts.fontBolt,
      ),

      // bolt button text
      headline3: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontFamily: AllTexts.fontBolt,
      ),

      // normal button text
      headline4: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontFamily: AllTexts.fontRegular,
      ),

      // primary color text
      headline5: TextStyle(
        fontSize: 18,
        color: AllColors.primaryColor,
        fontFamily: AllTexts.fontBolt,
      ),
      subtitle1: TextStyle(
        fontSize: 28,
        color: Colors.black,
        fontFamily: AllTexts.fontRegular,
      ),
      subtitle2: TextStyle(
        fontSize: 10,
        color: Colors.black,
        fontFamily: AllTexts.fontRegular,
        fontWeight: FontWeight.w100,
      ),
    ),
  );
}
