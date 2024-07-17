import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    this.isSelected = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UIHelpers.screenWidth(context) * 0.2,
      height: UIHelpers.screenHeight(context) * 0.05,
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 3),
        width: MediaQuery.of(context).size.width * 0.4,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? SupportBotColors.bluePrimary.shade500 : SupportBotColors.blueSecondary.shade200,
            foregroundColor: isSelected ? SupportBotColors.white : SupportBotColors.black,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}