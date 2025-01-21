import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/views/ticket_classification_pluto_table.dart';
import 'package:support_bot_dashboard/responsive.dart';

class TicketClassification extends StatelessWidget {
  const TicketClassification({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TicketClassificationTabBloc>().add(
          TicketClassificationDataCallEvent(
            fieldValue: ['11257490'],
            startDate: DateTime.now().subtract(const Duration(days: 1)),
            endDate: DateTime.now(),
            page: BlocProvider.of<TicketClassificationTabBloc>(context).page,
            pageSize:
                BlocProvider.of<TicketClassificationTabBloc>(context).pageSize,
          ),
        );
    return Scaffold(
      body: Responsive(
        mobile: const SizedBox(),
        tablet: TicketClassificationPlutoTable(),
        desktop: TicketClassificationPlutoTable(),
      ),
    );
  }
}
