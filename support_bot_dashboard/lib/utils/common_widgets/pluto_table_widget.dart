
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

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
        enableColumnBorderVertical: true,
        enableCellBorderVertical: true,
        enableCellBorderHorizontal: true,
        gridBorderRadius: BorderRadius.circular(8),
        gridPopupBorderRadius: BorderRadius.circular(8),
        rowHeight: 50,
        columnHeight: 50,
        gridBorderColor: Colors.transparent,
        columnTextStyle: SupportBotTextstyle.columnHeading,
        cellTextStyle: SupportBotTextstyle.cellHeading,
        enableGridBorderShadow: true,
      ),
      columnSize: const PlutoGridColumnSizeConfig(
        autoSizeMode: PlutoAutoSizeMode.scale,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: UIHelpers.screenHeight(context) * 0.42,
        child: PlutoGrid(
          columns: columns,
          rows: rows,
          configuration: configuration,
        ),
      ),
    );
  }
}