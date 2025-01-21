import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/ticket_classification_entitie_model.dart';
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
  String selectedBOPsState = "";
  String selectedClassification = "";
  String selectedValidation = "";
  String selectedPipelineId = "11257490";

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

      final endDate = DateTime.now();
      final startDate = endDate.subtract(const Duration(days: 1));
      page = event.page ?? 1;
      pageSize = event.pageSize ?? 10;
      final req = TicketClassificationRequestModel(
        startDate: (event.startDate ?? startDate),
        endDate: (event.endDate ?? DateTime.now()),
        page: event.page,
        pageSize: event.pageSize,
        filter: [
          if (selectedBOPsState != "")
            Filter(fieldName: "BOPS_States", fieldValue: [selectedBOPsState]),
          if (selectedClassification != "")
            Filter(
                fieldName: "classifications",
                fieldValue: [selectedClassification]),
          if (selectedValidation != "")
            Filter(
                fieldName: "classificationValidations",
                fieldValue: [selectedValidation]),
          Filter(
            fieldName: "pipelines",
            fieldValue: [
              selectedPipelineId.isEmpty ? "11257490" : selectedPipelineId
            ],
          )
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
              currentIndex: 0,
              model: ticketClassificationEntitieModel,
              pipelineId: pipelineId));
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
