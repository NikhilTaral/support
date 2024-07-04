import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_response_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:csv/csv.dart';

class PlutoTableWidget extends StatelessWidget {
  const PlutoTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardDataSuccess) {
          final data = state.data
              .where((d) => d.classification == state.selectedClassification)
              .toList();
          final filteredColumns =
              state.columnNames.where((e) => e != 'createdAt').toList();
          return Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<String>(
                      value: state.selectedClassification,
                      onChanged: (String? newValue) {
                        context.read<DashboardBloc>().add(SelectDropdownEvent(
                              selectedClassification: newValue!,
                              columnNames: state.columnNames,
                              data: state.data,
                            ));
                      },
                      items: ['Spam', 'No Action Required', 'Genuine']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text('Select Classification'),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF003865),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          _exportToCsv(state.selectColumn, data);
                        },
                        child: const Text('Export'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: PlutoGrid(
                    columns: filteredColumns
                        .where((e) => state.selectColumn.contains(e))
                        .toList()
                        .map(
                          (e) => PlutoColumn(
                            title: e,
                            field: e,
                            type: PlutoColumnType.text(),
                            textAlign: PlutoColumnTextAlign.start,
                            titlePadding: const EdgeInsets.all(8),
                            backgroundColor: Colors.grey.shade300,
                            enableContextMenu: false,
                          ),
                        )
                        .toList(),
                    rows: data.map((dataModel) {
                      return PlutoRow(
                        cells: Map.fromEntries(
                          state.selectColumn.map(
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
                        enableColumnBorderVertical: false,
                        enableCellBorderVertical: false,
                        enableCellBorderHorizontal: true,
                        evenRowColor: const Color(0xFFF6F6F6),
                        gridBorderRadius: BorderRadius.circular(8),
                        gridPopupBorderRadius: BorderRadius.circular(8),
                      ),
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
      selectedColumns,
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
