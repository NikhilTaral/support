import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class CustomFilterDropdown extends StatelessWidget {
  final String selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String label;
  final double width;

  const CustomFilterDropdown({
    Key? key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.label, required this.width,
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
          margin:
              const EdgeInsets.only(top: 30, bottom: 10, left: 15, right: 1),
          height: UIHelpers.screenHeight(context) * 0.05,
          width: width,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue.isNotEmpty && items.contains(selectedValue)
                  ? selectedValue
                  : 'Select',
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
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
              style: SupportBotTextstyle.dropdownLabel,
            ),
          ),
        ),
      ],
    );
  }
}