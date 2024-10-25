import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';

class SupportBotTextstyle {
  static const String _fontFamily = 'Roboto';
  static final Color _fontColor = SupportBotColors.blueSecondary.shade400;
  static final Color _fontHintColor = SupportBotColors.blueSecondary.shade300;
  static const FontWeight _fontWeight = FontWeight.normal;

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
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: SupportBotColors.black);

  //Piechart heading
  static const TextStyle pierchartHeading = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: SupportBotColors.black);

  static const TextStyle pierchartNormal = TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: SupportBotColors.white);

  //Dropdown label
  static const TextStyle dropdownLabel = TextStyle(
      color: SupportBotColors.gray, 
      fontSize: 12, 
  );

    // Count container label
  static const TextStyle countLabel = TextStyle(
    fontSize: 14,
    fontFamily: _fontFamily,
    color: SupportBotColors.white
  );

  //date text
  static const TextStyle dateText = TextStyle(
    fontSize: 16,
    fontFamily: _fontFamily,
    color: SupportBotColors.black
  );

  //date label
  static const TextStyle dateLabel = TextStyle(
    fontSize: 12,
    fontFamily: _fontFamily,
    color: SupportBotColors.gray
  );

  //sidebar title
   static const TextStyle sidebarTitle = TextStyle(
    fontSize: 20,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold
  );

  //sidebar subtitle
   static const TextStyle sidebarSubtitle = TextStyle(
    fontSize: 16,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700
  );

  //sidebar label
   static const TextStyle siebarLabel = TextStyle(
    fontSize: 16,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400
  );

// Font size 48
  static final TextStyle headingH1 = TextStyle(
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 48.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.42,
    height: 32.0 / 28.0,
  );

  // Font size 40
  static final TextStyle headingH2 = TextStyle(
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 40.0,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.36,
    height: 32.0 / 24.0,
  );

      // Font size 35
  static const TextStyle headingH3 = TextStyle(
    color: SupportBotColors.white,
    fontSize: 35,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamily
  );

  // Font size 32
  static final TextStyle subheadingH3 = TextStyle(
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 32.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.3,
    height: 26.0 / 20.0,
  );

  // Font size 28
  static final TextStyle subheadingH4 = TextStyle(
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 28.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.27,
    height: 24.0 / 18.0,
  );

  // Font size 24
  static final TextStyle subheadingH5 = TextStyle(
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 24.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.24,
    height: 21.0 / 16.0,
  );

  // Font size 20
  static final TextStyle subheadingH6 = TextStyle(
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 20.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.21,
    height: 20.0 / 16.0,
  );

  // Font size 18
  static final TextStyle normal = TextStyle(
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 18.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.24,
    height: 24.0 / 16.0,
  );

  // Font size 16
  static final TextStyle small = TextStyle(
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 16.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.21,
    height: 21.0 / 14.0,
  );

  // Font size 14
  static final TextStyle hint = TextStyle(
    color: _fontHintColor,
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.21,
    height: 21.0 / 14.0,
  );

  // Font size 12
  static final TextStyle mediumHint = TextStyle(
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.27,
    height: 24.0 / 18.0,
  );

  // Font size 10
  static final TextStyle smallHint = TextStyle(
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 10.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.21,
    height: 21.0 / 14.0,
  );

  static final TextStyle extraLargeUnderline = TextStyle(
    decoration: TextDecoration.underline,
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 20.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.21,
    height: 21.0 / 14.0,
  );
  static final TextStyle largeUnderline = TextStyle(
    decoration: TextDecoration.underline,
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 18.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.21,
    height: 21.0 / 14.0,
  );
  static final TextStyle mediumUnderline = TextStyle(
    decoration: TextDecoration.underline,
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 16.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.21,
    height: 21.0 / 14.0,
  );

  static final TextStyle smallUnderline = TextStyle(
    decoration: TextDecoration.underline,
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.21,
    height: 21.0 / 14.0,
  );

  static final TextStyle extrasmallUnderline = TextStyle(
    decoration: TextDecoration.underline,
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.21,
    height: 21.0 / 14.0,
  );

  // Font size 12
  static final TextStyle caption = TextStyle(
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.18,
    height: 16.0 / 12.0,
  );

  // Font size 12
  static final TextStyle description = TextStyle(
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: _fontWeight,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.18,
    height: 16.0 / 12.0,
  );

  static final TextStyle regularTextStyle = TextStyle(
    color: _fontColor,
    fontFamily: _fontFamily,
    fontSize: 16.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.4,
    height: 34.0 / 16.0,
  );

  static const TextStyle medium = TextStyle(
    color: SupportBotColors.black,
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: _fontWeight,
    letterSpacing: 0.21,
    height: 21.0 / 14.0,
  );
}

extension ExpV3TextStyleExtension on TextStyle {
  TextStyle light300() {
    return copyWith(fontWeight: FontWeight.w300);
  }

  TextStyle v3RegularItalic() {
    return copyWith(
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle v3Bold600() {
    return copyWith(fontWeight: FontWeight.w600);
  }

  TextStyle v3Bold400() {
    return copyWith(fontWeight: FontWeight.w400);
  }

  TextStyle v3WithColor(Color color) {
    return copyWith(color: color, fontWeight: fontWeight);
  }
}
