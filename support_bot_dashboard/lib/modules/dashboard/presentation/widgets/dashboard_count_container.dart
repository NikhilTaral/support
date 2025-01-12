import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class CountContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  final double? count;
  const CountContainer(
      {super.key, required this.text, required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: UIHelpers.screenHeight(context) * 0.13,
        decoration: BoxDecoration(
            color: SupportBotColors.bluePrimary.shade400,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color(0xFFDBE2EF)),
                child: Icon(
                  icon,
                  color: SupportBotColors.bluePrimary,
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          "$count",
                          style: SupportBotTextstyle.subheadingH3.copyWith(
                              fontSize: 30,
                              color: SupportBotColors.white,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          text,
                          style: SupportBotTextstyle.small.copyWith(
                              fontWeight: FontWeight.w600,
                              color: SupportBotColors.white),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
