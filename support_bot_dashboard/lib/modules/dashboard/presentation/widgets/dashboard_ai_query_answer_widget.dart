import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class AIQueryAnswerWidget extends StatelessWidget {
  const AIQueryAnswerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: UIHelpers.screenHeight(context) * 0.44,
        child: PlutoGrid(
          columns: [
            PlutoColumn(
              title: S.of(context).id,
              field: 'id',
              width: UIHelpers.screenWidth(context) * 0.1,
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
              title: S.of(context).ticketDescription,
              field: 'ticketDescription',
              width: UIHelpers.screenWidth(context) * 0.25,
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
              renderer: (PlutoColumnRendererContext rendererContext) {
                final value = rendererContext.cell.value ?? '';
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: CustomToolTip(
                    message: value.toString(),
                    width: 400,
                    toolTipDirection: CustomToolTip.toolTipRight,
                    isMobile: false,
                    child: Text(
                      value.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
            PlutoColumn(
              title: S.of(context).aiQueryAnswer,
              field: 'aiQueryAnswer',
              width: UIHelpers.screenWidth(context) * 0.25,
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
              renderer: (PlutoColumnRendererContext rendererContext) {
                final value = rendererContext.cell.value ?? '';
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: CustomToolTip(
                    message: value.toString(),
                    width: 400,
                    toolTipDirection: CustomToolTip.toolTipRight,
                    isMobile: false,
                    child: Text(
                      value.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
            PlutoColumn(
              title: S.of(context).link,
              field: 'link',
              width: UIHelpers.screenWidth(context) * 0.1,
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
          rows: [
            PlutoRow(cells: {
              'id': PlutoCell(value: '2345678'),
              'ticketDescription': PlutoCell(value: 'Text cell value1'),
              'aiQueryAnswer': PlutoCell(value: 'Text cell value1'),
              'link': PlutoCell(value: 'www.google.com')
            }),
            PlutoRow(cells: {
              'id': PlutoCell(value: '2345678'),
              'ticketDescription': PlutoCell(value: 'Text cell value2'),
              'aiQueryAnswer': PlutoCell(value: 'Text cell value2'),
              'link': PlutoCell(value: 'www.google.com')
            })
          ],
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
    );
  }
}
