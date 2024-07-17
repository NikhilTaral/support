/////////////////////dropdown popup////////////////////////////////

// import 'package:flutter/material.dart';
// import 'package:pluto_grid/pluto_grid.dart';
// import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
// import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
// import 'package:support_bot_dashboard/utils/theme/colors.dart';
// import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
// import 'package:support_bot_dashboard/utils/ui_helpers.dart';

// class PlutoTableWidget extends StatelessWidget {
//   final DashboardTableAttributeModel tableData;

//   const PlutoTableWidget({Key? key, required this.tableData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         UIHelpers.verticalSpaceTinySmall,
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               maxHeight: _calculateMaxHeight(tableData.items.length),
//             ),
//             child: PlutoGrid(
//               columns: [
//                 PlutoColumn(
//                   title: 'ID',
//                   field: 'id',
//                   type: PlutoColumnType.text(),
//                   enableFilterMenuItem: false,
//                   enableHideColumnMenuItem: false,
//                   textAlign: PlutoColumnTextAlign.start,
//                   titlePadding: const EdgeInsets.all(8),
//                   backgroundColor: SupportBotColors.blueSecondary.shade100,
//                   enableContextMenu: false,
//                   enableDropToResize: false,
//                   enableEditingMode: false,
//                   enableColumnDrag: false,
//                   readOnly: true,
//                 ),
//                 PlutoColumn(
//                   title: 'Created At',
//                   field: 'createdAt',
//                   type: PlutoColumnType.date(),
//                   enableFilterMenuItem: false,
//                   enableHideColumnMenuItem: false,
//                   textAlign: PlutoColumnTextAlign.start,
//                   titlePadding: const EdgeInsets.all(8),
//                   backgroundColor: SupportBotColors.blueSecondary.shade100,
//                   enableContextMenu: false,
//                   enableDropToResize: false,
//                   enableEditingMode: false,
//                   enableColumnDrag: false,
//                   readOnly: true,
//                 ),
//                 PlutoColumn(
//                   title: 'Pipeline Stage',
//                   field: 'hSPipelineStage',
//                   type: PlutoColumnType.text(),
//                   enableFilterMenuItem: false,
//                   enableHideColumnMenuItem: false,
//                   textAlign: PlutoColumnTextAlign.start,
//                   titlePadding: const EdgeInsets.all(8),
//                   backgroundColor: SupportBotColors.blueSecondary.shade100,
//                   enableContextMenu: false,
//                   enableDropToResize: false,
//                   enableEditingMode: false,
//                   enableColumnDrag: false,
//                   readOnly: true,
//                 ),
//                 PlutoColumn(
//                   title: 'Ticket Description',
//                   field: 'ticketDescription',
//                   type: PlutoColumnType.text(),
//                   enableFilterMenuItem: false,
//                   enableHideColumnMenuItem: false,
//                   textAlign: PlutoColumnTextAlign.start,
//                   titlePadding: const EdgeInsets.all(8),
//                   backgroundColor: SupportBotColors.blueSecondary.shade100,
//                   enableContextMenu: false,
//                   enableDropToResize: false,
//                   enableEditingMode: false,
//                   enableColumnDrag: false,
//                   readOnly: true,
//                   renderer: (PlutoColumnRendererContext context) {
//                     final value = context.cell.value ?? '';
//                     return MouseRegion(
//                       cursor: SystemMouseCursors.click,
//                       child: CustomToolTip(
//                         message: value.toString(),
//                         width: 200,
//                         toolTipDirection: CustomToolTip.toolTipRight,
//                         isMobile: false,
//                         child: Text(
//                           value.toString(),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 PlutoColumn(
//                   title: 'Classification',
//                   field: 'classification',
//                   type: PlutoColumnType.text(),
//                   enableFilterMenuItem: false,
//                   enableHideColumnMenuItem: false,
//                   textAlign: PlutoColumnTextAlign.start,
//                   titlePadding: const EdgeInsets.all(8),
//                   backgroundColor: SupportBotColors.blueSecondary.shade100,
//                   enableContextMenu: false,
//                   enableDropToResize: false,
//                   enableEditingMode: false,
//                   enableColumnDrag: false,
//                   readOnly: true,
//                 ),
//                 PlutoColumn(
//                   title: 'Reasoning',
//                   field: 'reasoning',
//                   type: PlutoColumnType.text(),
//                   enableFilterMenuItem: false,
//                   enableHideColumnMenuItem: false,
//                   textAlign: PlutoColumnTextAlign.start,
//                   titlePadding: const EdgeInsets.all(8),
//                   backgroundColor: SupportBotColors.blueSecondary.shade100,
//                   enableContextMenu: false,
//                   enableDropToResize: false,
//                   enableEditingMode: false,
//                   enableColumnDrag: false,
//                   readOnly: true,
//                   renderer: (PlutoColumnRendererContext context) {
//                     final value = context.cell.value ?? '';
//                     return MouseRegion(
//                       cursor: SystemMouseCursors.click,
//                       child: CustomToolTip(
//                         message: value.toString(),
//                         width: 200,
//                         toolTipDirection: CustomToolTip.toolTipRight,
//                         isMobile: false,
//                         child: Text(
//                           value.toString(),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 PlutoColumn(
//                   title: 'Validation',
//                   field: 'validation',
//                   type: PlutoColumnType.text(),
//                   enableFilterMenuItem: false,
//                   enableHideColumnMenuItem: false,
//                   textAlign: PlutoColumnTextAlign.start,
//                   titlePadding: const EdgeInsets.all(8),
//                   backgroundColor: SupportBotColors.blueSecondary.shade100,
//                   enableContextMenu: false,
//                   enableDropToResize: false,
//                   enableEditingMode: true,
//                   enableColumnDrag: false,
//                   readOnly: false,
//                 ),
//                 PlutoColumn(
//                   title: 'Status',
//                   field: 'status',
//                   type: PlutoColumnType.text(),
//                   enableFilterMenuItem: false,
//                   enableHideColumnMenuItem: false,
//                   textAlign: PlutoColumnTextAlign.start,
//                   titlePadding: const EdgeInsets.all(8),
//                   backgroundColor: SupportBotColors.blueSecondary.shade100,
//                   enableContextMenu: false,
//                   enableDropToResize: false,
//                   enableEditingMode: true,
//                   enableColumnDrag: false,
//                   readOnly: false,
//                   renderer: (PlutoColumnRendererContext context) {
//                     return ValidationReasonRenderer(context: context);
//                   },
//                 ),
//               ],
//               rows: tableData.items.map((item) {
//                 return PlutoRow(
//                   cells: {
//                     'id': PlutoCell(value: item.id),
//                     'classification': PlutoCell(value: item.classification),
//                     'hSPipelineStage': PlutoCell(value: item.hsPipelineStage),
//                     'reasoning': PlutoCell(value: item.reasoning),
//                     'createdAt': PlutoCell(value: item.createdAt),
//                     'ticketDescription': PlutoCell(value: item.ticketDescription),
//                     'validation': PlutoCell(value: 'N/A'),
//                     'validation_reason': PlutoCell(value: ''),
//                   },
//                 );
//               }).toList(),
//               configuration: PlutoGridConfiguration(
//                 style: PlutoGridStyleConfig(
//                   enableColumnBorderHorizontal: false,
//                   enableColumnBorderVertical: true,
//                   enableCellBorderVertical: true,
//                   enableCellBorderHorizontal: true,
//                   gridBorderRadius: BorderRadius.circular(8),
//                   gridPopupBorderRadius: BorderRadius.circular(8),
//                   rowHeight: 50,
//                   columnHeight: 50,
//                   gridBorderColor: Colors.transparent,
//                   columnTextStyle: SupportBotTextstyle.columnHeading,
//                   cellTextStyle: SupportBotTextstyle.cellHeading,
//                   enableGridBorderShadow: true,
//                 ),
//                 columnSize: const PlutoGridColumnSizeConfig(
//                   autoSizeMode: PlutoAutoSizeMode.scale,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   double _calculateMaxHeight(int itemCount) {
//     const double rowHeight = 25;
//     const double headerHeight = 30;
//     const double maxVisibleRows = 10;
//     const double paddingHeight = 30;
//     if (itemCount <= maxVisibleRows) {
//       return rowHeight * itemCount + headerHeight + paddingHeight;
//     } else {
//       return rowHeight * maxVisibleRows + headerHeight + paddingHeight;
//     }
//   }
// }

