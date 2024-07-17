import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';
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
                  title: 'Created At',
                  field: 'createdAt',
                  type: PlutoColumnType.date(),
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
                  title: 'Ticket Description',
                  field: 'ticketDescription',
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
                        width: 200,
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
                  renderer: (PlutoColumnRendererContext context) {
                    final value = context.cell.value ?? '';
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: CustomToolTip(
                        message: value.toString(),
                        width: 200,
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
                  title: 'Validation',
                  field: 'validation',
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
                      plutotableBloc: serviceLocator<PlutotableBloc>(),
                      date: selectedDate,
                      month: selectedMonth,
                      row: _.row,
                    );
                  },
                ),
                PlutoColumn(
                  title: 'Validation_Reason',
                  field: 'validation_reason',
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
                    'ticketDescription':
                        PlutoCell(value: item.ticketDescription),
                    'validation':
                        PlutoCell(value: item.classificationValidation),
                    'validation_reason':
                        PlutoCell(value: item.classificationValidationReason),
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
  _ValidationReasonRendererState createState() =>
      _ValidationReasonRendererState();
}

class _ValidationReasonRendererState extends State<ValidationReasonRenderer> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue =
        _validateValue(widget.row.cells['validation']?.value ?? 'Select');
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
        String reason = '';

        return BlocProvider.value(
          value: context.read<PlutotableBloc>(),
          child: AlertDialog(
            title: const Text('Email Validation Details',
                style: TextStyle(fontSize: 20)),
            content: SizedBox(
              width: UIHelpers.screenWidth(context) * 0.4,
              height: UIHelpers.screenHeight(context) * 0.3,
              child: BlocConsumer<PlutotableBloc, PlutotableState>(
                listener: (context, state) {
                  if (state is UpdateValidationSuccess) {
                    Navigator.of(context).pop();
                    context.read<PlutotableBloc>().add(FetchTableDataEvent(
                        selectedDate: widget.date,
                        selectedMonth: widget.month));
                  }
                },
                builder: (context, state) {
                  if (state is UpdateValidationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        onChanged: (value) {
                          reason = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your comments here',
                          contentPadding: const EdgeInsets.all(16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        maxLines: 5,
                      ),
                    ],
                  );
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  String validationStatus = _selectedValue;
                  context.read<PlutotableBloc>().add(UpdateValidationEvent(
                      id: rowId,
                      validation: validationStatus,
                      reason: reason,
                      selectedDate: widget.date,
                      selectedMonth: widget.month));
                },
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
            width: 120,
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedValue,
              items: [
                DropdownMenuItem<String>(
                  value: 'Select',
                  child: Text('Select',
                      style: TextStyle(color: Colors.grey.shade400)),
                ),
                const DropdownMenuItem<String>(
                  value: 'correct',
                  child: Text('Correct'),
                ),
                const DropdownMenuItem<String>(
                  value: 'incorrect',
                  child: Text('Incorrect'),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
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
                        selectedMonth: widget.month));
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
