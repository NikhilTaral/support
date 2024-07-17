import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class DateSelectionWidget extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;
  final String label;
  final bool isInteractive;

  const DateSelectionWidget({
    Key? key,
    required this.selectedDate,
    required this.onChanged,
    required this.label,
    required this.isInteractive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: SupportBotColors.gray),
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 5),
            margin: const EdgeInsets.only(top: 20, left: 25, right: 1),
            height: UIHelpers.screenHeight(context)/18,
            width: UIHelpers.screenWidth(context)/7,
            child: GestureDetector(
              onTap: isInteractive
                  ? () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        onChanged(picked);
                      }
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      selectedDate != DateTime.now()
                          ? selectedDate.toIso8601String().substring(0, 10)
                          : 'Select date',
                      style: SupportBotTextstyle.dateText,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                 Icon(Icons.calendar_month, color: SupportBotColors.bluePrimary.shade500),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 35,
          top: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: SupportBotColors.white,
            child: Text(
              label,
              style: SupportBotTextstyle.dateLabel
            ),
          ),
        ),
      ],
    );
  }
}
