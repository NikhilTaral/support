import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_action_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_action_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/ticket_classification_Action_entitie_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/usecases/common_ticket_classification_usecases.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';

part 'ticket_classification_action_event.dart';
part 'ticket_classification_action_state.dart';

class TicketClassificationActionBloc extends Bloc<
    TicketClassificationActionEvent, TicketClassificationActionState> {
  TicketClassificationActionEntitietModel?
      ticketClassificationActionEntitietModel =
      TicketClassificationActionEntitietModel();
  TicketClassificationActionBloc()
      : super(TicketClassificationActionIntialState()) {
    on<TicketClassificationActionOnEvent>(_onTicketClassificationActionOnEvent);
  }

  Future<void> _onTicketClassificationActionOnEvent(
      TicketClassificationActionOnEvent event,
      Emitter<TicketClassificationActionState> emit) async {
    emit(TicketClassificationActionLoadingState());
    try {
      final piplineid = await LocalStorage.getPipelineIds();
      final repository = serviceLocator<ActionUsecase>();
      TicketClassificationActionRequestModel req =
          TicketClassificationActionRequestModel(
        classification: event.classification ?? "",
        pipelineId: piplineid.join(','),
        ticketId: event.ticketId ?? "",
      );
      final response = await repository.invoke(req);
      if (response.isLeft) {
        emit(TicketClassificationActionFailureState());
      } else {
        final model = ticketClassificationActionResponsetModelFromJson(
            jsonEncode(response.right));
        ticketClassificationActionEntitietModel =
            TicketClassificationActionEntitietModel(
                data: ticketClassificationActionEntitietModel?.data?.copyWith(
                  message: model.data?.message ?? "",
                ),
                success: model.success,
                message: model.message);
        emit(TicketClassificationActionSucssesState(
            ticketClassificationActionEntitietModel:
                ticketClassificationActionEntitietModel));
      }
    } catch (e, s) {
      emit(TicketClassificationActionFailureState());
    }
  }
}
