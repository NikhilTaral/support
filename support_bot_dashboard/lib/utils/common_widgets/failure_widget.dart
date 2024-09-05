import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';

class FailureWidget extends StatefulWidget {
  final double width, height, radius;
  final Color color;
  final BorderRadius? borderRadius;
  final Color? textColor;

  const FailureWidget({
    super.key,
    required this.width,
    required this.height,
    this.radius = 5,
    this.borderRadius,
    required this.color,
    this.textColor = SupportBotColors.black,
  });

  @override
  State<FailureWidget> createState() => _FailureWidgetState();
}

class _FailureWidgetState extends State<FailureWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          color: widget.color),
      child: Center(
        child: Text(
          "OOPS!! Something Went Wrong..",
          style: TextStyle(color: widget.textColor),
        ),
      ),
    );
  }
}
