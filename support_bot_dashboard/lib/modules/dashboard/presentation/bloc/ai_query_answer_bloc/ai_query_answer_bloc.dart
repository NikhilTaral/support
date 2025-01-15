import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_ai_query_chart_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_Initial_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_chart_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_ai_query_answer.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';

part 'ai_query_answer_event.dart';
part 'ai_query_answer_state.dart';

DashboardDataModel dashboardDataModel = DashboardDataModel();

class AiQueryAnswerBloc extends Bloc<AiQueryAnswerEvent, AiQueryAnswerState> {
  AiQueryAnswerBloc() : super(AIQueryAnswerIntialState()) {
    on<AIQueryAnswerInitialEvent>(_aIQueryAnswerInitialEvent);
  }

  FutureOr<void> _aIQueryAnswerInitialEvent(
      AIQueryAnswerInitialEvent event, Emitter<AiQueryAnswerState> emit) async {
    emit(AIQueryAnswerLoadingState());
    try {
      final repository = serviceLocator<DashboardAiQueryAnswerUsecase>();
      List<DateTime?> datesList = await getSelectedDates();

      final req = DashboardAnswerDataInitialRequestModel(
        filter: [
          if (event.selectedDate != null)
            Filter(
                fieldValue: event.selectedPipelineValue ?? ["11257490"],
                fieldName: "StartDate"),
          Filter(
              fieldValue: event.selectedPipelineValue ?? ["11257490"],
              fieldName: event.fieldName ?? "pipelines")
        ],
        startDate: (datesList.firstOrNull ?? DateTime.now())
            .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)
            .toIso8601String(),
        endDate: (datesList.lastOrNull ?? DateTime.now())
            .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999)
            .toIso8601String(),
      );
      final response = await repository.invoke(req);
      if (response.isLeft) {
        emit(AIQueryAnswerFailureState(
          message: response.toString(),
          selectedDate: event.selectedDate ?? DateTime.now(),
          selectedMonth: event.selectedMonth ?? DateTime.now(),
        ));
      } else {
        final DashboardAiQueryChartResponseModel model = response.right;

        if (model.success == true && model.data != null) {
          dashboardDataModel = (dashboardDataModel ?? DashboardDataModel())
              .copyWith(
                  dashboardAiQueryChartAttributeModel:
                      (dashboardDataModel.dashboardAiQueryChartAttributeModel ??
                              DashboardAiQueryChartAttributeModel())
                          .copyWith(
                              data: (dashboardDataModel
                                          .dashboardAiQueryChartAttributeModel
                                          ?.data ??
                                      AiQueryData())
                                  .copyWith(
            counts: (dashboardDataModel
                        .dashboardAiQueryChartAttributeModel?.data?.counts ??
                    AiQueryDataCounts())
                .copyWith(
              answered: model.data?.counts?.answeredCount,
              notAnswered: model.data?.counts?.notAnsweredCount,
            ),
            percentages: (dashboardDataModel.dashboardAiQueryChartAttributeModel
                        ?.data?.percentages ??
                    AiQueryDataCounts())
                .copyWith(
              answered: model.data?.percentages?.answeredCount,
              notAnswered: model.data?.percentages?.notAnsweredCount,
            ),
          )));
          bool isEmpty = dashboardDataModel
                      .dashboardAiQueryChartAttributeModel?.data?.counts ==
                  null &&
              dashboardDataModel
                      .dashboardAiQueryChartAttributeModel?.data?.percentages ==
                  null;
          if (isEmpty) {
            emit(AIQueryAnswerEmptyState());
          } else {
            emit(AIQueryAnswerSucssesState(
                dashboardDataModel: dashboardDataModel));
          }
        } else {
          emit(AIQueryAnswerFailureState(
              message: 'Exception: ',
              selectedDate: event.selectedDate ?? DateTime.now(),
              selectedMonth: event.selectedMonth ?? DateTime.now()));
        }
      }
    } catch (e) {
      emit(AIQueryAnswerFailureState(
          message: 'Exception: $e',
          selectedDate: event.selectedDate ?? DateTime.now(),
          selectedMonth: event.selectedMonth ?? DateTime.now()));
    }
  }

  Future<List<DateTime?>> getSelectedDates() async {
    return await LocalStorage.getSelectedDates();
  }
}
