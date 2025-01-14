import 'dart:ui';

import 'package:support_bot_dashboard/utils/theme/colors.dart';

class ApplicationsPlutoHelperMethods {
  static Color getTextColorFromStatus({String? status, int? percent}) {
    if (percent != null) {
      if (percent >= 90) {
        return const Color(0xFF11972C);
      } else if (percent <= 90 && percent >= 50) {
        return const Color(0xFF857302);
      } else if (percent > 0) {
        return const Color(0xFFFD0101);
      } else {
        return SupportBotColors.gray.shade800;
      }
    }

    if (status != null) {
      switch (status.toLowerCase()) {
        case "updated":
          return const Color(0xFF11972C);
        case "not updated":
          return const Color(0xFFFD0101);

        default:
          return SupportBotColors.gray.shade800;
      }
    }
    return SupportBotColors.gray.shade800;
  }

  static Color getContainerColorFromStatus({String? status, int? percent}) {
    if (percent != null) {
      if (percent >= 90) {
        return const Color(0xFFC9FFD1);
      } else if (percent <= 90 && percent >= 50) {
        return const Color(0xFFFFFAC9);
      } else if (percent > 0) {
        return const Color(0xFFFFC9C9);
      } else {
        return SupportBotColors.gray.shade400;
      }
    }
    if (status != null) {
      switch (status.toLowerCase()) {
        case "updated":
          return const Color(0xFFC9FFD1);

        case "not updated":
          return const Color(0xFFFFC9C9);

        default:
          return SupportBotColors.gray.shade400;
      }
    }
    return SupportBotColors.gray.shade400;
  }
}
