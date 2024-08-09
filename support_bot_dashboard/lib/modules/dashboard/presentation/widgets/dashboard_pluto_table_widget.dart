import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/revert_classification/revert_classification_bloc.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_sidebar.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class PlutoTableWidget extends StatelessWidget {
  final DashboardTableAttributeModel tableData;
  final DateTime selectedMonth;
  final DateTime selectedDate;

  const PlutoTableWidget(
      {Key? key,
      required this.tableData,
      required this.selectedMonth,
      required this.selectedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UIHelpers.verticalSpaceTiny,
        Padding(
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
                  width: UIHelpers.screenWidth(context) * 0.2,
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
                  title: S.of(context).classification,
                  field: 'classification',
                  width: UIHelpers.screenWidth(context) * 0.18,
                  type: PlutoColumnType.text(),
                  enableFilterMenuItem: true,
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
                  title: S.of(context).reasoning,
                  field: 'reasoning',
                  width: UIHelpers.screenWidth(context) * 0.2,
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
                PlutoColumn(
                  title: S.of(context).validation,
                  field: 'validation',
                  width: UIHelpers.screenWidth(context) * 0.15,
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
                  readOnly: false,
                  renderer: (PlutoColumnRendererContext _) {
                    return ValidationReasonRenderer(
                      rowID: _.row.cells['id']?.value ?? "",
                      plutotableBloc: context.read<PlutotableBloc>(),
                      date: selectedDate,
                      month: selectedMonth,
                      row: _.row,
                    );
                  },
                ),
                PlutoColumn(
                  title: S.of(context).validationReason,
                  field: 'validation_reason',
                  width: UIHelpers.screenWidth(context) * 0.15,
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
                 PlutoColumn(
                  title: S.of(context).status,
                  field: 'status',
                  type: PlutoColumnType.text(),
                  width: UIHelpers.screenWidth(context) * 0.13,
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
              rows: tableData.items.map((item) {
                return PlutoRow(
                  cells: {
                    'id': PlutoCell(value: item.id),
                    'classification': PlutoCell(value: item.classification),
                    'reasoning': PlutoCell(value: item.reasoning),
                    'ticketDescription':
                        PlutoCell(value: item.ticketDescription),
                    'validation':
                        PlutoCell(value: item.classificationValidation),
                    'validation_reason':
                        PlutoCell(value: item.classificationValidationReason),
                    'isUpdatedToHubspot':
                        PlutoCell(value: item.isUpdatedToHubspot),
                     'status': PlutoCell(value: item.isUpdatedToHubspot == true ? "updated" : "not updated"),
                    'actions': PlutoCell(value: 'View'),
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
}

class ValidationReasonRenderer extends StatefulWidget {
  final String rowID;
  final PlutotableBloc plutotableBloc;
  final DateTime date;
  final DateTime month;
  final PlutoRow row;

  const ValidationReasonRenderer({
    Key? key,
    required this.rowID,
    required this.plutotableBloc,
    required this.date,
    required this.month,
    required this.row,
  }) : super(key: key);

  @override
  ValidationReasonRendererState createState() =>
      ValidationReasonRendererState();
}

class ValidationReasonRendererState extends State<ValidationReasonRenderer> {
  late String _selectedValue;
  late String _previousValue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _reason = '';

  @override
  void initState() {
    super.initState();
    _selectedValue =
        _validateValue(widget.row.cells['validation']?.value ?? 'Select');
    _previousValue = _selectedValue;
  }

  String _validateValue(String value) {
    const validValues = ['Select', 'correct', 'incorrect'];
    if (!validValues.contains(value)) {
      return 'Select';
    }
    return value;
  }

  void _showPopup(String rowId) {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return BlocProvider.value(
          value: context.read<PlutotableBloc>(),
          child: AlertDialog(
            title: Text(S.of(context).emailValidations),
            backgroundColor: SupportBotColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: SizedBox(
              width: UIHelpers.screenWidth(context) * 0.3,
              height: UIHelpers.screenHeight(context) * 0.2,
              child: BlocConsumer<PlutotableBloc, PlutotableState>(
                listener: (context, state) {
                  if (state is UpdateValidationSuccess) {
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  if (state is UpdateValidationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            _reason = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).comments;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: S.of(context).comments,
                            contentPadding: const EdgeInsets.all(16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          maxLines: 4,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SupportBotColors.danger,
                      foregroundColor: SupportBotColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 40),
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedValue = _previousValue;
                        widget.row.cells['validation']!.value = _selectedValue;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      S.of(context).cancel,
                      style: SupportBotTextstyle.hint.copyWith(
                        color: SupportBotColors.white,
                      ),
                    ),
                  ),
                  UIHelpers.horizontalSpaceRegular,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SupportBotColors.bluePrimary,
                      foregroundColor: SupportBotColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 40),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String validationStatus = _selectedValue;
                        context
                            .read<PlutotableBloc>()
                            .add(UpdateValidationEvent(
                              id: rowId,
                              validation: validationStatus,
                              reason: _reason,
                              selectedDate: widget.date,
                              selectedMonth: widget.month,
                            ));
                      }
                    },
                    child: Text(
                      S.of(context).save,
                      style: SupportBotTextstyle.hint.copyWith(
                        color: SupportBotColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String rowId = widget.rowID;

    return Column(
      children: [
        Flexible(
          child: SizedBox(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedValue,
              items: [
                DropdownMenuItem<String>(
                  value: 'Select',
                  child: Text(
                    'Select',
                    style: SupportBotTextstyle.hint.copyWith(
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      color: SupportBotColors.gray.shade700,
                    ),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'correct',
                  child: Text(
                    'Correct',
                    style: SupportBotTextstyle.hint.copyWith(
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      color: SupportBotColors.black,
                    ),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'incorrect',
                  child: Text(
                    'Incorrect',
                    style: SupportBotTextstyle.hint.copyWith(
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      color: SupportBotColors.black,
                    ),
                  ),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _previousValue = _selectedValue;
                  _selectedValue = newValue!;
                  widget.row.cells['validation']!.value = _selectedValue;
                  if (_selectedValue == 'incorrect') {
                    _showPopup(rowId);
                  } else {
                    context.read<PlutotableBloc>().add(UpdateValidationEvent(
                          id: rowId,
                          validation: _selectedValue,
                          reason: '',
                          selectedDate: widget.date,
                          selectedMonth: widget.month,
                        ));
                  }
                });
              },
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              iconSize: 30,
              iconEnabledColor: SupportBotColors.gray.shade800,
              iconDisabledColor: SupportBotColors.gray.shade800,
              underline: const SizedBox.shrink(),
              dropdownColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

Widget actionsRenderer(PlutoColumnRendererContext rendererContext) {
  final id = rendererContext.row.cells['id']?.value ?? "";
  final rows = rendererContext.stateManager.refRows.toList();
  final currentIndex = rows.indexOf(rendererContext.row);
  final isUpdatedToHubspot =
      rendererContext.row.cells['isUpdatedToHubspot']?.value ?? true;
  final classification =
      rendererContext.row.cells['classification']?.value ?? "";
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
              PopupMenuItem<String>(
                value: S.of(context).revert,
                child: InkWell(
                  onTap: () {
                    print(isUpdatedToHubspot);
                    if( classification == 'Spam/Marketing'){
                      if (!isUpdatedToHubspot) {
                      serviceLocator<RevertClassificationBloc>().add(
                        RevertClassificationInitialEvent(ticketId: id),
                      );
                      _showUpdatedToHubspotPopup(
                          context, S.of(context).revertSuccess);
                      }
                      else{
                        _showUpdatedToHubspotPopup(
                          context, S.of(context).alreadyUpdated);
                      }
                    
                    } else {
                      _showUpdatedToHubspotPopup(
                          context, S.of(context).revertClassifcation);
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



