import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';

class PlutoGridConfigurations {
  static plutoGridConfigurations() {
    return PlutoGridConfiguration(
      columnSize: const PlutoGridColumnSizeConfig(
          autoSizeMode: PlutoAutoSizeMode.scale),
      style: PlutoGridStyleConfig(
        iconSize: 0,
        defaultCellPadding: EdgeInsets.zero,
        gridBorderRadius: const BorderRadius.all(Radius.circular(0)),
        gridBorderColor: SupportBotColors.blueSecondary.shade100,
        cellColorInEditState: Colors.transparent,
        cellTextStyle: const TextStyle(fontSize: 14),
      ),
    );
  }
}
