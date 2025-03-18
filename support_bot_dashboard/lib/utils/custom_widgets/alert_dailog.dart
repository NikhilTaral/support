import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

enum ExpAlertStyle {
  success,
  info,
  warning,
  danger,
}

extension ExpAlertStyleColorExtension on ExpAlertStyle {
  Color textColor() {
    switch (this) {
      case ExpAlertStyle.success:
        return const Color(0xFF186429);
      case ExpAlertStyle.info:
        return const Color(0xFF0E616E);
      case ExpAlertStyle.warning:
        return const Color(0xFF997404);
      case ExpAlertStyle.danger:
        return const Color(0xFF842029);
    }
  }

  Color backgroundColor() {
    switch (this) {
      case ExpAlertStyle.success:
        return const Color(0xFFD4EDDA);
      case ExpAlertStyle.info:
        return const Color(0xFFD1ECF1);
      case ExpAlertStyle.warning:
        return const Color(0xFFFFF3CD);
      case ExpAlertStyle.danger:
        return const Color(0xFFF8D7DA);
    }
  }

  Color iconColor() {
    switch (this) {
      case ExpAlertStyle.success:
        return const Color(0xFF186429);
      case ExpAlertStyle.info:
        return const Color(0xFF0E616E);
      case ExpAlertStyle.warning:
        return const Color(0xFF997404);
      case ExpAlertStyle.danger:
        return const Color(0xFF842029);
    }
  }

  IconData iconData() {
    switch (this) {
      case ExpAlertStyle.success:
        return SupportBotIcons.verify;
      case ExpAlertStyle.info:
        return SupportBotIcons.infoCircle;
      case ExpAlertStyle.warning:
        return SupportBotIcons.danger;
      case ExpAlertStyle.danger:
        return SupportBotIcons.danger;
    }
  }
}

class ExpAlert extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Icon icon;
  final BorderRadius borderRadius;
  final Color titleColor;
  final Color messageColor;
  final double iconSpacing;
  final EdgeInsets iconPadding;
  final EdgeInsets textPadding;
  final double maxWidth;
  final TextStyle titleTextStyle;
  final TextStyle messageTextStyle;

  ExpAlert(
      {Key? key,
      required this.title,
      required this.message,
      required this.onTap,
      this.padding = const EdgeInsets.all(15.0),
      required this.backgroundColor,
      required this.icon,
      this.borderRadius = const BorderRadius.all(Radius.circular(6.0)),
      Color? titleColor,
      Color? messageColor,
      this.iconSpacing = 9.0,
      this.iconPadding = const EdgeInsets.only(top: 4.0),
      this.textPadding = const EdgeInsets.all(0.0),
      this.maxWidth = double.infinity,
      TextStyle? titleTextStyle,
      TextStyle? messageTextStyle})
      : titleColor = titleColor ?? SupportBotColors.gray.shade900,
        messageColor = messageColor ?? SupportBotColors.gray.shade900,
        titleTextStyle = titleTextStyle ?? SupportBotTextstyle.small,
        messageTextStyle = messageTextStyle ?? SupportBotTextstyle.small.light300(),
        super(key: key);

  factory ExpAlert.style(
      {required ExpAlertStyle style,
      required String title,
      required String message,
      VoidCallback? onTap,
      double iconSize = 16.0,
      double maxWidth = double.infinity,
      TextStyle? titleTextStyle,
      TextStyle? messageTextStyle}) {
    return ExpAlert(
        title: title,
        message: message,
        onTap: onTap,
        backgroundColor: style.backgroundColor(),
        icon: Icon(
          style.iconData(),
          color: style.iconColor(),
          size: iconSize,
        ),
        maxWidth: maxWidth,
        titleColor: style.textColor(),
        messageColor: style.textColor(),
        titleTextStyle: titleTextStyle,
        messageTextStyle: messageTextStyle);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: iconPadding,
              child: icon,
            ),
            SizedBox(width: iconSpacing),
            Expanded(
              child: Padding(
                padding: textPadding,
                child: RichText(
                  text: TextSpan(
                    text: "$title ",
                    style: titleTextStyle.v3WithColor(titleColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: message,
                        style: messageTextStyle.v3WithColor(messageColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
