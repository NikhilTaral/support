import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class PlutoTableWidget extends StatelessWidget {
  final DashboardTableAttributeModel tableData;

  const PlutoTableWidget({Key? key, required this.tableData}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UIHelpers.verticalSpaceTinySmall,
        Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: _calculateMaxHeight(tableData.items.length),
            ),
            child: PlutoGrid(
              columns: [
                PlutoColumn(
                  title: 'ID',
                  field: 'id',
                  type: PlutoColumnType.text(),
                    enableFilterMenuItem: false,
                    enableHideColumnMenuItem: false,
                    textAlign: PlutoColumnTextAlign.start,
                    titlePadding: const EdgeInsets.all(8),
                    backgroundColor: SupportBotColors.blueSecondary.shade100,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    enableEditingMode: false,
                    enableColumnDrag: false,
                    readOnly: true,
                ),
                PlutoColumn(
                  title: 'Classification',
                  field: 'classification',
                  type: PlutoColumnType.text(),
                   enableFilterMenuItem: false,
                    enableHideColumnMenuItem: false,
                    textAlign: PlutoColumnTextAlign.start,
                    titlePadding: const EdgeInsets.all(8),
                    backgroundColor: SupportBotColors.blueSecondary.shade100,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    enableEditingMode: false,
                    enableColumnDrag: false,
                    readOnly: true,
                ),
                PlutoColumn(
                  title: 'Pipeline Stage',
                  field: 'hSPipelineStage',
                  type: PlutoColumnType.text(),
                   enableFilterMenuItem: false,
                    enableHideColumnMenuItem: false,
                    textAlign: PlutoColumnTextAlign.start,
                    titlePadding: const EdgeInsets.all(8),
                    backgroundColor: SupportBotColors.blueSecondary.shade100,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    enableEditingMode: false,
                    enableColumnDrag: false,
                    readOnly: true,
                ),
                PlutoColumn(
                  title: 'Reasoning',
                  field: 'reasoning',
                  type: PlutoColumnType.text(),
                   enableFilterMenuItem: false,
                    enableHideColumnMenuItem: false,
                    textAlign: PlutoColumnTextAlign.start,
                    titlePadding: const EdgeInsets.all(8),
                    backgroundColor: SupportBotColors.blueSecondary.shade100,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    enableEditingMode: false,
                    enableColumnDrag: false,
                    readOnly: true,
                ),
                PlutoColumn(
                  title: 'Created At',
                  field: 'createdAt',
                  type: PlutoColumnType.text(),
                   enableFilterMenuItem: false,
                    enableHideColumnMenuItem: false,
                    textAlign: PlutoColumnTextAlign.start,
                    titlePadding: const EdgeInsets.all(8),
                    backgroundColor: SupportBotColors.blueSecondary.shade100,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    enableEditingMode: false,
                    enableColumnDrag: false,
                    readOnly: true,
                ),
              ],
              rows: tableData.items.map((item) {
                return PlutoRow(
                  cells: {
                    'id': PlutoCell(value: item.id),
                    'classification': PlutoCell(value: item.classification),
                    'hSPipelineStage': PlutoCell(value: item.hsPipelineStage),
                    'reasoning': PlutoCell(value: item.reasoning),
                    'createdAt': PlutoCell(value: item.createdAt),
                  },
                );
              }).toList(),
              configuration: PlutoGridConfiguration(
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
              ),
            ),
          ),
        ),
      ],
    );
  }

  double _calculateMaxHeight(int itemCount) {
    const double rowHeight = 25;
    const double headerHeight = 30;
    const double maxVisibleRows = 10;
    const double paddingHeight = 30;
    if (itemCount <= maxVisibleRows) {
      return rowHeight * itemCount + headerHeight + paddingHeight;
    } else {
      return rowHeight * maxVisibleRows + headerHeight + paddingHeight;
    }
  }
}
