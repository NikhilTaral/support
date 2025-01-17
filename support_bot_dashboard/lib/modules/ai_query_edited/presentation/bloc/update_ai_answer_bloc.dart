import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/data/model/update_ai_answer_request_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/data/model/update_ai_answer_response_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/domain/entities/update_ai_answer_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/domain/usecases/ai_query_usecase.dart';

part 'update_ai_answer_event.dart';
part 'update_ai_answer_state.dart';

class UpdateAiAnswerBloc
    extends Bloc<UpdateAiAnswerEvent, UpdateAiAnswerState> {
  UpdateAiAnswerAttributeModel? updateAiAnswerAttributeModel;
  UpdateAiAnswerBloc() : super(UpdateAiAnswerInitialState()) {
    on<UpdateAiAnswerInitialEvent>(_updateAiAnswerInitialEvent);
  }

  FutureOr<void> _updateAiAnswerInitialEvent(UpdateAiAnswerInitialEvent event,
      Emitter<UpdateAiAnswerState> emit) async {
    emit(UpdateAiAnswerLoadingState());
    try {
      final repository = serviceLocator.get<UpdateAiAnswerUsecase>();
      final req = UpdateAiAnswerRequestModel(
          newAnswer: event.updatedAnswer ?? "",
          ticketId: event.ticketId ?? "",
          pipeline: event.selectedPipelineValue ?? "11257490");
      final response = await repository.invoke(req);
      if (response.isLeft) {
        emit(UpdateAiAnswerFailureState());
      } else {
        final UpdateAiAnswerResponseModel model =
            UpdateAiAnswerResponseModel.fromJson(response.right);
        if (model.success == true && model.data != null) {}
        if (updateAiAnswerAttributeModel?.data?.message?.isEmpty == true) {
          emit(UpdateAiAnswerEmptyState());
        } else {
          emit(UpdateAiAnswerSuccessState());
        }
      }
    } catch (e) {
      emit(UpdateAiAnswerFailureState());
    }
  }

  // AiQueryAttributeModel mapResponseToAttributeModel(
  //     AiQueryResponseModel response) {
  //   return AiQueryAttributeModel(
  //     data: response.data != null
  //         ? AiQueryAttributeData(
  //             totalRecords: response.data?.totalRecords,
  //             items: response.data?.items
  //                 ?.map((item) => AiQueryAttributeItem(
  //                       id: item.id ?? "",
  //                       createdAt: item.createdAt ?? "",
  //                       ticketDescription: item.ticketDescription ?? "",
  //                       aiResponse: item.aiResponse ?? "",
  //                       answeredStatus: item.answeredStatus,
  //                       isAnswerEdited: item.isAnswerEdited,
  //                       agentAnsValidation: item.agentAnsValidation,
  //                       answerValidationReason:
  //                           item.answerValidationReason ?? "",
  //                     ))
  //                 .toList(),
  //             pageSize: response.data?.pageSize,
  //             currentPage: response.data?.currentPage,
  //           )
  //         : null,
  //     success: response.success,
  //     failCode: response.failCode,
  //     message: response.message,
  //   );
  // }
}
