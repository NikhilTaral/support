import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/ai_accuracy_and_validation_trends_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/ai_accuracy_and_validation_trends_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/ai_accuracy_and_validation_trends_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/ai_accuracy_and_validation_trends_attribute_model.dart'
    as response_model;
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/ai_accuracy_and_validation_trends_usecase.dart';

part 'ai_accuracy_and_validation_trends_event.dart';
part 'ai_accuracy_and_validation_trends_state.dart';

class AiAccuracyAndValidationTrendsBloc extends Bloc<
    AiAccuracyAndValidationTrendsEvent, AiAccuracyAndValidationTrendsState> {
  AiAccuracyAndValidationTrendsBloc()
      : super(AiAccuracyAndValidationTrendsIntialState()) {
    on<AiAccuracyAndValidationTrendsIntialEvent>(
        _onAiAccuracyAndValidationTrendsIntialEvent);
        on<GraphToggalEvent>(_onGraphToggalEvent);
  }
  Future<void> _onAiAccuracyAndValidationTrendsIntialEvent(
      AiAccuracyAndValidationTrendsIntialEvent event,
      Emitter<AiAccuracyAndValidationTrendsState> emit) async {
    emit(AiAccuracyAndValidationTrendsLoadingState());
    try {
      final repository = serviceLocator<AiAccuracyAndValidationTrendsUsecase>();
      final req = AiAccuracyAndValidationTrendsRequestModel(
          startDate: event.startDate,
          endDate: event.endDate,
          filter: [
            Filter(fieldName: "pipelines", fieldValue: [event.piplineId ?? ""]),
          ]);
      final response = await repository.invoke(req);
      if (response.isLeft) {
        emit(AiAccuracyAndValidationTrendsFailureState());
      } else {
        final AiAccuracyAndValidationTrendsResponseModel model = response.right;
        final AiAccuracyAndValidationTrendsAttributeModel attributeModel =
            AiAccuracyAndValidationTrendsAttributeModel(
          data: model.data
              ?.map((item) => response_model.GraphData(
                    date: item.date ?? "",
                    aiAccuracy: item.aiAccuracy,
                    validationPercentage: item.validationPercentage,
                  ))
              .toList(),
          message: model.message,
          success: model.success,
        );
        emit(AiAccuracyAndValidationTrendsSucssesState(model: attributeModel));
      }
    } catch (e) {
      emit(AiAccuracyAndValidationTrendsFailureState());
    }
  }

Future<void>_onGraphToggalEvent(GraphToggalEvent event, Emitter<AiAccuracyAndValidationTrendsState> emit) async {
    emit(AiAccuracyAndValidationTrendsLoadingState());
    try {
      emit(AiAccuracyAndValidationTrendsSucssesState(isVisible: event.isVisible));
    } catch (e) {
      emit(AiAccuracyAndValidationTrendsFailureState());
    }
  }
}
