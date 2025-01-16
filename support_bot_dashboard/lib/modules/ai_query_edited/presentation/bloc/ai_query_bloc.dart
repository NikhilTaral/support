import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/data/model/ai_query_answer_response_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/domain/entities/ai_query_answer_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/domain/usecases/ai_query_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_Initial_request_model.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';

part 'ai_query_event.dart';
part 'ai_query_state.dart';

class AiQueryBloc extends Bloc<AiQueryEvent, AiQueryState> {
  AiQueryEvent? lastEvent;

  AiQueryAttributeModel? aiQueryAttributeModel;
  AiQueryBloc() : super(AIQueryInitialState()) {
    on<AIQueryInitialEvent>(_aIQueryInitialEvent);
  }

  FutureOr<void> _aIQueryInitialEvent(
      AIQueryInitialEvent event, Emitter<AiQueryState> emit) async {
    lastEvent = event;
    emit(AIQueryLoadingState());
    try {
      final repository = serviceLocator.get<AiQueryUsecase>();
      List<DateTime?> datesList = await getSelectedDates();
      final req = DashboardAnswerDataInitialRequestModel(
        filter: [
          if (event.startDate != null && event.endDate != null)
            Filter(
                fieldValue: event.selectedPipelineValue ?? ["11257490"],
                fieldName: "StartDate"),
          Filter(
              fieldValue: event.selectedPipelineValue ?? ["11257490"],
              fieldName: "pipelines"),
          Filter(
              fieldValue: event.selectedPipelineValue ?? ["11257490"],
              fieldName: event.classificationFilterValue ?? "answeredStatus")
        ],
        page: event.page,
        pageSize: event.pageSize,
        startDate: (datesList.firstOrNull ?? DateTime.now())
            .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)
            .toIso8601String(),
        endDate: (datesList.lastOrNull ?? DateTime.now())
            .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999)
            .toIso8601String(),
      );
      final response = await repository.invoke(req);
      if (response.isLeft) {
        emit(AIQueryFailureState());
      } else {
        final AiQueryResponseModel model =
            AiQueryResponseModel.fromJson(response.right);
        if (model.success == true && model.data != null) {
          aiQueryAttributeModel = mapResponseToAttributeModel(model);
        }
        if (aiQueryAttributeModel?.data?.items?.isEmpty == true) {
          emit(AIQueryEmptyState());
        } else {
          emit(AIQuerySuccessState(dashboardDataModel: aiQueryAttributeModel));
        }
      }
    } catch (e) {
      emit(AIQueryFailureState());
    }
  }

  AiQueryAttributeModel mapResponseToAttributeModel(
      AiQueryResponseModel response) {
    return AiQueryAttributeModel(
      data: response.data != null
          ? AiQueryAttributeData(
              totalRecords: response.data?.totalRecords,
              items: response.data?.items
                  ?.map((item) => AiQueryAttributeItem(
                        id: item.id ?? "",
                        createdAt: item.createdAt ?? "",
                        ticketDescription: item.ticketDescription ?? "",
                        aiResponse: item.aiResponse ?? "",
                        answeredStatus: item.answeredStatus,
                        isAnswerEdited: item.isAnswerEdited,
                        agentAnsValidation: item.agentAnsValidation,
                        answerValidationReason:
                            item.answerValidationReason ?? "",
                      ))
                  .toList(),
              pageSize: response.data?.pageSize,
              currentPage: response.data?.currentPage,
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
