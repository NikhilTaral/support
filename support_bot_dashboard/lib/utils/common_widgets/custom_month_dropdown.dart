import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

// class CustomMonthDropdown extends StatelessWidget {
//   final DateTime selectedValue;
//   final List<String> items;
//   final ValueChanged<DateTime?> onChanged;
//   final String label;
  
//   const CustomMonthDropdown({
//     Key? key,
//     required this.selectedValue,
//     required this.items,
//     required this.onChanged,
//     required this.label,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//          Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: SupportBotColors.gray),
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       padding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 5),
//       margin: const EdgeInsets.only(top: 30, bottom: 10, left: 15, right: 1),
//       height: UIHelpers.screenHeight(context) * 0.05,
//       width: UIHelpers.screenWidth(context) * 0.13,
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<DateTime>(
//           value: selectedValue,
//           onChanged: onChanged,
//           items: items.map((String value) {
//             DateTime dateTimeValue = DateTime(2024, items.indexOf(value) + 1); 
//             return DropdownMenuItem<DateTime>(
//               value: dateTimeValue,
//               child: Text(value),
//             );
//           }).toList(),
//           icon: const Icon(Icons.keyboard_arrow_down_rounded),
//           iconSize: 30,
//           isExpanded: true,
//           focusColor: SupportBotColors.white,
//           dropdownColor: SupportBotColors.white,
//           autofocus: false,
//         ),
//       ),
//     ),
//     Positioned(
//           left: 25,
//           top: 20,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             color: SupportBotColors.white,
//             child: Text(
//               label,
//               style: SupportBotTextstyle.dropdownLabel
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class CustomMonthDropdown extends StatelessWidget {
  final String selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String label;

  const CustomMonthDropdown({
    Key? key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDropdownDialog(context),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: SupportBotColors.gray),
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 5),
            margin: const EdgeInsets.only(top: 30, bottom: 10, left: 15, right: 1),
            height: UIHelpers.screenHeight(context) * 0.05,
            width: UIHelpers.screenWidth(context) * 0.13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue.isNotEmpty ? selectedValue : label,
                  style: selectedValue.isNotEmpty
                      ? SupportBotTextstyle.medium.copyWith(fontWeight: FontWeight.w500)
                      : SupportBotTextstyle.mediumHint,
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30,
                  color: SupportBotColors.bluePrimary,
                ),
              ],
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
      ),
    );
  }

  void _showDropdownDialog(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              left: offset.dx + 15,
              top: offset.dy + UIHelpers.screenHeight(context) * 0.05 + 30,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: UIHelpers.screenWidth(context) * 0.13,
                  constraints: BoxConstraints(
                    maxHeight: UIHelpers.screenHeight(context) * 0.35,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: SupportBotColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(
                          item,
                          style: item == selectedValue
                              ? SupportBotTextstyle.medium.copyWith(fontWeight: FontWeight.w500)
                              : SupportBotTextstyle.medium,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          onChanged(item);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}