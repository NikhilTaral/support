import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ticket_classification_gridkey.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/custom_pagination_dropdown.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_validation_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_sidebar.dart';
import 'package:support_bot_dashboard/utils/common_widgets/pluto_table_widget.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class TicketClassificationTableWidget extends StatelessWidget {
  final DashboardTableAttributeModel tableData;
  final DateTime? selectedMonth;
  final DateTime? selectedDate; 
  String pipeline;
  String pipelineId;
  String? selectedClassification;
  String? selectedClassificationValidation;

   final ValueNotifier<int> currentPage;
  final ValueNotifier<int> pageSize;

  TicketClassificationTableWidget(
      {Key? key,
      required this.tableData,
      required this.selectedMonth,
      required this.pipeline,
       required this.currentPage,
    required this.pageSize,
    required this.selectedClassification,
    required this.selectedClassificationValidation,
      required this.selectedDate,required this.pipelineId})
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
    Color backgroundColor = const Color(0xFFE7E7E9),
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
          final value = rendererContext.cell.value ?? "N/A";
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
          final value = context.cell.value ?? "N/A";
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
            rowID: plutoRenderercontext.row.cells['id']?.value ?? "N/A",
            plutotableBloc: context.read<PlutotableBloc>(),
            date: selectedDate ?? null,
            month: selectedMonth ?? null,
            row: plutoRenderercontext.row,
            pipeline: pipelineId ?? "",
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
        renderer: (context) => actionsRenderer(
          context,
          selectedDate ?? null,
          selectedMonth,
        ),
      ),
    ];

    final rows = tableData.items.map((item) {
      return PlutoRow(
        cells: {
          TicketClassificationGridKey.id:
              PlutoCell(value: item.id?.isEmpty ?? true ? 'N/A' : item.id),
          TicketClassificationGridKey.classification: PlutoCell(
              value: item.classification.isEmpty ?? true
                  ? 'N/A'
                  : item.classification),
          TicketClassificationGridKey.reasoning: PlutoCell(
              value: item.reasoning?.isEmpty ?? true ? 'N/A' : item.reasoning),
          TicketClassificationGridKey.ticketDescription: PlutoCell(
              value: item.ticketDescription?.isEmpty ?? true
                  ? 'N/A'
                  : item.ticketDescription),
          TicketClassificationGridKey.validation: PlutoCell(
              value: item.classificationValidation?.isEmpty ?? true
                  ? 'N/A'
                  : item.classificationValidation),
          TicketClassificationGridKey.validationReason: PlutoCell(
              value: item.classificationValidationReason?.isEmpty ?? true
                  ? 'N/A'
                  : item.classificationValidationReason),
          TicketClassificationGridKey.isUpdatedToHubspot:
              PlutoCell(value: item.isUpdatedToHubspot),
          TicketClassificationGridKey.status: PlutoCell(
              value:
                  item.isUpdatedToHubspot == true ? "Updated" : "Not Updated"),
          TicketClassificationGridKey.actions: PlutoCell(value: 'View'),
        },
      );
    }).toList();

    return Column(
      children: [
        PlutoTableWidget(columns: columns, rows: rows),
       Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Items per page:   ",
                            style: TextStyle(
                                color: SupportBotColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          ValueListenableBuilder<int>(
                            valueListenable: pageSize,
                            builder: (context, value, child) {
                              return CustomPaginationDropdown(
                                selectedValue: value,
                                items: const [10, 25, 50,100,500,1000],
                                onChanged: (value) {
                                  if (value != null) {
                                    pageSize.value = value;
                                    currentPage.value = 1;
                                   BlocProvider.of<PlutotableBloc>(
                                            context)
                                        .add(
                                      FetchTableDataEvent(
                                       selectedDate: selectedDate,
                                       selectedMonth: selectedMonth,
                                       selectedPipeline: pipelineId,
                                        page: currentPage.value,
                                        pageSize: pageSize.value,
                                            selectedClassification: selectedClassification == "Select" ? null: selectedClassification,
                                        selectedClassificationValidation: selectedClassificationValidation != null ? selectedClassificationValidation?.toLowerCase() : null
                                      ),
                                    );
                                  }
                                },
                                width: 80,
                                height: 40,
                              );
                            },
                          ),
                        ],
                      ),
                      UIHelpers.horizontalSpaceRegular,
                      Row(
                        children: [
                          Text(
                            "${(currentPage.value - 1) * pageSize.value + 1} - "
                            "${(currentPage.value * pageSize.value > (tableData.totalRecords ?? 0)) ? tableData.totalRecords ?? 0 : currentPage.value * pageSize.value} of "
                            "${tableData.totalRecords ?? 0}",
                            style: TextStyle(
                              color: SupportBotColors.bluePrimary.shade500,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: currentPage.value > 1
                                ? () {
                                    currentPage.value--;
                                    BlocProvider.of<PlutotableBloc>(
                                            context)
                                        .add(
                                      FetchTableDataEvent(
                                       selectedDate: selectedDate,
                                       selectedMonth: selectedMonth,
                                       selectedPipeline: pipelineId,
                                        page: currentPage.value,
                                        pageSize: pageSize.value,
                                        selectedClassification: selectedClassification == "Select" ? null: selectedClassification,
                                        selectedClassificationValidation: selectedClassificationValidation != null ? selectedClassificationValidation?.toLowerCase() : null
                                      ),
                                    );
                                  }
                                : null,
                            icon:
                                const Icon(Icons.arrow_back_ios_new, size: 15),
                          ),
                          ValueListenableBuilder<int>(
                            valueListenable: currentPage,
                            builder: (context, page, _) {
                              return Text(
                                'Page $page',
                                style: const TextStyle(
                                    color: SupportBotColors.black,
                                    fontWeight: FontWeight.w500),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: (currentPage.value * pageSize.value) <
                                    (tableData.totalRecords ??
                                        0)
                                ? () {
                                  print('fghjhgfdcsx $selectedClassificationValidation');
                                    currentPage.value++;
                                    BlocProvider.of<PlutotableBloc>(
                                            context)
                                        .add(
                                      FetchTableDataEvent(
                                        selectedDate: selectedDate,
                                       selectedMonth: selectedMonth,
                                       selectedPipeline: pipelineId,
                                        page: currentPage.value,
                                        pageSize: pageSize.value,
                                        selectedClassification: selectedClassification == "Select" ? null: selectedClassification,
                                        selectedClassificationValidation: selectedClassificationValidation != null ? selectedClassificationValidation?.toLowerCase() : null
                                      ),
                                    );
                                  }
                                : null,
                            icon: const Icon(Icons.arrow_forward_ios, size: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
      ],
    );
  }
}

Widget actionsRenderer(
  PlutoColumnRendererContext rendererContext,
  DateTime? selectedDate,
  DateTime? selectedMonth,
) {
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

  return BlocConsumer<PlutotableBloc, PlutotableState>(
    listener: (context, state) {
      if (state is RevertClassificationSuccessState) {
        Navigator.pop(context);
      }
    },
    builder: (context, state) {
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
                          if (isUpdatedToHubspot) {
                            context.read<PlutotableBloc>().add(
                                  RevertClassificationEvent(
                                      ticketId: id,
                                      selectedDate: selectedDate ?? null,
                                      selectedMonth: selectedMonth,
                                      selectedClassification: classification),
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
    },
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
