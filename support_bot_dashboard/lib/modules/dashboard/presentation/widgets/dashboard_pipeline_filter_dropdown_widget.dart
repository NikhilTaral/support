import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class DashboardPipelineFilterDropdownWidget extends StatelessWidget {
  final String? selectedValue;
  final List<String?> items;
  final ValueChanged<String?> onChanged;
  final String label;
  final double width;

  const DashboardPipelineFilterDropdownWidget({
    Key? key,
    this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.label,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDropdownDialog(context),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: SupportBotColors.gray),
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 5),
            margin: const EdgeInsets.only(top: 15, bottom: 10, left: 15, right: 1),
            height: UIHelpers.screenHeight(context) * 0.05,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue ?? label,
                  style: selectedValue != null
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
            left: 20,
            top: 5,
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
              top: offset.dy + UIHelpers.screenHeight(context) * 0.05 + 15,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: width,
                  constraints: BoxConstraints(
                    maxHeight: UIHelpers.screenHeight(context) * 0.24,
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
                          item ?? '',
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