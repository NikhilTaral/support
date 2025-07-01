import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/get_ai_response_stat_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_ai_response_stat_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/get_ai_response_stat_usecase.dart';

part 'get_ai_response_stat_event.dart';
part 'get_ai_response_stat_state.dart';

class GetAiResponseStatBloc extends Bloc<GetAiResponseStatEvent, GetAiResponseStatState> {
  GetAiResponseStatBloc() : super(GetAiResponseStatInitialState()) {
    on<GetAiResponseStatEvent>((event, emit) {});
    on<GetAiResponseStatInitialEvent>(getAiResponseStatInitialEvent);
  }

  FutureOr<void> getAiResponseStatInitialEvent(GetAiResponseStatInitialEvent event, Emitter<GetAiResponseStatState> emit) async {
    try {
      final startDate =
          (event.startDate ?? DateTime.now()).copyWith(hour: 0, minute: 0, second: 0, millisecond: 0).toIso8601String();
      final endDate =
          (event.endDate ?? DateTime.now()).copyWith(hour: 23, minute: 59, second: 59, millisecond: 999).toIso8601String();
      GetAiResponseStatRequestModel getAiResponseStatRequestModel = GetAiResponseStatRequestModel(
          endDate: endDate,
          startDate: startDate,
          filter: [GetAiResponseStatFilter(fieldName: "pipelines", fieldValue: event.selectedPipelineValue ?? [])]);

      emit(GetAiResponseStatLoadingState());

      final repository = serviceLocator<GetAiResponseStatUsecase>();

      final response = await repository.invoke(getAiResponseStatRequestModel);

      if (response.isLeft) {
        emit(GetAiResponseStatFailureState());
      } else {
        final GetAiResponseStatAttributeModel getAiResponseStatAttributeModel = response.right;
        if (getAiResponseStatAttributeModel.percentages == null) {
          emit(GetAiResponseStatEmptyState());
        } else {
          emit(GetAiResponseStatSuccessState(getAiResponseStatAttributeModel: getAiResponseStatAttributeModel));
        }
      }
    } catch (e) {
      emit(GetAiResponseStatFailureState());
    }
  }
}
