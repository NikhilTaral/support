import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_ai_query_chart_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_initial_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_chart_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_ai_query_answer.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/user_validation_bloc/user_validation_bloc.dart';

part 'ai_query_answer_event.dart';
part 'ai_query_answer_state.dart';

class AiQueryAnswerBloc extends Bloc<AiQueryAnswerEvent, AiQueryAnswerState> {
  List<String>? selectedPipelineId = [""];
  AiQueryAnswerBloc() : super(AIQueryAnswerIntialState()) {
    on<AIQueryAnswerInitialEvent>(_aIQueryAnswerInitialEvent);
  }
  FutureOr<void> _aIQueryAnswerInitialEvent(
      AIQueryAnswerInitialEvent event, Emitter<AiQueryAnswerState> emit) async {
    emit(AIQueryAnswerLoadingState());
    try {
      selectedPipelineId = event.selectedPipelineValue ?? [""];
      final repository = serviceLocator<DashboardAiQueryAnswerUsecase>();
      final req = DashboardAnswerDataInitialRequestModel(
        filter: [
          Filter(
              fieldValue: selectedPipelineId ?? [""],
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
        emit(AIQueryAnswerFailureState(
        
        ));
      } else {
        final DashboardAiQueryChartResponseModel model = response.right;
        if (model.success == true && model.data != null) {
          dashboardDataModel = DashboardDataModel(
            dashboardAiQueryChartAttributeModel:
                DashboardAiQueryChartAttributeModel(
              data: model.data != null
                  ? AiQueryData(
                      counts: model.data?.counts != null
                          ? AiQueryDataCounts(
                              answered: model.data?.counts?.answeredCount ?? 0,
                              notAnswered:
                                  model.data?.counts?.notAnsweredCount ?? 0,
                            )
                          : null,
                      percentages: model.data?.percentages != null
                          ? AiQueryDataCounts(
                              answered:
                                  model.data?.percentages?.answeredCount ?? 0,
                              notAnswered:
                                  model.data?.percentages?.notAnsweredCount ??
                                      0,
                            )
                          : null,
                    )
                  : null,
            ),
          );
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
         
          ));
        }
      }
    } catch (e) {
      emit(AIQueryAnswerFailureState(
       
      ));
    }
  }
}
