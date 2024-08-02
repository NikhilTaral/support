import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class V3LoginAgentTile extends StatelessWidget {
  V3LoginAgentTile({
    Key? key,
    required this.isActive,
    required this.isBordered,
  }) : super(key: key);

  final bool isActive, isBordered;
  final activeImageUrl = 'assets/images/login/ser-tie_v3_inactive_icon.svg';
  final inactiveImageUrl = 'assets/images/join/user-tie-inactive.svg';
  final activeTextColor = SupportBotColors.blueSecondary.shade400;
  final inactiveTextColor = SupportBotColors.blueSecondary.shade200;
  final activeBorderColor = SupportBotColors.blueSecondary.shade400;
  final inactiveBorderColor = SupportBotColors.white;

  @override
  Widget build(BuildContext context) {
    final imageUrl = inactiveImageUrl;
    final textColor = isActive ? activeTextColor : inactiveTextColor;
    final borderColor = isBordered ? activeBorderColor : inactiveBorderColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: borderColor,
          width: 3.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 50.0),
          SizedBox(
            height: 43.0,
            width: 38.0,
            child: SvgPicture.asset(
              imageUrl,
            ),
          ),
          const SizedBox(height: 20.0),
          Flexible(
            child: Text(
              'I\'m an active\neXp agent',
              style: SupportBotTextstyle.normal.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
