import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class PlutoTableWidget extends StatelessWidget {
  final List<PlutoColumn> columns;
  final List<PlutoRow> rows;

  const PlutoTableWidget({
    Key? key,
    required this.columns,
    required this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final configuration = PlutoGridConfiguration(
      style: PlutoGridStyleConfig(
        enableColumnBorderHorizontal: false,
        enableColumnBorderVertical: false,
        enableCellBorderVertical: false,
        enableCellBorderHorizontal: true,
        activatedColor: Colors.transparent,
        activatedBorderColor: Colors.transparent,
        gridBorderRadius: BorderRadius.circular(6),
        gridPopupBorderRadius: BorderRadius.circular(6),
        rowHeight: 44,
        gridBorderColor: SupportBotColors.blueSecondary.shade200,
        columnTextStyle: SupportBotTextstyle.columnHeading,
        cellTextStyle: SupportBotTextstyle.cellHeading,
        enableGridBorderShadow: true,
      ),
      columnSize: const PlutoGridColumnSizeConfig(
        autoSizeMode: PlutoAutoSizeMode.scale,
      ),
    );

    return SizedBox(
      child: PlutoGrid(
        columns: columns,
        rows: rows,
        configuration: configuration,
      ),
    );
  }
}
