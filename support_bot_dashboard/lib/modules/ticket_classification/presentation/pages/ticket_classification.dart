import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/views/ticket_classification_pluto_table.dart';
import 'package:support_bot_dashboard/responsive.dart';

class TicketClassification extends StatelessWidget {
  const TicketClassification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: const SizedBox(),
        tablet: TicketClassificationPlutoTable(),
        desktop: TicketClassificationPlutoTable(),
      ),
    );
  }
}
