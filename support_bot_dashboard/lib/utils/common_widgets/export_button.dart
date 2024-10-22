import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_answer/ai_query_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';

class ExportButton extends StatelessWidget {
  final String icon;
  final double iconSize;
  final String selectedButtonText;

  const ExportButton({
    Key? key,
    required this.icon,
    this.iconSize = 25.0,
    required this.selectedButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(right: 16),
      child: TextButton(
        onPressed: () async {
          if (selectedButtonText == 'Ticket Classification') {
            final state = BlocProvider.of<PlutotableBloc>(context).state;
            if (state is FetchTableDataSuccess) {
              _exportTicketClassificationToCsv(context, state.tableData!);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No table data available to export'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          } else if (selectedButtonText == 'AI Query Answer') {
            final state = BlocProvider.of<AiQueryAnswerBloc>(context).state;
            if (state is AiQueryAnswerSuccess) {
              _exportAiQueryDataToCsv(context, state.data);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No AI query data available to export'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
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

  void _exportTicketClassificationToCsv(
      BuildContext context, DashboardTableAttributeModel tableData) {
    List<List<dynamic>> rows = [];

    rows.add([
      'ID',
      'Ticket Description',
      'Classification',
      'Reasoning',
      'Validation',
      'Validation Reason',
      'Status',
      'Created At'
    ]);

    for (var item in tableData.items) {
      rows.add([
        item.id,
        item.ticketDescription,
        item.classification,
        item.reasoning,
        item.classificationValidation,
        item.classificationValidationReason
      ]);
    }

    _downloadCsv(rows, 'ticket_classification_data.csv');
  }

  void _exportAiQueryDataToCsv(
      BuildContext context, DashboardAiQueryAttributeModel aiQueryData) {
    List<List<dynamic>> rows = [];

    rows.add([
      'ID',
      'Ticket Description',
      'Classification',
      'AI Query Answer',
    ]);

    for (var item in aiQueryData.items) {
      rows.add([
        item.id,
        item.ticketDescription,
        item.aIResponse,
        item.answeredStatus,
      ]);
    }

    _downloadCsv(rows, 'ai_query_data.csv');
  }

  void _downloadCsv(List<List<dynamic>> rows, String filename) {
    String csv = const ListToCsvConverter().convert(rows);

    List<int> csvBytes = utf8.encode(csv);
    Uint8List csvUint8List = Uint8List.fromList(csvBytes);

    final blob = html.Blob([csvUint8List]);

    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();

    html.Url.revokeObjectUrl(url);
  }
}
