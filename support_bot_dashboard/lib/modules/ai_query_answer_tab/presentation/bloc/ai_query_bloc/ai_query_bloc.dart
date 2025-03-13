import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/data/model/ai_query_answer_response_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/domain/entities/ai_query_answer_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/domain/entities/data_module.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/domain/usecases/ai_query_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_request_model.dart';
import 'package:support_bot_dashboard/utils/service/instance_sharing_service.dart';

part 'ai_query_event.dart';
part 'ai_query_state.dart';

class AiQueryBloc extends Bloc<AiQueryEvent, AiQueryState> {
  AiQueryAttributeModel? aiQueryAttributeModel;
  AiQueryEvent? lastEvent;
  DataModule? dataModule;
  String? piplineID = "";
  String? piplineName;
  num page = 1;
  num pageSize = 10;
  DateTime? endDate;
  String? classificationFilterValue;
  DateTime? startDate;
  AiQueryBloc() : super(AIQueryInitialState()) {
    on<AIQueryInitialEvent>(_aIQueryInitialEvent);
  }

  FutureOr<void> _aIQueryInitialEvent(
      AIQueryInitialEvent event, Emitter<AiQueryState> emit) async {
    emit(AIQueryLoadingState());
    try {
      classificationFilterValue = event.classificationFilterValue;
      startDate = event.startDate;
      endDate = event.endDate;
      piplineID = event.selectedPipelineValueList;
      final repository = serviceLocator<AiQueryUsecase>();
      serviceLocator<InstanceSharingService>().selectedPipelineValueList =
          event.selectedPipelineValueList;
      serviceLocator<InstanceSharingService>().endDate = event.endDate;
      serviceLocator<InstanceSharingService>().startDate = event.startDate;

      final req = DashboardAnswerDataInitialRequestModel(
        filter: [
          Filter(fieldValue: [piplineID ?? ""], fieldName: "pipelines"),
          if (event.classificationFilterValue?.isNotEmpty == true ||
              event.classificationFilterValue != null)
            Filter(fieldValue: [
              (classificationFilterValue?.toLowerCase() == "answered")
                  .toString()
            ], fieldName: "answeredStatus"),
        ],
        page: event.page ?? 1,
        pageSize: event.pageSize ?? 10,
        startDate: startDate
            ?.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)
            .toIso8601String(),
        endDate: endDate
            ?.copyWith(hour: 23, minute: 59, second: 59, millisecond: 999)
            .toIso8601String(),
      );
      final response = await repository.invoke(req);
      if (response.isLeft) {
        emit(AIQueryFailureState());
      } else {
        final AiQueryResponseModel model =
            AiQueryResponseModel.fromJson(response.right);
        if (model.success == true && model.data != null) {
          if (model.data?.items?.isEmpty == true) {
            emit(AIQueryEmptyState());
          } else {
            page = model.data?.currentPage ?? 1;
            aiQueryAttributeModel = mapResponseToAttributeModel(model);

            emit(AIQuerySuccessState(
                dashboardDataModel: aiQueryAttributeModel,
                endDate: startDate,
                startDate: endDate,
                selectedPipelineValue: piplineID));
          }
        } else {
          emit(AIQueryEmptyState());
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
}
