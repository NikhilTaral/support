// import 'dart:typed_data';

// import 'package:file_saver/file_saver.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:multiselect/multiselect.dart';
// import 'package:pluto_grid/pluto_grid.dart';
// import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_response_data_model.dart';
// import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
// import 'package:csv/csv.dart';

// class PlutoTableWidget extends StatelessWidget {
//   const PlutoTableWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DashboardBloc, DashboardState>(
//       builder: (context, state) {
//         if (state is DashboardDataSuccess) {
//           final data = state.data;
//           final selectedColumns = state.selectedColumns;
//           return Column(
//             children: [
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(
//                       width: 200,
//                       child: DropDownMultiSelect(
//                         onChanged: (List<String> selected) {
//                           context.read<DashboardBloc>().add(SelectDropdownEvent(
//                                 selectedColumns: selected,
//                                 columnNames: state.columnNames,
//                                 data: state.data,
//                               ));
//                         },
//                         options: state.columnNames,
//                         decoration: const InputDecoration(
//                           labelStyle: TextStyle(fontSize: 16),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                         ),
//                         selectedValues: state.selectedColumns,
//                         whenEmpty: 'Select Columns',
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           foregroundColor: Colors.white),
//                       onPressed: () {
//                         _exportToCsv(selectedColumns, data);
//                       },
//                       child: const Text('Export'),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 15),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 3,
//                 child: PlutoGrid(
//                   columns: state.columnNames
//                       .where((e) => selectedColumns.contains(e))
//                       .toList()
//                       .map(
//                         (e) => PlutoColumn(
//                           title: e,
//                           field: e,
//                           type: PlutoColumnType.text(),
//                           textAlign: PlutoColumnTextAlign.start,
//                           titlePadding: const EdgeInsets.all(8),
//                         ),
//                       )
//                       .toList(),
//                   rows: data.map((dataModel) {
//                     return PlutoRow(
//                       cells: Map.fromEntries(
//                         selectedColumns.map(
//                           (column) => MapEntry(
//                             column,
//                             PlutoCell(
//                               value: _getCellValue(dataModel, column),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                   configuration: PlutoGridConfiguration(
//                     style: PlutoGridStyleConfig(
//                       enableColumnBorderHorizontal: true,
//                       enableColumnBorderVertical: true,
//                       enableCellBorderVertical: true,
//                       enableCellBorderHorizontal: true,
//                       evenRowColor: const Color(0xFFF6F6F6),
//                       gridBorderRadius: BorderRadius.circular(8),
//                       gridPopupBorderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         } else if (state is DashboardDataLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is DashboardDataEmpty) {
//           return const Center(
//             child: Text('Empty Data'),
//           );
//         } else if (state is DashboardDataFailure) {
//           return Center(child: Text(state.errorMsg));
//         } else {
//           return Container();
//         }
//       },
//     );
//   }

//   String _getCellValue(
//       DashboardResponseDataModel dataModel, String columnName) {
//     switch (columnName) {
//       case 'id':
//         return dataModel.id?.toString() ?? "";
//       case 'classification':
//         return dataModel.classification ?? "";
//       case 'createdAt':
//         return dataModel.createdAt ?? "";
//       case 'hsPipelineStage':
//         return dataModel.hsPipelineStage?.toString() ?? "";
//       case 'reasoning':
//         return dataModel.reasoning ?? "";
//       case 'ticketDescription':
//         return dataModel.ticketDescription ?? "";
//       default:
//         return '';
//     }
//   }

//   void _exportToCsv(
//       List<String> selectedColumns, List<DashboardResponseDataModel> data) {
//     List<List<String>> csvData = [
//       selectedColumns, // Headers
//       ...data.map((dataModel) =>
//           selectedColumns.map((col) => _getCellValue(dataModel, col)).toList())
//     ];

//     String csv = const ListToCsvConverter().convert(csvData);
//     Uint8List bytes = Uint8List.fromList(csv.codeUnits);

