import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';

class SupportBotTextstyle {
  static const String _fontFamily = 'Roboto';

  //column heading
  static final TextStyle columnHeading = TextStyle(
    fontFamily: _fontFamily,
    color: SupportBotColors.blueSecondary.shade500,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  //row heading
  static const TextStyle cellHeading = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  //Piechart label 
  static const TextStyle pierchartLabel = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: SupportBotColors.black
  );

   //Piechart heading 
  static const TextStyle pierchartHeading = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: SupportBotColors.black
  );

  static const TextStyle pierchartNormal = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: SupportBotColors.white
  );
}
