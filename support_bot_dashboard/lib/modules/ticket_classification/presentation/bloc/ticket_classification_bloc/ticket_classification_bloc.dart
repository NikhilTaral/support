import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/ticket_classification_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/usecases/common_ticket_classification_usecases.dart';

part 'ticket_classification_event.dart';
part 'ticket_classification_state.dart';

class TicketClassificationTabBloc
    extends Bloc<TicketClassificationEvent, TicketClassificationState> {
  TicketClassificationAttributeModel ticketClassificationAttributeModel =
      TicketClassificationAttributeModel();

  num page = 1;
  num pageSize = 10;
  String selectedBOPsState = "";
  String selectedClassification = "";
  String selectedValidation = "";
  String selectedPipelineId = "";
  DateTime? endDate = DateTime.now()
      .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
  DateTime? startDate =
      DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);

  TicketClassificationTabBloc() : super(TicketClassificationIntialState()) {
    on<TicketClassificationDataCallEvent>(_onTicketClassification);
  }

  FutureOr<void> _onTicketClassification(
      TicketClassificationDataCallEvent event,
      Emitter<TicketClassificationState> emit) async {
    emit(TicketClassificationLoadingState());
    selectedPipelineId = event.fieldValue?.first ?? "";
    try {
      final repository = serviceLocator<TicketClassificationUsecses>();
      endDate = event.endDate
          ?.copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
      startDate = event.startDate;
      ;
      final enddate = DateTime.now()
          .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
      final startdate = DateTime.now()
          .subtract(const Duration(days: 0))
          .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);

      page = event.page ?? 1;
      pageSize = event.pageSize ?? 10;
      final req = TicketClassificationRequestModel(
        startDate: (startDate ?? startdate),
        endDate: (endDate ?? enddate),
        page: event.page,
        ticketId: event.ticketId,
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
          Filter(fieldName: "pipelines", fieldValue: [selectedPipelineId]),
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
          page = model.data?.currentPage ?? 1;

          ticketClassificationAttributeModel =
              TicketClassificationAttributeModel(
            data: model.data,
            failCode: model.failCode,
            message: model.message,
            success: model.success,
          );

          emit(TicketClassificationSuccessState(
              currentIndex: 0,
              endDate: endDate,
              startDate: startDate,
              ticketClassificationAttributeModel:
                  ticketClassificationAttributeModel,
              pipelineId: [selectedPipelineId]));
        }
      }
    } catch (e) {
      emit(TicketClassificationFailureState());
    }
  }

  void clearFilters() {
    selectedBOPsState = "";
    selectedClassification = "";
    selectedValidation = "";
    selectedPipelineId = "";
  }
}
