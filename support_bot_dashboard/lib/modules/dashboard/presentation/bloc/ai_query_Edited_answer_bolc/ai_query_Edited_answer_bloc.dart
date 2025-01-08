import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_ai_query_chart_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_Initial_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_chart_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_ai_query_chart_usecase.dart';

part 'ai_query_Edited_answer_event.dart';
part 'ai_query_Edited_answer_state.dart';
late DashboardDataModel dashboardDataModel = DashboardDataModel();

class AiQueryEditedAnswerBloc
    extends Bloc<AiQueryEditedAnswerEvent, AiQueryEditedAnswerState> {
  AiQueryEditedAnswerBloc() : super(AIQueryEditedAnswerIntialState()) {
    on<AIQueryEditedAnswerCallEvent>(_onFichAiQueryChartData);
  }

  FutureOr<void> _onFichAiQueryChartData(AIQueryEditedAnswerCallEvent event,
      Emitter<AiQueryEditedAnswerState> emit) async {
    emit(AIQueryEditedAnswerLoadingState());
    try {
      final repository = await serviceLocator<DashboardAiQueryChartUsecase>();
      final req = DashboardChartDataInitialRequestModel(
        filter: [
          Filter(
              fieldValue: [event.selectedPipelineValue ?? "11257490"],
              fieldName: event.fildName ?? "pipelines")
        ],
        startDate: (event.selectedDate ?? DateTime.parse("2024-12-31"))
            .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)
            .toIso8601String(),
        endDate: (event.selectedMonth ?? DateTime.now())
            .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999)
            .toIso8601String(),
      );
      final responce = await repository.invoke(req);
      if (responce.isLeft) {
        emit(AIQueryEditedAnswerFailureState(
          message: responce.toString(),
          selectedDate: event.selectedDate ?? DateTime.now(),
          selectedMonth: event.selectedMonth ?? DateTime.now(),
        ));
      } else {
        final DashboardAiQueryChartResponseModel model = responce.right;

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

          emit(AIQueryEditedAnswerSucssesState(dashboardDataModel: dashboardDataModel));
        } else {
          emit(AIQueryEditedAnswerFailureState(
              message: 'Exception: ',
              selectedDate: event.selectedDate ?? DateTime.now(),
              selectedMonth: event.selectedMonth ?? DateTime.now()));
        }
      }
    } catch (e) {
      emit(AIQueryEditedAnswerFailureState(
          message: 'Exception: $e',
          selectedDate: event.selectedDate ?? DateTime.now(),
          selectedMonth: event.selectedMonth ?? DateTime.now()));
    }
  }
}
