import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ticket_classification_gridkey.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/custom_pagination_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_sidebar.dart';
import 'package:support_bot_dashboard/utils/common_widgets/pluto_table_widget.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class TicketClassificationTableWidget extends StatelessWidget {
  final DashboardTableAttributeModel? tableData;
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
      required this.selectedDate,
      required this.pipelineId})
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
        type: PlutoColumnType.select(['Select', 'Correct', 'Incorrect']),
        width: UIHelpers.screenWidth(context) * 0.15,
        readOnly: false,
        renderer: (rendererContext) {
          return BlocBuilder<PlutotableBloc, PlutotableState>(
            builder: (context, state) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  String currentValue = rendererContext.cell.value ?? 'Select';

                  String displayValue =
                      currentValue.toLowerCase().split(' ').map((word) {
                    return word.isEmpty
                        ? ''
                        : '${word[0].toUpperCase()}${word.substring(1)}';
                  }).join(' ');

                  if (!['select', 'correct', 'incorrect']
                      .contains(currentValue.toLowerCase())) {
                    displayValue = 'Select';
                  }

                  return DropdownButton<String>(
                    value: displayValue,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          displayValue = newValue;
                        });

                        final rowId = rendererContext
                            .row.cells[TicketClassificationGridKey.id]?.value;
                        if (rowId != null) {
                          BlocProvider.of<PlutotableBloc>(context).add(
                            GetValidationDetailsEvent(ticketId: rowId),
                          );
                          context.read<PlutotableBloc>().stream.listen((state) {
                            if (state is FetchTableDataSuccess &&
                                state.getValidationDetailsAttributeModel !=
                                    null) {
                              if (state.getValidationDetailsAttributeModel?.data
                                      ?.status ==
                                  false) {
                                rendererContext.stateManager.changeCellValue(
                                    rendererContext.cell, newValue,
                                    force: true);

                                if (newValue.toLowerCase() == 'incorrect') {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      String reason = '';
                                      String _selectedClassification = 'Select';

                                      return AlertDialog(
                                        title: Text(
                                            S.of(context).emailValidations),
                                        backgroundColor: SupportBotColors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        content: SizedBox(
                                          width:
                                              UIHelpers.screenWidth(context) *
                                                  0.3,
                                          height:
                                              UIHelpers.screenHeight(context) *
                                                  0.3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                onChanged: (value) {
                                                  reason = value;
                                                },
                                                decoration: InputDecoration(
                                                  hintText:
                                                      S.of(context).comments,
                                                  contentPadding:
                                                      const EdgeInsets.all(
                                                          16.0),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                                maxLines: 4,
                                              ),
                                              UIHelpers.verticalSpaceSmall,
                                              Text(
                                                S.of(context).classification,
                                                style: SupportBotTextstyle
                                                    .subheadingH6
                                                    .copyWith(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              UIHelpers.verticalSpaceTiny,
                                              SizedBox(
                                                width: UIHelpers.screenWidth(
                                                        context) *
                                                    0.2,
                                                height: UIHelpers.screenHeight(
                                                        context) *
                                                    0.05,
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  value:
                                                      _selectedClassification,
                                                  items: [
                                                    'Select',
                                                    'Spam/Marketing',
                                                    'No Action Required',
                                                    'Genuine Query',
                                                    'Acknowledgement Required'
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style:
                                                            SupportBotTextstyle
                                                                .medium
                                                                .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              SupportBotColors
                                                                  .black,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String?
                                                      newClassification) {
                                                    if (newClassification !=
                                                        null) {
                                                      setState(() {
                                                        _selectedClassification =
                                                            newClassification;
                                                      });
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                  icon: const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    size: 30,
                                                    color:
                                                        SupportBotColors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  SupportBotColors.danger,
                                              foregroundColor:
                                                  SupportBotColors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 40),
                                            ),
                                            child: Text(
                                              S.of(context).cancel,
                                              style: SupportBotTextstyle.hint
                                                  .copyWith(
                                                color: SupportBotColors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(dialogContext).pop();
                                            },
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  SupportBotColors.bluePrimary,
                                              foregroundColor:
                                                  SupportBotColors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 40),
                                            ),
                                            child: Text(
                                              S.of(context).save,
                                              style: SupportBotTextstyle.hint
                                                  .copyWith(
                                                color: SupportBotColors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              if (reason.isNotEmpty &&
                                                  _selectedClassification !=
                                                      'Select') {
                                                BlocProvider.of<PlutotableBloc>(
                                                        context)
                                                    .add(
                                                  UpdateValidationEvent(
                                                      id: rowId,
                                                      validation: 'Incorrect',
                                                      reason: reason,
                                                      selectedDate:
                                                          selectedDate,
                                                      selectedMonth:
                                                          selectedMonth,
                                                      pipeline: pipelineId,
                                                      classification:
                                                          _selectedClassification),
                                                );
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(
                                                        GetValidationCountEvent(
                                                            selectedDate:
                                                                selectedDate,
                                                            selectedPipeline:
                                                                pipelineId ??
                                                                    ""));
                                                BlocProvider.of<DashboardBloc>(
                                                        context)
                                                    .add(
                                                        GetValidationByCountEvent(
                                                            selectedDate:
                                                                selectedDate,
                                                            selectedPipeline:
                                                                pipelineId ??
                                                                    ""));
                                                Navigator.of(dialogContext)
                                                    .pop();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Please provide reason and select classification')),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (newValue.toLowerCase() != 'select') {
                                  context.read<PlutotableBloc>().add(
                                        UpdateValidationEvent(
                                          id: rowId,
                                          validation: newValue,
                                          reason: '',
                                          selectedDate: selectedDate,
                                          selectedMonth: selectedMonth,
                                          pipeline: pipelineId,
                                        ),
                                      );
                                  BlocProvider.of<DashboardBloc>(context).add(
                                      GetValidationCountEvent(
                                          selectedDate: selectedDate,
                                          selectedPipeline: pipelineId ?? ""));
                                  BlocProvider.of<DashboardBloc>(context).add(
                                      GetValidationByCountEvent(
                                          selectedDate: selectedDate,
                                          selectedPipeline: pipelineId ?? ""));
                                }
                              } else {
                                setState(() {
                                  displayValue =
                                      rendererContext.cell.value ?? 'Select';
                                });
                                showDialog(
                                  context: context,
                                  builder: (BuildContext _) {
                                    return BlocProvider.value(
                                      value: context.read<PlutotableBloc>(),
                                      child: AlertDialog(
                                        title:  Text(S.of(context).validationExists),
                                        content: Text(state
                                                .getValidationDetailsAttributeModel
                                                ?.data
                                                ?.message ??
                                            ""),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  SupportBotColors.bluePrimary,
                                              foregroundColor:
                                                  SupportBotColors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 40),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              S.of(context).ok,
                                              style: SupportBotTextstyle.hint
                                                  .copyWith(
                                                color: SupportBotColors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          });
                        }
                      }
                    },
                    items: ['Select', 'Correct', 'Incorrect']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: SupportBotTextstyle.hint.copyWith(
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none,
                            color: SupportBotColors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    iconSize: 30,
                    iconEnabledColor: SupportBotColors.gray.shade800,
                    iconDisabledColor: SupportBotColors.gray.shade800,
                    underline: const SizedBox.shrink(),
                    dropdownColor: Colors.white,
                  );
                },
              );
            },
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
            context, selectedDate ?? null, selectedMonth, tableData),
      ),
    ];

    final rows = tableData?.items.map((item) {
      return PlutoRow(
        cells: {
          TicketClassificationGridKey.id:
              PlutoCell(value: item.id?.isEmpty ?? true ? 'N/A' : item.id),
          TicketClassificationGridKey.classification: PlutoCell(
              value: item.classification?.isEmpty ?? true
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
          'validatedClassification':
              PlutoCell(value: item.validatedClassification),
          'classificationValidatedBy':
              PlutoCell(value: item.classificationValidatedBy)
        },
      );
    }).toList();

    return Column(
      children: [
        PlutoTableWidget(columns: columns, rows: rows ?? []),
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
                        items: const [10, 25, 50, 100, 500, 1000],
                        onChanged: (value) {
                          if (value != null) {
                            pageSize.value = value;
                            currentPage.value = 1;
                            BlocProvider.of<PlutotableBloc>(context).add(
                              FetchTableDataEvent(
                                  selectedDate: selectedDate,
                                  selectedMonth: selectedMonth,
                                  selectedPipeline: pipelineId,
                                  page: currentPage.value,
                                  pageSize: pageSize.value,
                                  selectedClassification:
                                      selectedClassification == "Select"
                                          ? null
                                          : selectedClassification,
                                  selectedClassificationValidation:
                                      selectedClassificationValidation != null
                                          ? selectedClassificationValidation
                                              ?.toLowerCase()
                                          : null),
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
                    "${(currentPage.value * pageSize.value > (tableData?.totalRecords ?? 0)) ? tableData?.totalRecords ?? 0 : currentPage.value * pageSize.value} of "
                    "${tableData?.totalRecords ?? 0}",
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
                            BlocProvider.of<PlutotableBloc>(context).add(
                              FetchTableDataEvent(
                                  selectedDate: selectedDate,
                                  selectedMonth: selectedMonth,
                                  selectedPipeline: pipelineId,
                                  page: currentPage.value,
                                  pageSize: pageSize.value,
                                  selectedClassification:
                                      selectedClassification == "Select"
                                          ? null
                                          : selectedClassification,
                                  selectedClassificationValidation:
                                      selectedClassificationValidation != null
                                          ? selectedClassificationValidation
                                              ?.toLowerCase()
                                          : null),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.arrow_back_ios_new, size: 15),
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
                            (tableData?.totalRecords ?? 0)
                        ? () {
                            currentPage.value++;
                            BlocProvider.of<PlutotableBloc>(context).add(
                              FetchTableDataEvent(
                                  selectedDate: selectedDate,
                                  selectedMonth: selectedMonth,
                                  selectedPipeline: pipelineId,
                                  page: currentPage.value,
                                  pageSize: pageSize.value,
                                  selectedClassification:
                                      selectedClassification == "Select"
                                          ? null
                                          : selectedClassification,
                                  selectedClassificationValidation:
                                      selectedClassificationValidation != null
                                          ? selectedClassificationValidation
                                              ?.toLowerCase()
                                          : null),
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
    final DashboardTableAttributeModel? tableData) {
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
                        _showSidebar(context, rows, currentIndex, tableData);
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
                  if (isUpdatedToHubspot == true)
                    PopupMenuItem<String>(
                      value: S.of(context).revert,
                      child: InkWell(
                        onTap: () {
                          if (isUpdatedToHubspot) {
                            context.read<PlutotableBloc>().add(
                                  RevertClassificationEvent(
                                      ticketId: id,
                                      selectedDate: selectedDate,
                                      selectedMonth: selectedMonth,
                                      selectedClassification: classification),
                                );
                            _showRevertToHubspotPopup(
                                context, S.of(context).revertSuccess);
                          } else {
                            _showRevertToHubspotPopup(
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
                  if (isUpdatedToHubspot == false)
                    PopupMenuItem<String>(
                      value: S.of(context).updateTicket,
                      child: InkWell(
                        onTap: () {
                          if (!isUpdatedToHubspot) {
                            _showUpdatedToHubspotPopup(
                              context,
                              S.of(context).UpdateSuccess,
                              () {
                                context.read<PlutotableBloc>().add(
                                      UnRevertClassificationEvent(
                                        ticketId: id,
                                        selectedDate: selectedDate ?? null,
                                        selectedMonth: selectedMonth,
                                        selectedClassification: classification,
                                      ),
                                    );
                              },
                            );
                          } else {
                            _showRevertToHubspotPopup(
                                context, S.of(context).noRevert);
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(SupportBotIcons.update),
                            UIHelpers.horizontalSpaceTiny,
                            Text(S.of(context).updateTicket),
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

void _showSidebar(BuildContext context, List<PlutoRow> rows, int currentIndex,
    final DashboardTableAttributeModel? tableData) {
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
                _showSidebar(context, rows, currentIndex + 1, tableData);
              }
            },
            onPrevious: () {
              Navigator.pop(context);
              if (isPreviousEnabled) {
                _showSidebar(context, rows, currentIndex - 1, tableData);
              }
            },
            isNextEnabled: isNextEnabled,
            isPreviousEnabled: isPreviousEnabled,
            tableData: tableData,
          ),
        ),
      );
    },
  );
}

void _showUpdatedToHubspotPopup(
    BuildContext context, String message, VoidCallback onYesPressed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.of(context).statusUpdated),
        content: Text(message),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SupportBotColors.bluePrimary,
                  foregroundColor: SupportBotColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                ),
                onPressed: () {
                  onYesPressed();
                  Navigator.of(context).pop();
                },
                child: Text(
                  S.of(context).yes,
                  style: SupportBotTextstyle.hint.copyWith(
                    color: SupportBotColors.white,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SupportBotColors.bluePrimary,
                  foregroundColor: SupportBotColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  S.of(context).no,
                  style: SupportBotTextstyle.hint.copyWith(
                    color: SupportBotColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void _showRevertToHubspotPopup(BuildContext context, String message) {
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
