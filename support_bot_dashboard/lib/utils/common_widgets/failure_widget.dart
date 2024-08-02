import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/common_widgets/alert_style.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: UIHelpers.screenHeight(context) * 0.48,
      child: Scaffold(
        body: InkWell(
          onTap: onTap,
          child: AIAlert.style(
            style: AIAlertStyle.danger,
            title: "Oops!",
            message:
                "There was an error retrieving this resource. Click here to try again.",
            titleTextStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
