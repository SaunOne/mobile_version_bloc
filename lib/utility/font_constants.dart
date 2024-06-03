import 'package:flutter/material.dart';

class FontConstants {
  static const String fontFamily = 'poppins';

  static TextStyle heading1({Color color = Colors.black}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle heading2({Color color = Colors.black}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle bodyText1({Color color = Colors.black}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

}
