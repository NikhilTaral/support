import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

SnackBar CustomSnackbar({
  required String message,
  required BuildContext context,
  bool isSuccess = true,
  double? width,
  Duration? duration,
}) {
  final color =
      isSuccess ? SupportBotColors.successPrimary : SupportBotColors.danger;
  final backgroundColor = isSuccess
      ? SupportBotColors.successPrimary.shade100
      : SupportBotColors.danger.shade100;
  final icon = isSuccess
      ? const Icon(Icons.check_circle, color: SupportBotColors.successPrimary)
      : Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: const Icon(Icons.close_rounded, color: SupportBotColors.white),
        );

  return SnackBar(
    width: width ?? UIHelpers.screenWidth(context) * 0.6,
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: color),
      borderRadius: BorderRadius.circular(5.0),
    ),
    content: Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Text(
          message,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    duration: duration ?? const Duration(seconds: 2),
    action: SnackBarAction(
      label: "X",
      textColor: color,
      onPressed: () {},
    ),
  );
}
