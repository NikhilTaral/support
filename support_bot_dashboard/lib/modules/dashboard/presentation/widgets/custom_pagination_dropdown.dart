import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class CustomPaginationDropdown extends StatelessWidget {
  final num selectedValue;
  final List<int> items;
  final ValueChanged<int?> onChanged;
  final double width;
  final double height;
  final bool enabled;

  const CustomPaginationDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.width,
    required this.height,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () => _showDropdownDialog(context) : null,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text('$selectedValue',
                  style: SupportBotTextstyle.hint.copyWith(
                    fontWeight: FontWeight.w500,
                    color: SupportBotColors.gray.shade700,
                  )),
            ),
            const Icon(
              Icons.arrow_drop_down,
              size: 20,
            ),
          ],
        ),
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
              top:
                  offset.dy - (height * items.length) - 25, // Positioning above
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
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
                        title: Text('$item',
                            style: item == selectedValue
                                ? SupportBotTextstyle.hint.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: SupportBotColors.bluePrimary,
                                  )
                                : SupportBotTextstyle.hint.copyWith(
                                    color: SupportBotColors.gray.shade700,
                                  )),
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
