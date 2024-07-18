import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class CustomDropdown extends StatelessWidget {
  final DateTime selectedValue;
  final List<String> items;
  final ValueChanged<DateTime?> onChanged;
  final String label;
  
  const CustomDropdown({
    Key? key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         Container(
      decoration: BoxDecoration(
        border: Border.all(color: SupportBotColors.gray),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 5),
      margin: const EdgeInsets.only(top: 30, bottom: 10, left: 15, right: 1),
      height: UIHelpers.screenHeight(context)/18,
      width: UIHelpers.screenWidth(context)/7,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DateTime>(
          value: selectedValue,
          onChanged: onChanged,
          items: items.map((String value) {
            DateTime dateTimeValue = DateTime(2024, items.indexOf(value) + 1); 
            return DropdownMenuItem<DateTime>(
              value: dateTimeValue,
              child: Text(value),
            );
          }).toList(),
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 30,
          isExpanded: true,
          focusColor: SupportBotColors.white,
          dropdownColor: SupportBotColors.white,
          autofocus: false,
        ),
      ),
    ),
    Positioned(
          left: 25,
          top: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: SupportBotColors.white,
            child: Text(
              label,
              style: SupportBotTextstyle.dropdownLabel
            ),
          ),
        ),
      ],
    );
  }
}
