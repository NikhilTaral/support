import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExportButton extends StatelessWidget {
  final String icon;
  final double iconSize; // Add a property for icon size

  const ExportButton({
    Key? key,
    required this.icon,
    this.iconSize = 30.0, // Default icon size (adjust as needed)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

        return Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.only(right: 1),
          child: TextButton(
            onPressed: () {},
            child: SvgPicture.asset(
              icon,
              width: iconSize,
              height: iconSize,
            ),
          ),
        );
  }
}
