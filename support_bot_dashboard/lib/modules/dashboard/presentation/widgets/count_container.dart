import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';

class CountContainer extends StatelessWidget {
  final String text;
  final String icon;
  final String count;
  const CountContainer(
      {super.key, required this.text, required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 0, bottom: 50, left: 20, right: 0),
        height: MediaQuery.of(context).size.height / 7,
        width: MediaQuery.of(context).size.width / 6.2,
        color: SupportBotColors.bluePrimary.shade400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    icon,
                    width: 40,
                    height: 40,
                  ),
                )),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Text(
                          count,
                          style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: SupportBotColors.white),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          text,
                          style: const TextStyle(
                              fontSize: 14, color: SupportBotColors.white),
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
