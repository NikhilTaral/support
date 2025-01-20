import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/ticket_classification_entitie_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/repositories/common_ticket_classification_repository.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/usecases/common_ticket_classification_usecases.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';

part 'ticket_classification_event.dart';
part 'ticket_classification_state.dart';

class TicketClassificationTabBloc
    extends Bloc<TicketClassificationEvent, TicketClassificationState> {
  TicketClassificationEntitieModel ticketClassificationEntitieModel =
      TicketClassificationEntitieModel();

  num page = 1;
  num pageSize = 10;

  TicketClassificationTabBloc() : super(TicketClassificationIntialState()) {
    on<TicketClassificationDataCallEvent>(_onTicketClassification);
    on<RevertClassificationEvent>(_onRevertClassificationEvent);
  }

  FutureOr<void> _onTicketClassification(
      TicketClassificationDataCallEvent event,
      Emitter<TicketClassificationState> emit) async {
    emit(TicketClassificationLoadingState());

    try {
      final repository = serviceLocator<TicketClassificationUsecses>();
      List<DateTime?> datesList = await getSelectedDates();
      final bopsState = await LocalStorage.getBopsState();
      final classification = await LocalStorage.getClassification();
      String? validation = await LocalStorage.getValidation();
      final piplineids = await LocalStorage.getPipelineIds();
      if (validation?.replaceAll(" ", "").toLowerCase() == "notvalidated") {
        validation = "";
      }
      page = event.page ?? 1;
      pageSize = event.pageSize ?? 10;
      final req = TicketClassificationRequestModel(
        startDate: (datesList.firstOrNull ?? DateTime.parse("2024-10-23")),
        endDate: (datesList.lastOrNull ?? DateTime.now()),
        page: event.page,
        pageSize: event.pageSize,
        filter: [
          if (event.fieldValue?.isNotEmpty == true && event.fieldValue != null)
            Filter(
                fieldName: "BOPS_States",
                fieldValue: bopsState != null ? [bopsState] : []),
          Filter(
              fieldName: "classifications",
              fieldValue: classification != null ? [classification] : []),
          Filter(
              fieldName: "classificationValidations",
              fieldValue: validation != null ? [validation] : []),
          Filter(
              fieldValue: piplineids,
              fieldName: event.fieldName ?? "pipelines")
        ],
      );

      final response = await repository.invoke(req);

      if (response.isLeft) {
        emit(TicketClassificationFailureState());
      } else {
        final TicketClassificationResponseModel model =
            TicketClassificationResponseModel.fromJson(response.right);

        if (model.data?.items?.isEmpty == true && model.success == true) {
          emit(TicketClassificationEmptyState());
        } else {
          ticketClassificationEntitieModel = TicketClassificationEntitieModel(
            data: model.data,
            failCode: model.failCode,
            message: model.message,
            params: model.params,
            success: model.success,
          );

          final pipelineId = await LocalStorage.getPipelineIds();

          emit(TicketClassificationSucssesState(
              model: ticketClassificationEntitieModel, pipelineId: pipelineId));
        }
      }
    } catch (e) {
      emit(TicketClassificationFailureState());
    }
  }

  FutureOr<void> _onRevertClassificationEvent(RevertClassificationEvent event,
      Emitter<TicketClassificationState> emit) async {
    emit(RevertClassificationLoadingState(
        model: ticketClassificationEntitieModel));
    try {
      final repository = serviceLocator<RevertClassificationUsecase>();

      final req = event.ticketId ?? "";
      final response = await repository.invoke(req);
      if (response.isLeft) {
        emit(RevertClassificationFailureState(
            errorMsg: "Failed To revert classification",
            model: ticketClassificationEntitieModel));
      } else {
        emit(RevertClassificationSucessState(
            model: ticketClassificationEntitieModel));
      }
    } catch (e) {
      emit(RevertClassificationFailureState(
          errorMsg: "Failed To revert classification",
          model: ticketClassificationEntitieModel));
    }
  }
}

Future<List<DateTime?>> getSelectedDates() async {
  final dates = await LocalStorage.getSelectedDates();

  return dates;
}
