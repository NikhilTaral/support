import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'No Data Found',
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

class EmptyTable extends StatelessWidget {
  const EmptyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: UIHelpers.screenHeight(context) * 0.4,
          child: PlutoGrid(
            configuration: PlutoGridConfiguration(
              columnSize: const PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.scale),
              style: PlutoGridStyleConfig(
                activatedBorderColor: SupportBotColors.gray.shade900,
                inactivatedBorderColor: Colors.transparent,
                activatedColor: SupportBotColors.gray.shade200,
                enableColumnBorderHorizontal: false,
                enableColumnBorderVertical: false,
                enableCellBorderVertical: false,
                columnResizeIcon: Icons.drag_indicator_rounded,
                enableGridBorderShadow: true,
                enableRowColorAnimation: false,
                borderColor: SupportBotColors.gray.shade600,
                gridBorderRadius: const BorderRadius.all(Radius.circular(6)),
                gridBorderColor: SupportBotColors.blueSecondary.shade100,
                gridPopupBorderRadius:
                    const BorderRadius.all(Radius.circular(6)),
                rowHeight: 60,
                cellTextStyle: SupportBotTextstyle.regularTextStyle,
                columnTextStyle: SupportBotTextstyle.hint.copyWith(
                  color: SupportBotColors.blueSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              scrollbar:
                  const PlutoGridScrollbarConfig(scrollbarRadius: Radius.zero),
            ),
            columns: [
              PlutoColumn(
                backgroundColor: SupportBotColors.blueSecondary.shade100,
                title: 'RedFlags',
                field: 'text',
                titleTextAlign: PlutoColumnTextAlign.center,
                enableDropToResize: false,
                enableContextMenu: false,
                enableHideColumnMenuItem: false,
                enableEditingMode: false,
                enableColumnDrag: false,
                type: PlutoColumnType.text(),
                width: UIHelpers.screenWidth(context) * 0.368,
              ),
              PlutoColumn(
                backgroundColor: SupportBotColors.blueSecondary.shade100,
                title: 'Status',
                titleTextAlign: PlutoColumnTextAlign.center,
                textAlign: PlutoColumnTextAlign.center,
                field: 'status',
                type: PlutoColumnType.text(),
                enableDropToResize: false,
                enableContextMenu: false,
                enableHideColumnMenuItem: false,
                enableColumnDrag: false,
                enableEditingMode: false,
                width: UIHelpers.screenWidth(context) * 0.13,
              ),
              PlutoColumn(
                enableDropToResize: false,
                enableContextMenu: false,
                enableHideColumnMenuItem: false,
                enableColumnDrag: false,
                titleTextAlign: PlutoColumnTextAlign.center,
                textAlign: PlutoColumnTextAlign.center,
                backgroundColor: SupportBotColors.blueSecondary.shade100,
                title: 'Confirm',
                field: 'Confirm',
                type: PlutoColumnType.text(),
              ),
            ],
            rows: [],
          ),
        ),
      ],
    );
  }
}