// class ValidationReasonRenderer extends StatefulWidget {
//   final PlutoColumnRendererContext context;

//   const ValidationReasonRenderer({Key? key, required this.context}) : super(key: key);

//   @override
//   _ValidationReasonRendererState createState() => _ValidationReasonRendererState();
// }

// class _ValidationReasonRendererState extends State<ValidationReasonRenderer> {
//   String _selectedValue = 'Correct';
//   String _comment = '';
//   bool _showCommentField = false;

//   void _showPopup() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           elevation: 0.0,
//           backgroundColor: Colors.transparent,
//           child: StatefulBuilder(
//             builder: (context, setState) {
//               return Container(
//                 width: UIHelpers.screenWidth(context) * 0.2,
//                 padding: EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'Email Validation',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18.0,
//                       ),
//                     ),
//                     SizedBox(height: 16.0),
//                     DropdownButton<String>(
//                       value: _selectedValue,
//                       items: ['Correct', 'Incorrect'].map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedValue = newValue!;
//                           _showCommentField = (_selectedValue == 'Incorrect');
//                         });
//                       },
//                     ),
//                     SizedBox(height: 16.0),
//                     if (_showCommentField)
//                       TextField(
//                         decoration: InputDecoration(
//                           labelText: 'Enter Comment',
//                           hintText: 'Type your comment here...',
//                           border: OutlineInputBorder(),
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             _comment = value;
//                           });
//                         },
//                       ),
//                     SizedBox(height: 16.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         TextButton(
//                           child: Text('Cancel'),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         SizedBox(width: 8.0),
//                         ElevatedButton(
//                           child: Text('Save'),
//                           onPressed: () {
//                             print('Selected Value: $_selectedValue');
//                             print('Comment: $_comment');
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final stateManager = widget.context.stateManager;
//     final cell = widget.context.cell;

