import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.iconData,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
    this.foregroundColor,
  }) : super(key: key);

  final void Function()? onPressed;
  final Widget child;
  final double? borderRadius;
  final IconData? iconData;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: iconData == null
          ? Container()
          : Icon(
              iconData,
              color: iconColor ?? SupportBotColors.bluePrimary,
            ),
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: SupportBotColors.white,
        backgroundColor: backgroundColor ?? SupportBotColors.bluePrimary.shade500,
        elevation: 0,
        foregroundColor: foregroundColor ?? SupportBotColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
          side: BorderSide(
            color: borderColor ?? Colors.white,
          ),
        ),
      ),
      label: child,
    );
  }
}
