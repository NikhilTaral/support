import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/ticket_classification_entitie_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/widgets/ticket_classification_pluto_gride_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class TicketClassificationPlutoTable extends StatelessWidget {
  const TicketClassificationPlutoTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketClassificationTabBloc, TicketClassificationState>(
      builder: (context, state) {
        debugPrint("********************* state ${state.runtimeType}");
        if (state is TicketClassificationLoadingState) {
          return Center(
              child: LoadingWidget(
            height: UIHelpers.screenHeight(context),
            width: UIHelpers.screenWidth(context),
          ));
        }
        if (state is TicketClassificationSucssesState) {
          return TicketClassificationPlutoGrideWidget(
            plutoKey: UniqueKey(),
            ticketClassificationEntitieModel:
                state.model ?? TicketClassificationEntitieModel(),
          );
        }
        if (state is TicketClassificationFailureState) {
          return const Center(child: Text('Failed to load data.'));
        }
        if (state is TicketClassificationEmptyState) {
          return const Center(child: Text('No data1 Found.'));
        }
        return const Center(child: Text('No data Found.'));
      },
    );
  }
}
