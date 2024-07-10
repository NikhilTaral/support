import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_response_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';

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
              state.columnNames.where((e) => e != 'ticketDescription').toList();
          return Column(
            children: [
              const SizedBox(height: 15),
              Padding(  
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: _calculateMaxHeight(data.length),
                  ),
                  child: PlutoGrid(
                    columns: filteredColumns
                        .where((e) => state.selectColumn.contains(e))
                        .toList()
                        .map(
                          (e) => PlutoColumn(
                            title: e,
                            field: e,
                            enableFilterMenuItem: false,
                            enableHideColumnMenuItem: false,
                            type: PlutoColumnType.text(),
                            textAlign: PlutoColumnTextAlign.start,
                            titlePadding: const EdgeInsets.all(8),
                            backgroundColor: const Color(0xFFE7E7E9),
                            enableContextMenu: false,
                            enableDropToResize: false,
                            enableEditingMode: false,
                            enableColumnDrag: false,
                            readOnly: true,
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
                        enableColumnBorderHorizontal: false,
                        enableColumnBorderVertical: true,
                        enableCellBorderVertical: true,
                        enableCellBorderHorizontal: true,
                        gridBorderRadius: BorderRadius.circular(8),
                        gridPopupBorderRadius: BorderRadius.circular(8),
                        rowHeight: 50,
                        columnHeight: 60,
                        gridBorderColor: Colors.transparent,
                        columnTextStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF232538),
                        ),
                        cellTextStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
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
      case 'createdAt':
        return dataModel.createdAt ?? "";
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

  double _calculateMaxHeight(int rowCount) {
    const double rowHeight = 45.0; 
    const double headerHeight = 56.0;
    const double padding = 16.0; 

    int visibleRowCount = rowCount > 6 ? 6 : rowCount;
    double totalHeight = visibleRowCount * rowHeight + headerHeight + padding;

    return totalHeight;
  }
}