//     FileSaver.instance.saveFile(
//       name: "dashboard_data",
//       bytes: bytes,
//       ext: "csv",
//       mimeType: MimeType.csv,
//     );
//   }
// }

import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_response_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/column_selection_dropdown.dart';

class PlutoTableWidget extends StatelessWidget {
  const PlutoTableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardDataSuccess) {
          final data = state.data;
          final selectedColumns = state.selectedColumns;
          final temporarySelectedColumns =
              state.temporarySelectedColumns ?? selectedColumns;

          return Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColumnSelectionDropdown(
                      initialSelectedColumns: temporarySelectedColumns,
                      columnNames: state.columnNames,
                      selectedColumns: temporarySelectedColumns,
                      onSelectionChanged: (List<String> newSelectedColumns) {
                        context.read<DashboardBloc>().add(
                              SelectDropdownEvent(
                                selectedColumns: newSelectedColumns,
                                columnNames: state.columnNames,
                                data: state.data,
                              ),
                            );
                      },
                      onApply: () {
                        context.read<DashboardBloc>().add(
                              ApplyColumnsEvent(
                                selectedColumns: temporarySelectedColumns,
                                columnNames: state.columnNames,
                                data: state.data,
                              ),
                            );
                      },
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        _exportToCsv(selectedColumns, data);
                      },
                      child: const Text('Export'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: PlutoGrid(
                  columns: state.columnNames
                      .where((e) => selectedColumns.contains(e))
                      .toList()
                      .map(
                        (e) => PlutoColumn(
                          title: e,
                          field: e,
                          type: PlutoColumnType.text(),
                          textAlign: PlutoColumnTextAlign.start,
                          titlePadding: const EdgeInsets.all(8),
                        ),
                      )
                      .toList(),
                  rows: data.map((dataModel) {
                    return PlutoRow(
                      cells: Map.fromEntries(
                        selectedColumns.map(
                          (column) => MapEntry(
                            column,
                            PlutoCell(
                              value: _getCellValue(dataModel, column),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  configuration: PlutoGridConfiguration(
                    style: PlutoGridStyleConfig(
                      enableColumnBorderHorizontal: true,
                      enableColumnBorderVertical: true,
                      enableCellBorderVertical: true,
                      enableCellBorderHorizontal: true,
                      evenRowColor: const Color(0xFFF6F6F6),
                      gridBorderRadius: BorderRadius.circular(8),
                      gridPopupBorderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is DashboardDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DashboardDataEmpty) {
          return const Center(
            child: Text('Empty Data'),
          );
        } else if (state is DashboardDataFailure) {
          return Center(child: Text(state.errorMsg));
        } else {
          return Container();
        }
      },
    );
  }

  String _getCellValue(
      DashboardResponseDataModel dataModel, String columnName) {
    switch (columnName) {
      case 'id':
        return dataModel.id?.toString() ?? "";
      case 'classification':
        return dataModel.classification ?? "";
      case 'createdAt':
        return dataModel.createdAt ?? "";
      case 'hsPipelineStage':
        return dataModel.hsPipelineStage?.toString() ?? "";
      case 'reasoning':
        return dataModel.reasoning ?? "";
      case 'ticketDescription':
        return dataModel.ticketDescription ?? "";
      default:
        return '';
    }
  }

  void _exportToCsv(
      List<String> selectedColumns, List<DashboardResponseDataModel> data) {
    List<List<String>> csvData = [
      selectedColumns, // Headers
      ...data.map((dataModel) =>
          selectedColumns.map((col) => _getCellValue(dataModel, col)).toList())
    ];

    String csv = const ListToCsvConverter().convert(csvData);
    Uint8List bytes = Uint8List.fromList(csv.codeUnits);

    FileSaver.instance.saveFile(
      name: "dashboard_data",
      bytes: bytes,
      ext: "csv",
      mimeType: MimeType.csv,
    );
  }
}
