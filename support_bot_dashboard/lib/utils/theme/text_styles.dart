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
}
