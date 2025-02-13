import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_ai_query_edited_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_initial_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_edited_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_ai_query_edited.dart';
part 'ai_query_edited_event.dart';
part 'ai_query_edited_state.dart';

class AiQueryEditedBloc extends Bloc<AiQueryEditedEvent, AiQueryEditedState> {
  List<String>? selectedPipelineId = ["11257490"];
  AiQueryEditedBloc() : super(AIQueryEditedIntialState()) {
    on<AIQueryEditedInitialEvent>(_aIQueryEditedInitialEvent);
  }

  FutureOr<void> _aIQueryEditedInitialEvent(
      AIQueryEditedInitialEvent event, Emitter<AiQueryEditedState> emit) async {
    emit(AIQueryEditedLoadingState());
    final repository = serviceLocator.get<DashboardAiQueryEditedUsecase>();
    final req = DashboardAnswerDataInitialRequestModel(
      filter: [
        Filter(
            fieldValue: event.selectedPipelineValue ?? ["11257490"],
            fieldName: event.fieldName ?? "pipelines")
      ],
      startDate: (event.startDate ?? DateTime.now())
          .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)
          .toIso8601String(),
      endDate: (event.endDate ?? DateTime.now())
          .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999)
          .toIso8601String(),
    );
    final response = await repository.invoke(req);
    if (response.isLeft) {
      emit(AIQueryEditedFailureState());
    } else {
      try {
        final responseModel = dashboardAiQueryEditedResponseModelFromJson(
            jsonEncode(response.right).toString());
        final attributeModel = mapResponseToAttributeModel(responseModel);
        if (attributeModel.data?.counts == null &&
            attributeModel.data?.percentages == null) {
          emit(AIQueryEditedEmptyState());
        } else {
          emit(AIQueryEditedSucssesState(
              dashboardAiQueryEditedAttributeModel: attributeModel));
        }
      } catch (e) {
        emit(AIQueryEditedFailureState());
      }
    }
  }

  DashboardAiQueryEditedAttributeModel mapResponseToAttributeModel(
      DashboardAiQueryEditedResponseModel response) {
    return DashboardAiQueryEditedAttributeModel(
      data: response.data != null
          ? AiQueryEditedData(
              counts: response.data?.counts != null
                  ? AiQueryEditedCounts(
                      editedCount: response.data?.counts?.editedCount ?? 0,
                      unEditedCount: response.data?.counts?.unEditedCount ?? 0,
                    )
                  : null,
              percentages: response.data?.percentages != null
                  ? AiQueryEditedCounts(
                      editedCount: response.data?.percentages?.editedCount ?? 0,
                      unEditedCount:
                          response.data?.percentages?.unEditedCount ?? 0,
                    )
                  : null,
            )
          : null,
      success: response.success,
      failCode: response.failCode,
      message: response.message,
    );
  }
}
