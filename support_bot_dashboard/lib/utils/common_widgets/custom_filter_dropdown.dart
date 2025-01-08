import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class CustomFilterDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final String label;
  final ValueChanged<String?> onChanged;
  final double width;
  final double height;
  final bool enabled;

  const CustomFilterDropdown({
    Key? key,
    this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.width,
    required this.label,
    this.height = 50,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () => _showDropdownDialog(context) : null,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(
                color: SupportBotColors.bluePrimary.shade500,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(selectedValue ?? "",
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: SupportBotTextstyle.regularTextStyle.copyWith(
                          fontWeight: FontWeight.w400,
                          color: SupportBotColors.bluePrimary)),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30,
                  color: SupportBotColors.bluePrimary,
                ),
              ],
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
              left: offset.dx,
              top: offset.dy + height + 27,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: width,
                  constraints: BoxConstraints(
                    maxHeight: UIHelpers.screenHeight(context) * 0.34,
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
                          _truncateTitle(item, 35),
                          style: item == selectedValue
                              ? SupportBotTextstyle.medium
                                  .copyWith(fontWeight: FontWeight.w500)
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

  String _truncateTitle(String title, int maxLength) {
    return title.length > maxLength
        ? '${title.substring(0, maxLength)}...'
        : title;
  }
}
