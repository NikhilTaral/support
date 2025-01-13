import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';

class TicketClassificationPlutoGrideWidget extends StatelessWidget {
  final List<PlutoColumn> columns = [
    PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'ID',
        field: 'id',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false),
    PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'Ticket Description',
        field: 'ticket_description',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false),
    PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'BOps State',
        field: 'bops_state',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false),
    PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'Classification',
        field: 'classification',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false),
    PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'Validation',
        field: 'validation',
        type: PlutoColumnType.select(['Select']),
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false),
    PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false),
    PlutoColumn(
        backgroundColor: SupportBotColors.disablePrimary.shade100,
        title: 'Action',
        field: 'action',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableAutoEditing: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableDropToResize: false),
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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: constraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PlutoGrid(
                columns: columns,
                rows: rows,
                configuration: const PlutoGridConfiguration(
                  columnSize: PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.equal,
                  ),
                  style: PlutoGridStyleConfig(
                    gridBorderColor: SupportBotColors.gray,
                    enableGridBorderShadow: false,
                    enableCellBorderVertical: false,
                    gridBorderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8)),
                    columnHeight: 44,
                    rowHeight: 52,
                    columnTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    cellTextStyle: TextStyle(fontSize: 13),
                  ),
                ),
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  event.stateManager.setShowColumnFilter(false);
                },
                onChanged: (PlutoGridOnChangedEvent event) {},
              ),
            ),
          ),
        ],
      );
    });
  }
}
