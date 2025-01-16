import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/ticket_classification_entitie_model.dart';
import 'package:support_bot_dashboard/utils/common_widgets/pluto_table_widget.dart';
import 'package:support_bot_dashboard/utils/report_utils.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class TicketClassificationPlutoGrideWidget extends StatefulWidget {
  const TicketClassificationPlutoGrideWidget({
    super.key,
    required this.plutoKey,
    required this.ticketClassificationEntitieModel,
  });

  final UniqueKey plutoKey;
  final TicketClassificationEntitieModel ticketClassificationEntitieModel;

  @override
  State<TicketClassificationPlutoGrideWidget> createState() =>
      _TicketClassificationPlutoGrideWidgetState();
}

class _TicketClassificationPlutoGrideWidgetState
    extends State<TicketClassificationPlutoGrideWidget> {
  late ReportUtils reportUtils;
  late List<PlutoRow> _rows;
  late List<PlutoColumn> _columns;

  final plutoGridConfiguration = PlutoGridConfiguration(
    style: PlutoGridStyleConfig(
      columnContextIcon: Icons.more_vert_outlined,
      iconSize: 0,
      inactivatedBorderColor: Colors.transparent,
      activatedColor: Colors.transparent,
      enableColumnBorderHorizontal: false,
      enableColumnBorderVertical: false,
      enableCellBorderVertical: false,
      enableGridBorderShadow: false,
      enableCellBorderHorizontal: true,
      gridBorderColor: Colors.transparent,
      gridBackgroundColor: Colors.transparent,
      rowHeight: 48,
      columnTextStyle: SupportBotTextstyle.small.copyWith(
        fontWeight: FontWeight.w500,
        color: const Color(0xFF545454),
      ),
      gridBorderRadius: BorderRadius.circular(6),
      activatedBorderColor: Colors.transparent,
    ),
    columnFilter: PlutoGridColumnFilterConfig(
      filters: const [
        ...FilterHelper.defaultFilters,
      ],
      resolveDefaultColumnFilter: (column, resolver) {
        return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
      },
    ),
  );

  PlutoGridStateManager? stateManager;

  @override
  void initState() {
    super.initState();

    try {
      reportUtils = ReportUtils(
        context: context,
        ticketClassificationEntitieModel:
            widget.ticketClassificationEntitieModel,
      );

      _rows = reportUtils.createTicketClassificationRow();
      _columns = reportUtils.createTicketClassificationColumn(context: context);
    } catch (e, stackTrace) {
      _rows = [];
      _columns = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlutoTableWidget(
      columns: _columns,
      rows: _rows,
    );
    //     PlutoGrid(
    //   key: widget.plutoKey,
    //   mode: PlutoGridMode.selectWithOneTap,
    //   configuration: plutoGridConfiguration,
    //   onLoaded: (event) {
    //     stateManager = event.stateManager;
    //   },
    //   columns: _columns,
    //   rows: _rows,
    // );
  }
}
