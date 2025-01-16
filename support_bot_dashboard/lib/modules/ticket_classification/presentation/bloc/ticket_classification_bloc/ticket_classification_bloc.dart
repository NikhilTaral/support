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

  TicketClassificationTabBloc() : super(TicketClassificationIntialState()) {
    on<TicketClassificationDataCallEvent>(_onTicketClassification);
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
      final validation = await LocalStorage.getValidation();
      final piplineid = await LocalStorage.getPipeline();

      final req = TicketClassificationRequestModel(
        startDate: (datesList.firstOrNull ?? DateTime.parse("2024-10-23")),
        endDate: (datesList.lastOrNull ?? DateTime.now()),
        page: event.page,
        pageSize: event.pageSize,
        filter: [
          Filter(
              fieldName: "BOPS_States",
              fieldValue: bopsState != null ? [bopsState] : []),
          Filter(
              fieldName: "classifications",
              fieldValue: classification != null ? [classification] : []),
          Filter(
              fieldName: "validations",
              fieldValue: validation != null ? [validation] : []),
          Filter(
              fieldValue: event.fieldValue ?? ["11257490"],
              fieldName: event.fieldName ?? "pipelines")
        ],
      );

      final response = await repository.invoke(req);
      print("NIKHIL left ${response.isRight}");
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
          emit(TicketClassificationSucssesState(
              model: ticketClassificationEntitieModel));
        }
      }
    } catch (e) {
      print("NIKHIL $e");
      emit(TicketClassificationFailureState());
    }
  }
}

Future<List<DateTime?>> getSelectedDates() async {
  final dates = await LocalStorage.getSelectedDates();
  return dates;
}