//     return IconButton(
//       icon: Icon(Icons.more_vert_rounded),
//       onPressed: _showPopup,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
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

  const PlutoTableWidget({Key? key, required this.tableData, required this.selectedMonth, required this.selectedDate}) : super(key: key);

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
                  readOnly: true,
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
                PlutoColumn(
                  title: 'Status',
                  field: 'status',
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
                      plutotableBloc: BlocProvider.of<PlutotableBloc>(context),
                      date: selectedDate,
                      month: selectedMonth
                    );
                  },
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
                    'status': PlutoCell(value: ''),
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

  const ValidationReasonRenderer(
      {Key? key, required this.rowID, required this.plutotableBloc, required this.date, required this.month})
      : super(key: key);

  @override
  _ValidationReasonRendererState createState() =>
      _ValidationReasonRendererState();
}

class _ValidationReasonRendererState extends State<ValidationReasonRenderer> {
  String _selectedValue = 'Select';

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
                  widget.plutotableBloc.add(UpdateValidationEvent(
                      id: rowId, validation: validationStatus, reason: reason,selectedDate: widget.date, selectedMonth: widget.month ));
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
                  if (_selectedValue == 'incorrect') {
                    _showPopup(rowId);
                  } else {
                    context.read<PlutotableBloc>().add(UpdateValidationEvent(
                        id: rowId, validation: _selectedValue, reason: '', selectedDate: widget.date, selectedMonth: widget.month));
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
