import 'package:flutter/material.dart';

class SupportBotColors {
  SupportBotColors._();

  static const MaterialColor bluePrimary = MaterialColor(
    _primaryColor,
    <int, Color>{
      100: Color(0xFFE9ECF4),
      200: Color(0xFFD4DAEA),
      300: Color(0xFF93A3CB),
      400: Color(0xFF496DAF),
      500: Color(0xFF1B489B),
    },
  );

  static const int _primaryColor = 0xFF19469d;

  static const MaterialColor blueSecondary = MaterialColor(
    _secondaryColor,
    <int, Color>{
      100: Color(0xFFE7E7E9),
      200: Color(0xFFCECFD3),
      300: Color(0xFF858791),
      400: Color(0xFF3D3F50),
      500: Color(0xFF0C0F24),
      600: Colors.black12
    },
  );

  static const int _secondaryColor = 0xFF0C0F24;

  static const MaterialColor black = MaterialColor(
    _blackColor,
    <int, Color>{},
  );

  static const int _blackColor = 0xFF000000;

  static const MaterialColor white = MaterialColor(
    _whiteColor,
    <int, Color>{},
  );

  static const int _whiteColor = 0xFFFFFFFF;

  static const MaterialColor disablePrimary = MaterialColor(
    _disableColor,
    <int, Color>{
      // 50: Color(0xFFF2F3F4),
      100: Color(0xFFE2E3E4),
      200: Color(0xFFD5D6D7),
      300: Color(0xFFC2C3C4),
      400: Color(0xFFA2A3A4),
      500: Color(_disableColor),
      600: Color(0xFF6E6F70),
      700: Color(0xFF58595B),
      800: Color(0xFF464748),
      900: Color(0xFF363738),
    },
  );

  static const int _disableColor = 0xFF58595B;

  static const MaterialColor gray = MaterialColor(
    _grayPrimaryColor,
    <int, Color>{
      0: Color(_grayPrimaryColor),
      100: Color(0xFFfafafa),
      200: Color(0xFFf2f2f2),
      300: Color(0xFFe6e6e6),
      400: Color(0xFFdadada),
      500: Color(0xFFcccccc),
      600: Color(0xFF999999),
      700: Color(0xFF808080),
      800: Color(0xFF4d4d4d),
      900: Color(0xFF303030),
      1000: Color(0xFF202020),
    },
  );

  static const int _grayPrimaryColor = 0xFFe6e6e6;

  static const MaterialColor sky = MaterialColor(
    _skyPrimaryColor,
    <int, Color>{
      0: Color(_skyPrimaryColor),
      100: Color(0xFFf2f8fd),
      200: Color(0xFFd9eafa),
      300: Color(0xFFc0ddf6),
      400: Color(0xFF8dc1ef),
      500: Color(0xFF54a2e7),
      600: Color(0xFF1a83df),
      700: Color(0xFF0166c0),
      800: Color(0xFF014c8e),
      900: Color(0xFF00325d),
      1000: Color(0xFF00172c),
    },
  );

  static const int _skyPrimaryColor = 0xFF0175DB;

  static const MaterialColor blueShades = MaterialColor(
    _disableColor,
    <int, Color>{
      100: Color.fromARGB(255, 153, 172, 187),
      200:  const Color.fromARGB(255, 28, 88, 136),
      300: Color.fromARGB(255, 17, 58, 98),
    },
  );
}

class ExpV3Color extends ColorSwatch<int> {
  const ExpV3Color(super.primary, super.swatch);
  Color get shade1 => this[1]!;
  Color get shade2 => this[2]!;
  Color get shade3 => this[3]!;
  Color get shade4 => this[4]!;
  Color get shade5 => this[5]!;
  Color get shade6 => this[6]!;
  Color get shade7 => this[7]!;
  Color get shade8 => this[8]!;
  Color get shade9 => this[9]!;
  Color get shade10 => this[10]!;
}
