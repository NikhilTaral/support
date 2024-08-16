import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ticket_classification_gridkey.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/revert_classification/revert_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_validation_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_sidebar.dart';
import 'package:support_bot_dashboard/utils/common_widgets/pluto_table_widget.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class TicketClassificationTableWidget extends StatelessWidget {
  final DashboardTableAttributeModel tableData;
  final DateTime selectedMonth;
  final DateTime selectedDate;

  const TicketClassificationTableWidget(
      {Key? key,
      required this.tableData,
      required this.selectedMonth,
      required this.selectedDate})
      : super(key: key);

  PlutoColumn buildPlutoColumn({
    required String title,
    required String field,
    required PlutoColumnType type,
    required double width,
    Widget Function(PlutoColumnRendererContext)? renderer,
    bool enableFilterMenuItem = false,
    bool enableHideColumnMenuItem = false,
    PlutoColumnTextAlign textAlign = PlutoColumnTextAlign.start,
    EdgeInsets titlePadding = const EdgeInsets.all(8),
    Color backgroundColor = const Color(0xFFE9ECF4),
    bool enableContextMenu = false,
    bool enableDropToResize = false,
    bool enableEditingMode = false,
    bool enableColumnDrag = false,
    bool readOnly = true,
  }) {
    return PlutoColumn(
      title: title,
      field: field,
      type: type,
      width: width,
      enableFilterMenuItem: enableFilterMenuItem,
      enableHideColumnMenuItem: enableHideColumnMenuItem,
      textAlign: textAlign,
      titlePadding: titlePadding,
      backgroundColor: backgroundColor,
      enableContextMenu: enableContextMenu,
      enableDropToResize: enableDropToResize,
      enableEditingMode: enableEditingMode,
      enableColumnDrag: enableColumnDrag,
      readOnly: readOnly,
      renderer: renderer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final columns = [
      buildPlutoColumn(
        title: S.of(context).id,
        field: TicketClassificationGridKey.id,
        type: PlutoColumnType.text(),
        width: UIHelpers.screenWidth(context) * 0.1,
      ),
      buildPlutoColumn(
        title: S.of(context).ticketDescription,
        field: TicketClassificationGridKey.ticketDescription,
        type: PlutoColumnType.text(),
        width: UIHelpers.screenWidth(context) * 0.2,
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
      buildPlutoColumn(
        title: S.of(context).classification,
        field: TicketClassificationGridKey.classification,
        type: PlutoColumnType.text(),
        width: UIHelpers.screenWidth(context) * 0.18,
        enableFilterMenuItem: true,
      ),
      buildPlutoColumn(
        title: S.of(context).reasoning,
        field: TicketClassificationGridKey.reasoning,
        type: PlutoColumnType.text(),
        width: UIHelpers.screenWidth(context) * 0.2,
        renderer: (PlutoColumnRendererContext context) {
          final value = context.cell.value ?? '';
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
      buildPlutoColumn(
        title: S.of(context).validation,
        field: TicketClassificationGridKey.validation,
        type: PlutoColumnType.text(),
        width: UIHelpers.screenWidth(context) * 0.15,
        readOnly: false,
        renderer: (PlutoColumnRendererContext plutoRenderercontext) {
          return ValidationReasonRenderer(
            rowID: plutoRenderercontext.row.cells['id']?.value ?? "",
            plutotableBloc: context.read<PlutotableBloc>(),
            date: selectedDate,
            month: selectedMonth,
            row: plutoRenderercontext.row,
          );
        },
      ),
      buildPlutoColumn(
        title: S.of(context).validationReason,
        field: TicketClassificationGridKey.validationReason,
        type: PlutoColumnType.text(),
        width: UIHelpers.screenWidth(context) * 0.15,
        renderer: (PlutoColumnRendererContext context) {
          final value = context.cell.value ?? 'N/A';
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: value.toString().isEmpty
                ? const Text('N/A')
                : CustomToolTip(
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
      buildPlutoColumn(
        title: S.of(context).status,
        field: TicketClassificationGridKey.status,
        type: PlutoColumnType.text(),
        width: UIHelpers.screenWidth(context) * 0.13,
        textAlign: PlutoColumnTextAlign.center,
      ),
      buildPlutoColumn(
        title: S.of(context).actions,
        field: TicketClassificationGridKey.actions,
        type: PlutoColumnType.text(),
        width: UIHelpers.screenWidth(context) * 0.07,
        textAlign: PlutoColumnTextAlign.center,
        renderer: actionsRenderer,
      ),
    ];

    final rows = tableData.items.map((item) {
      return PlutoRow(
        cells: {
          TicketClassificationGridKey.id: PlutoCell(value: item.id),
          TicketClassificationGridKey.classification:
              PlutoCell(value: item.classification),
          TicketClassificationGridKey.reasoning:
              PlutoCell(value: item.reasoning),
          TicketClassificationGridKey.ticketDescription:
              PlutoCell(value: item.ticketDescription),
          TicketClassificationGridKey.validation:
              PlutoCell(value: item.classificationValidation),
          TicketClassificationGridKey.validationReason:
              PlutoCell(value: item.classificationValidationReason),
          TicketClassificationGridKey.isUpdatedToHubspot:
              PlutoCell(value: item.isUpdatedToHubspot),
          TicketClassificationGridKey.status: PlutoCell(
              value:
                  item.isUpdatedToHubspot == true ? "Updated" : "Not Updated"),
          TicketClassificationGridKey.actions: PlutoCell(value: 'View'),
        },
      );
    }).toList();

    return PlutoTableWidget(columns: columns, rows: rows);
  }
}

Widget actionsRenderer(PlutoColumnRendererContext rendererContext) {
  final id =
      rendererContext.row.cells[TicketClassificationGridKey.id]?.value ?? "";
  final rows = rendererContext.stateManager.refRows.toList();
  final currentIndex = rows.indexOf(rendererContext.row);
  final isUpdatedToHubspot = rendererContext
          .row.cells[TicketClassificationGridKey.isUpdatedToHubspot]?.value ??
      true;
  final classification = rendererContext
          .row.cells[TicketClassificationGridKey.classification]?.value ??
      "";
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
                child: InkWell(
                  onTap: () {
                    _showSidebar(context, rows, currentIndex);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.visibility),
                      UIHelpers.horizontalSpaceTiny,
                      const Text('View'),
                    ],
                  ),
                ),
              ),
              if (classification == 'Spam/Marketing')
                PopupMenuItem<String>(
                  value: S.of(context).revert,
                  child: InkWell(
                    onTap: () {
                      print(isUpdatedToHubspot);

                      if (isUpdatedToHubspot) {
                        serviceLocator<RevertClassificationBloc>().add(
                          RevertClassificationInitialEvent(ticketId: id),
                        );
                        _showUpdatedToHubspotPopup(
                            context, S.of(context).revertSuccess);
                      } else {
                        _showUpdatedToHubspotPopup(
                            context, S.of(context).noRevert);
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.loop_rounded),
                        UIHelpers.horizontalSpaceTiny,
                        Text(S.of(context).revert),
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

void _showSidebar(BuildContext context, List<PlutoRow> rows, int currentIndex) {
  bool isNextEnabled = currentIndex < rows.length - 1;
  bool isPreviousEnabled = currentIndex > 0;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.only(
            left: UIHelpers.screenWidth(context) * 0.7, right: 0),
        child: SizedBox(
          width: UIHelpers.screenWidth(context) * 0.3,
          child: CustomSidebar(
              rowData: rows[currentIndex],
              onNext: () {
                Navigator.pop(context);
                if (isNextEnabled) {
                  _showSidebar(context, rows, currentIndex + 1);
                }
              },
              onPrevious: () {
                Navigator.pop(context);
                if (isPreviousEnabled) {
                  _showSidebar(context, rows, currentIndex - 1);
                }
              },
              isNextEnabled: isNextEnabled,
              isPreviousEnabled: isPreviousEnabled),
        ),
      );
    },
  );
}

void _showUpdatedToHubspotPopup(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.of(context).statusUpdated),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SupportBotColors.bluePrimary,
              foregroundColor: SupportBotColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              S.of(context).ok,
              style: SupportBotTextstyle.hint.copyWith(
                color: SupportBotColors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}
