import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_action_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_action_responce_model.dart';
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
    print('Event received: ${event.toString()}');

    emit(TicketClassificationActionLoadingState());
    print('State: TicketClassificationActionLoadingState');

    try {
      final piplineid = await LocalStorage.getPipelineIds();

      print('Pipeline ID: $piplineid');

      final repository = serviceLocator<ActionUsecase>();
      print('Repository obtained: $repository');

      TicketClassificationActionRequestModel req =
          TicketClassificationActionRequestModel(
        classification: event.classification ?? "",
        pipelineId: piplineid.join(','),
        ticketId: event.ticketId ?? "",
      );
      print('Request model created: ${req.toJson()}');

      final response = await repository.invoke(req);
      print('Response received: $response');

      if (response is Left) {
        print('Left response: ${response.left}');
        emit(TicketClassificationActionFailureState());
        final TicketClassificationActionResponsetModel model =
            TicketClassificationActionResponsetModel.fromJson(response.right);
        print('Response Model: ${model.toJson()}');

        ticketClassificationActionEntitietModel =
            TicketClassificationActionEntitietModel(
                data: ticketClassificationActionEntitietModel?.data?.copyWith(
                  message: model.data.message,
                ),
                success: model.success,
                message: model.message);

        print(
            'TicketClassificationActionEntitietModel updated: ${ticketClassificationActionEntitietModel?.toString()}');

        emit(TicketClassificationActionSucssesState(
            ticketClassificationActionEntitietModel:
                ticketClassificationActionEntitietModel));
      } else {
        print('No Left response');
      }
    } catch (e) {
      print('Error occurred: $e');
      emit(TicketClassificationActionFailureState());
    }
  }
}
