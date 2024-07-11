import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class YourWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
      dropDownListName: const {
        Options.ListName1: 'ListName1',
        Options.ListName2: 'ListName2',
        Options.ListName3: 'ListName3',
      },
      value: Options.ListName1,
      onChanged: (selectedOption) {
      },
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final Map<Options, String> dropDownListName;
  final Options value;
  final Function(Options?) onChanged;

  const CustomDropdown({
    Key? key,
    required this.dropDownListName,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          color: SupportBotColors.bluePrimary,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: const Icon(
            ExpV3Icons.arrowDown14,
            size: 20,
            color: SupportBotColors.bluePrimary,
          ),
          value: value,
          onChanged: onChanged,
          focusColor: Colors.transparent,
          items: dropDownListName.keys.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  dropDownListName[option] ?? '',
                  style: SupportBotTextstyle.small.copyWith(
                    fontWeight: FontWeight.w400,
                    color: SupportBotColors.bluePrimary.shade400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

enum Options {
  ListName1,
  ListName2,
  ListName3,
}
