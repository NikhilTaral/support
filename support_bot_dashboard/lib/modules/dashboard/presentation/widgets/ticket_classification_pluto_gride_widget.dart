import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class TicketClassificationPlutoGrideWidget extends StatelessWidget {
  final List<PlutoColumn> columns = [
    PlutoColumn(
      title: 'ID',
      field: 'id',
      type: PlutoColumnType.text(),
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'Ticket Description',
      field: 'ticket_description',
      type: PlutoColumnType.text(),
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'BOps State',
      field: 'bops_state',
      type: PlutoColumnType.text(),
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'Classification',
      field: 'classification',
      type: PlutoColumnType.text(),
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'Validation',
      field: 'validation',
      type: PlutoColumnType.select(['Select']),
    ),
    PlutoColumn(
      title: 'Status',
      field: 'status',
      type: PlutoColumnType.text(),
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'Action',
      field: 'action',
      type: PlutoColumnType.text(),
      enableEditingMode: false,
    ),
  ];

  final List<PlutoRow> rows = List.generate(
    10,
    (index) => PlutoRow(
      cells: {
        'id': PlutoCell(value: '16992663878'),
        'ticket_description': PlutoCell(value: 'Plus 9 more homes we ...'),
        'bops_state': PlutoCell(value: 'California'),
        'classification': PlutoCell(value: 'N/A'),
        'validation': PlutoCell(value: 'Select'),
        'status': PlutoCell(value: 'Not Updated'),
        'action': PlutoCell(value: '...'),
      },
    ),
  );

  TicketClassificationPlutoGrideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PlutoGrid(
          columns: columns,
          rows: rows,
          configuration: PlutoGridConfiguration(
            columnSize: PlutoGridColumnSizeConfig(
              autoSizeMode: PlutoAutoSizeMode.none,
            ),
            style: PlutoGridStyleConfig(
              enableGridBorderShadow: false,
              columnHeight: 50,
              rowHeight: 50,
              gridBorderColor: Colors.grey.shade300,
              columnTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              cellTextStyle: const TextStyle(fontSize: 13),
            ),
          ),
          onLoaded: (PlutoGridOnLoadedEvent event) {
            event.stateManager.setShowColumnFilter(false);
          },
          onChanged: (PlutoGridOnChangedEvent event) {},
        ),
      ),
    );
  }
}

//// this is Hard Coded Pluto girde for TicketClassification bcos of API is Not avalabel
