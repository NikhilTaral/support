import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/data/model/add_answer_validation_request_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/data/model/add_answer_validation_response_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/domain/entities/add_answer_validation_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/domain/usecases/ai_query_usecase.dart';

part 'add_answer_validation_event.dart';
part 'add_answer_validation_state.dart';

class AddAnswerValidationBloc
    extends Bloc<AddAnswerValidationEvent, AddAnswerValidationState> {
  AddAnswerValidationAttributeModel? addAnswerValidationAttributeModel;
  AddAnswerValidationBloc() : super(AddAnswerValidationInitialState()) {
    on<AddAnswerValidationInitialEvent>(_addAnswerValidationInitialEvent);
  }

  FutureOr<void> _addAnswerValidationInitialEvent(
      AddAnswerValidationInitialEvent event,
      Emitter<AddAnswerValidationState> emit) async {
    emit(AddAnswerValidationLoadingState());
    try {
      final repository = serviceLocator.get<AddAnswerValidationUsecase>();
      final req = AddAnswerValidationRequestModel(
          agentAnsValidation: event.agentAnsValidation ?? true,
          ticketId: event.ticketId,
          pipeline: event.pipeline ?? "11257490");
      final response = await repository.invoke(req);
      if (response.isLeft) {
        emit(AddAnswerValidationFailureState());
      } else {
        final AddAnswerValidationResponseModel model =
            AddAnswerValidationResponseModel.fromJson(response.right);
        if (model.pipeline?.isNotEmpty == true &&
            model.ticketId?.isNotEmpty == true) {
          addAnswerValidationAttributeModel =
              mapResponseToAttributeModel(model);
        }
        if (model.pipeline?.isNotEmpty == true &&
            model.ticketId?.isNotEmpty == true) {
          emit(AddAnswerValidationEmptyState());
        } else {
          emit(AddAnswerValidationSuccessState());
        }
      }
    } catch (e) {
      emit(AddAnswerValidationFailureState());
    }
  }

  AddAnswerValidationAttributeModel mapResponseToAttributeModel(
      AddAnswerValidationResponseModel response) {
    return AddAnswerValidationAttributeModel(
        agentAnsValidation: response.agentAnsValidation ?? false,
        pipeline: response.pipeline ?? "",
        ticketId: response.ticketId ?? "");
  }
}
