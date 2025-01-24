import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/data/model/ai_query_answer_response_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/domain/entities/ai_query_answer_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/domain/entities/data_module.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/domain/usecases/ai_query_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_Initial_request_model.dart';
import 'package:support_bot_dashboard/utils/service/instance_sharing_service.dart';

part 'ai_query_event.dart';
part 'ai_query_state.dart';

class AiQueryBloc extends Bloc<AiQueryEvent, AiQueryState> {
  AiQueryAttributeModel? aiQueryAttributeModel;
  AiQueryEvent? lastEvent;
  DataModule? dataModule;
  List<String>? piplineID;
  int page = 1;
  num pageSize = 10;
  DateTime endDate = DateTime.now()
      .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
  DateTime startDate = DateTime.now()
      .subtract(const Duration(days: 0))
      .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
  AiQueryBloc() : super(AIQueryInitialState()) {
    on<AIQueryInitialEvent>(_aIQueryInitialEvent);
  }

  FutureOr<void> _aIQueryInitialEvent(
      AIQueryInitialEvent event, Emitter<AiQueryState> emit) async {
    emit(AIQueryLoadingState());
    try {
      final enddate = event.endDate
          ?.copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
      final startdate = event.startDate
              ?.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0),
          endDate = enddate ??
              DateTime.now()
                  .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
      startDate = startdate ?? startDate;
      piplineID = event.selectedPipelineValueList;
      final repository = serviceLocator<AiQueryUsecase>();
      serviceLocator<InstanceSharingService>().selectedPipelineValueList =
          event.selectedPipelineValueList;

      final req = DashboardAnswerDataInitialRequestModel(
        filter: [
          Filter(fieldValue: piplineID ?? ["11257490"], fieldName: "pipelines"),
          if (event.classificationFilterValue?.isNotEmpty == true ||
              event.classificationFilterValue != null)
            Filter(fieldValue: [
              (event.classificationFilterValue?.toLowerCase() == "answered")
                  .toString()
            ], fieldName: "answeredStatus"),
        ],
        page: event.page ?? 1,
        pageSize: event.pageSize ?? 10,
        startDate: startDate.toIso8601String(),
        endDate: endDate.toIso8601String(),
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
                endDate: enddate,
                startDate: startdate,
                selectedPipelineValue: piplineID));
          }
        } else {
          emit(AIQueryEmptyState());
        }
      }
    } catch (e, s) {
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
