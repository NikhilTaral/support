import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/common_widgets/alert_style.dart';

class FailureWidget extends StatelessWidget {
  final BorderRadius? borderRadius;
  final Function()? onTap;

  const FailureWidget({
    super.key,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: onTap,
        child: AIAlert.style(
          style: AIAlertStyle.danger,
          title: "Oops!",
          message:
              "There was an error retrieving this resource. Click here to try again.",
        ),
      ),
    );
  }
}
