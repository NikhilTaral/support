import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/views/ticket_classification_pluto_table.dart';
import 'package:support_bot_dashboard/responsive.dart';

class TicketClassification extends StatelessWidget {
  const TicketClassification({super.key,this.endDate,this.pipelineName,this.piplineId,this.startDate});
final String? pipelineName;
  final String? piplineId;
  final DateTime? startDate;
  final DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: const SizedBox(),
        tablet: TicketClassificationPlutoTable(pipelineName: pipelineName ?? "",
            piplineId: piplineId,
            endDate: endDate ?? DateTime.now(),
            startDate: startDate ?? DateTime.now(),),
        desktop: TicketClassificationPlutoTable(),
      ),
    );
  }
}
