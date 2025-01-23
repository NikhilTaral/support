import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_ai_query_edited_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_Initial_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_edited_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_ai_query_edited.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';

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
    List<DateTime?> datesList = await getSelectedDates();
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 1));
    final req = DashboardAnswerDataInitialRequestModel(
      filter: [
        Filter(
            fieldValue: selectedPipelineId ?? ["11257490"],
            fieldName: "StartDate"),
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
                      editedCount: response.data?.counts?.editedCount,
                      unEditedCount: response.data?.counts?.unEditedCount,
                    )
                  : null,
              percentages: response.data?.percentages != null
                  ? AiQueryEditedCounts(
                      editedCount: response.data?.percentages?.editedCount,
                      unEditedCount: response.data?.percentages?.unEditedCount,
                    )
                  : null,
            )
          : null,
      success: response.success,
      failCode: response.failCode,
      message: response.message,
    );
  }

  Future<List<DateTime?>> getSelectedDates() async {
    return await LocalStorage.getSelectedDates();
  }
}
