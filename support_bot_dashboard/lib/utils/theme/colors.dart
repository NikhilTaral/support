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
      600: Colors.black12,
        700: Color(0xFF153A83),
    },
  );

  static const int _secondaryColor = 0xFF0C0F24;

  static const MaterialColor warningPrimary = MaterialColor(
    _warningPrimaryColor,
    <int, Color>{
      100: Color(0xFFFFE1A4),
      200: Color(0xff87817E),
      300: Color(0xFF895D0B),
      400: Color(0xFF721c24),
      500: Color(0xFFd6721b),
    },
  );

  static const int _warningPrimaryColor = 0xFF895D0B;

  static const MaterialColor successPrimary = MaterialColor(
    _successPrimaryColor,
    <int, Color>{
      100: Color(0xFFCCF2DB),
      200: Color(0xFF91C681),
      300: Color(0xFF1E774A),
      400: Color(0xFF0a454e),
    },
  );

  static const int _successPrimaryColor = 0xFF1E774A;

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

  static const MaterialColor danger = MaterialColor(
    _dangerPrimaryColor,
    <int, Color>{
      0: Color(_dangerPrimaryColor),
      100: Color(0xFFfef7f8),
      200: Color(0xFFf7d3d6),
      300: Color(0xFFf1aeb5),
      400: Color(0xFFeb8a93),
      500: Color(0xFFe46572),
      600: Color(0xFFde4150),
      700: Color(0xFFc22f3d),
      800: Color(0xFF9a2530),
      900: Color(0xFF721c24),
      1000: Color(0xFF4b1217),
    },
  );

  static const int _dangerPrimaryColor = 0xFFdc3545;

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
