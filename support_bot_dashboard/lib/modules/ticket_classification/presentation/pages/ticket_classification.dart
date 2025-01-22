import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/views/ticket_classification_pluto_table.dart';
import 'package:support_bot_dashboard/responsive.dart';

class TicketClassification extends StatelessWidget {
  const TicketClassification({super.key});

  @override
  Widget build(BuildContext context) {
    final endDate = DateTime.now()
        .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
    final startDate = endDate
        .subtract(const Duration(days: 1))
        .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);

    context.read<TicketClassificationTabBloc>().add(
          TicketClassificationDataCallEvent(
            fieldValue: ['11257490'],
            startDate: startDate,
            endDate: endDate,
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
