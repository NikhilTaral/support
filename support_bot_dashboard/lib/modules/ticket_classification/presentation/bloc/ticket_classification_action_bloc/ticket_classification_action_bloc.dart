import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_action_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_action_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/revert_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/ticket_classification_action_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/usecases/common_ticket_classification_usecases.dart';
import 'package:support_bot_dashboard/utils/log.dart';

part 'ticket_classification_action_event.dart';
part 'ticket_classification_action_state.dart';

class TicketClassificationActionBloc extends Bloc<
    TicketClassificationActionEvent, TicketClassificationActionState> {
  TicketClassificationActionAttributeModel?
      ticketClassificationActionAttributeModel =
      TicketClassificationActionAttributeModel();
  String id = '';
  String uId = '';

  TicketClassificationActionBloc() : super(RevertClassificationInitialState()) {
    on<RevertClassificationEvent>(_onRevertClassificationEvent);
    on<UpdateClassificationEvent>(_updateClassificationEvent);
  }

  FutureOr<void> _onRevertClassificationEvent(RevertClassificationEvent event,
      Emitter<TicketClassificationActionState> emit) async {
    emit(RevertClassificationLoadingState());
    try {
      id = event.ticketId ?? "";
      final repository = serviceLocator<RevertClassificationUsecase>();
      final req = id;
      final response = await repository.invoke(req);
      if (response.isLeft) {
        emit(RevertClassificationFailureState());
      } else {
        final model = response.right;
        final data = RevertAttributeModel(
          success: model.success,
        );
        emit(RevertClassificationSuccessState(model: data));
      }
    } catch (e) {
      emit(RevertClassificationFailureState());
    }
  }

  Future<void> _updateClassificationEvent(UpdateClassificationEvent event,
      Emitter<TicketClassificationActionState> emit) async {
    emit(UpdateClassificationLoadingState());

    try {
      uId = event.ticketId ?? "";
      final repository = serviceLocator<ActionUsecase>();
      TicketClassificationActionRequestModel req =
          TicketClassificationActionRequestModel(
        classification: event.classification ?? "",
        pipelineId: event.pipelineId ?? "",
        ticketId: uId,
      );

      final response = await repository.invoke(req);

      if (response.isLeft) {
        emit(UpdateClassificationFailureState());
      } else {
        final model = ticketClassificationActionResponsetModelFromJson(
            jsonEncode(response.right));
        ticketClassificationActionAttributeModel =
            TicketClassificationActionAttributeModel(
          data: ticketClassificationActionAttributeModel?.data?.copyWith(
            message: model.data?.message ?? "",
          ),
          success: model.success,
          message: model.message,
        );

        emit(UpdateClassificationSuccessState(
            ticketClassificationActionAttributeModel:
                ticketClassificationActionAttributeModel));
      }
    } catch (e) {
      Log.error("Caught error: $e");
      emit(UpdateClassificationFailureState());
    }
  }
}
