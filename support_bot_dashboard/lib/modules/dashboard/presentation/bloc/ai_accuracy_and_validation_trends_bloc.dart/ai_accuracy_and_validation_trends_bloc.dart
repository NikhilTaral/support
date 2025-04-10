import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/ai_accuracy_and_validation_trends_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/ai_accuracy_and_validation_trends_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/ai_accuracy_and_validation_trends_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/ai_accuracy_and_validation_trends_usecase.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/get_all_validation_users_request_model.dart';

part 'ai_accuracy_and_validation_trends_event.dart';
part 'ai_accuracy_and_validation_trends_state.dart';

DashboardDataModel dashboardDataModel = DashboardDataModel();

class AiAccuracyAndValidationTrendsBloc extends Bloc<
    AiAccuracyAndValidationTrendsEvent, AiAccuracyAndValidationTrendsState> {
  String? startDate;
  String? endDate;
  List<String>? piplineId;
  AiAccuracyAndValidationTrendsBloc()
      : super(AiAccuracyAndValidationTrendsIntialState()) {
    on<AiAccuracyAndValidationTrendsIntialEvent>(
        _onAiAccuracyAndValidationTrendsIntialEvent);
    on<GraphToggalEvent>(_onGraphToggalEvent);
  }
  Future<void> _onAiAccuracyAndValidationTrendsIntialEvent(
      AiAccuracyAndValidationTrendsIntialEvent event,
      Emitter<AiAccuracyAndValidationTrendsState> emit) async {
    startDate = event.startDate;
    endDate = event.endDate;
    piplineId = event.piplineId;
    emit(AiAccuracyAndValidationTrendsLoadingState());
    try {
      final repository = serviceLocator<AiAccuracyAndValidationTrendsUsecase>();
      final req = AiAccuracyAndValidationTrendsRequestModel(
        startDate: startDate ?? event.startDate,
        endDate: endDate ?? event.endDate,
        filter: [
          Filter(
              fieldName: "pipelines", fieldValue: piplineId ?? event.piplineId),
        ],
      );
      final response = await repository.invoke(req);
      if (response.isLeft) {
        emit(AiAccuracyAndValidationTrendsFailureState());
      } else {
        final AiAccuracyAndValidationTrendsResponseModel model = response.right;
        dashboardDataModel = dashboardDataModel.copyWith(
          aiAccuracyAndValidationTrendsAttributeModel:
              AiAccuracyAndValidationTrendsAttributeModel(
            data: DataAttribute(
              items: model.data?.items
                  ?.map(
                    (e) => AttributeItem(
                      aiAccuracy: e.aiAccuracy ?? 0,
                      date: e.date ?? "",
                      validationPercentage: e.validationPercentage ?? 0,
                    ),
                  )
                  .toList(),
            ),
            message: model.message,
            success: model.success,
            failCode: model.failCode,
          ),
        );

        emit(AiAccuracyAndValidationTrendsSucssesState(
            dashboardDataModel: dashboardDataModel));
      }
    } catch (e) {
      emit(AiAccuracyAndValidationTrendsFailureState());
    }
  }

  Future<void> _onGraphToggalEvent(GraphToggalEvent event,
      Emitter<AiAccuracyAndValidationTrendsState> emit) async {
    emit(AiAccuracyAndValidationTrendsLoadingState());
    try {
      emit(AiAccuracyAndValidationTrendsSucssesState(
          isVisible: event.isVisible));
    } catch (e) {
      emit(AiAccuracyAndValidationTrendsFailureState());
    }
  }
}
