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
            PlutoColumn(
              title: S.of(context).actions,
              field: 'actions',
              type: PlutoColumnType.text(),
              width: UIHelpers.screenWidth(context) * 0.07,
              enableFilterMenuItem: false,
              enableHideColumnMenuItem: false,
              textAlign: PlutoColumnTextAlign.center,
              titlePadding: const EdgeInsets.all(8),
              backgroundColor: SupportBotColors.blueSecondary.shade100,
              enableContextMenu: false,
              enableDropToResize: false,
              enableEditingMode: false,
              enableColumnDrag: false,
              readOnly: true,
              renderer: actionsRenderer,
            ),
          ],
          rows: [
            PlutoRow(cells: {
              'id': PlutoCell(value: '2345678'),
              'ticketDescription': PlutoCell(value: 'Text cell value1'),
              'aiQueryAnswer': PlutoCell(value: 'Text cell value1'),
              'link': PlutoCell(value: 'www.google.com'),
              'actions': PlutoCell(value: 'View')
            }),
            PlutoRow(cells: {
              'id': PlutoCell(value: '2345679'),
              'ticketDescription': PlutoCell(value: 'Text cell value2'),
              'aiQueryAnswer': PlutoCell(value: 'Text cell value2'),
              'link': PlutoCell(value: 'www.google.com'),
              'actions': PlutoCell(value: 'View')
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

Widget actionsRenderer(PlutoColumnRendererContext rendererContext) {
  final rows = rendererContext.stateManager.refRows.toList();
  final currentIndex = rows.indexOf(rendererContext.row);
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Align(
        child: PopupMenuTheme(
          data: const PopupMenuThemeData(
            color: SupportBotColors.white,
          ),
          child: PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            offset: const Offset(-40, 0),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: S.of(context).view,
                child: GestureDetector(
                  onTap: () {
                    _showDetails(context, rows, currentIndex);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.visibility),
                      UIHelpers.horizontalSpaceTiny,
                      Text(S.of(context).view),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

void _showDetails(
    BuildContext context, List<PlutoRow> rows, int currentIndex) async {
  bool isNextEnabled = currentIndex < rows.length - 1;
  bool isPreviousEnabled = currentIndex > 0;

  final row = rows[currentIndex];
  final id = row.cells['id']?.value ?? "";
  final description = row.cells['ticketDescription']?.value ?? "";
  final aiQueryAnswer = row.cells['aiQueryAnswer']?.value ?? "";
  final link = row.cells['link']?.value ?? "";

  final result = await showDialog<Map<String, String>>(
    context: context,
    builder: (BuildContext context) {
      final aiQueryAnswerController =
          TextEditingController(text: aiQueryAnswer);
      final linkController = TextEditingController(text: link);
      bool isEditing = false;
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 14,
                  ),
                  onPressed: isPreviousEnabled
                      ? () {
                          Navigator.pop(context);
                          if (isPreviousEnabled) {
                            _showDetails(context, rows, currentIndex - 1);
                          }
                        }
                      : null,
                  color: isPreviousEnabled ? Colors.black : Colors.grey,
                ),
                Center(
                  child: Text(
                    'Ticket Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: SupportBotColors.bluePrimary.shade500,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: isNextEnabled
                        ? () {
                            Navigator.pop(context);
                            if (isNextEnabled) {
                              _showDetails(context, rows, currentIndex + 1);
                            }
                          }
                        : null,
                    color: isNextEnabled ? Colors.black : Colors.grey,
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ))
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(),
                  _buildDetailRow('Ticket Id :', id),
                  _buildDetailRow('Ticket Description :', description),
                  if (isEditing)
                    _buildEditableRow(
                        'AI Query Answer :', aiQueryAnswerController)
                  else
                    _buildDetailRow('AI Query Answer :', aiQueryAnswer),
                  if (isEditing)
                    _buildEditableRow('Link :', linkController)
                  else
                    _buildDetailRow('Link :', link),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.cancel,
                        color: SupportBotColors.bluePrimary.shade500),
                    label: Text(
                      'Cancel',
                      style: TextStyle(
                          color: SupportBotColors.bluePrimary.shade500),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: SupportBotColors.bluePrimary.shade500),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (isEditing) {
                        Navigator.of(context).pop({
                          'aiQueryAnswer': aiQueryAnswerController.text,
                          'link': linkController.text,
                        });
                      } else {
                        setState(() {
                          isEditing = true;
                        });
                      }
                    },
                    icon: Icon(
                      isEditing ? Icons.save : Icons.edit,
                      color: Colors.white,
                    ),
                    label: Text(
                      isEditing ? 'Save' : 'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SupportBotColors.bluePrimary.shade500,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 40),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );

  if (result != null) {
    // Handle the updated values here.
    print('Updated AI Query Answer: ${result['aiQueryAnswer']}');
    print('Updated Link: ${result['link']}');
  }
}

Widget _buildDetailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ],
    ),
  );
}

Widget _buildEditableRow(String title, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    ),
  );
}
