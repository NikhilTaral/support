import 'package:flutter/material.dart';

enum AIAlertStyle {
  success,
  info,
  warning,
  danger,
}

extension AIAlertStyleColorExtension on AIAlertStyle {
  Color textColor() {
    switch (this) {
      case AIAlertStyle.success:
        return const Color(0xFF186429);
      case AIAlertStyle.info:
        return const Color(0xFF0E616E);
      case AIAlertStyle.warning:
        return const Color(0xFF997404);
      case AIAlertStyle.danger:
        return const Color(0xFF842029);
    }
  }

  Color backgroundColor() {
    switch (this) {
      case AIAlertStyle.success:
        return const Color(0xFFD4EDDA);
      case AIAlertStyle.info:
        return const Color(0xFFD1ECF1);
      case AIAlertStyle.warning:
        return const Color(0xFFFFF3CD);
      case AIAlertStyle.danger:
        return const Color(0xFFF8D7DA);
    }
  }

  Color iconColor() {
    switch (this) {
      case AIAlertStyle.success:
        return const Color(0xFF186429);
      case AIAlertStyle.info:
        return const Color(0xFF0E616E);
      case AIAlertStyle.warning:
        return const Color(0xFF997404);
      case AIAlertStyle.danger:
        return const Color(0xFF842029);
    }
  }

  IconData iconData() {
    switch (this) {
      case AIAlertStyle.success:
        return Icons.check_circle_outline;
      case AIAlertStyle.info:
        return Icons.info;
      case AIAlertStyle.warning:
        return Icons.priority_high;
      case AIAlertStyle.danger:
        return Icons.priority_high;
    }
  }
}

class AIAlert extends StatelessWidget {
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

  AIAlert(
      {super.key,
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
      : titleColor = titleColor ?? Colors.grey.shade900,
        messageColor = messageColor ?? Colors.grey.shade900,
        titleTextStyle = titleTextStyle ?? const TextStyle(fontSize: 16),
        messageTextStyle = messageTextStyle ??
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w200);

  factory AIAlert.style(
      {required AIAlertStyle style,
      required String title,
      required String message,
      VoidCallback? onTap,
      double iconSize = 16.0,
      double maxWidth = double.infinity,
      TextStyle? titleTextStyle,
      TextStyle? messageTextStyle}) {
    return AIAlert(
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
                    style: titleTextStyle,
                    children: <TextSpan>[
                      TextSpan(
                        text: message,
                        style: messageTextStyle,
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
