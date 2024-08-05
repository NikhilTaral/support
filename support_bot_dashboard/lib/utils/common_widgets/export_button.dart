import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';

class ExportButton extends StatelessWidget {
  final String icon;
  final double iconSize;

  const ExportButton({
    Key? key,
    required this.icon,
    this.iconSize = 25.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      padding: const EdgeInsets.only(right: 16), 
      child: TextButton(
        onPressed: () async {
          final state = BlocProvider.of<PlutotableBloc>(context).state;
          if (state is FetchTableDataSuccess) {
            _exportTableDataToCsv(context, state.tableData);
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Report Downloaded'),
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No table data available to export'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        child: SvgPicture.asset(
          icon,
          width: iconSize,
          height: iconSize,
        ),
      ),
    );
  }

  void _exportTableDataToCsv(BuildContext context, DashboardTableAttributeModel tableData) {
    List<List<dynamic>> rows = [];

    rows.add(['ID', 'Ticket Description', 'Classification', 'Pipeline Stage', 'Reasoning', 'Created At']);

    for (var item in tableData.items) {
      rows.add([
        item.id,
        item.ticketDescription,
        item.classification,
        item.hsPipelineStage,
        item.reasoning,
        item.createdAt,
      ]);
    }

    String csv = const ListToCsvConverter().convert(rows);

    List<int> csvBytes = utf8.encode(csv);
    Uint8List csvUint8List = Uint8List.fromList(csvBytes);

    final blob = html.Blob([csvUint8List]);

    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)..setAttribute('download', 'table_data.csv')..click(); 

    html.Url.revokeObjectUrl(url);
  }
}
