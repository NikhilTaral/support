import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class V3UnderliningButton extends StatefulWidget {
  const V3UnderliningButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  State<V3UnderliningButton> createState() => _V3UnderliningButtonState();
}

class _V3UnderliningButtonState extends State<V3UnderliningButton> {
  bool isUnderlined = false;

  @override
  Widget build(BuildContext context) {
    Color underlineColor = Colors.transparent;

    if (isUnderlined) {
      underlineColor = SupportBotColors.blueSecondary.shade400;
    }

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onHover: (isHover) {
        setState(() {
          isUnderlined = isHover;
        });
      },
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: underlineColor,
            ),
          ),
        ),
        child: Text(
          widget.text,
          style: SupportBotTextstyle.normal.copyWith(color: SupportBotColors.sky),
        ),
      ),
    );
  }
}
