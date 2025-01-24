import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/update_classification_validation_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/update_classification_validation_responce_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/_update_Classification_validation_entitie_module.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/usecases/common_ticket_classification_usecases.dart';

part 'update_classification_validation_event.dart';
part 'update_classification_validation_state.dart';

class UpdateClassificationValidationBloc extends Bloc<
    UpdateClassificationValidationEvent, UpdateClassificationValidationState> {
  UpdateClassificationValidationEntitieModule
      updateClassificationValidationEntitieModule =
      UpdateClassificationValidationEntitieModule();
  UpdateClassificationValidationBloc()
      : super(UpdateClassificationValidationIntialState()) {
    on<UpdateClassificationValidationstateEvent>(
        _UpdateClassificationValidationstateEvent);
  }
  Future<void> _UpdateClassificationValidationstateEvent(
      UpdateClassificationValidationstateEvent event,
      Emitter<UpdateClassificationValidationState> emit) async {
    try {
      final repository =
          serviceLocator<UpdateClassificationValidationUsecase>();
      final req = UpdateClassificationValidationRequestModel(
          reason: event.reason ?? null,
          validatedClassification: event.validatedClassification ?? null,
          id: event.id,
          pipeline: event.pipeline,
          validation: event.validation ?? "");
      final response = await repository.invoke(req);
      if (response.isLeft) {
        emit(UpdateClassificationValidationFailureState());
      } else {
        final UpdateClassificationValidationResponseModel model =
            UpdateClassificationValidationResponseModel.fromJson(
                response.right);

        updateClassificationValidationEntitieModule =
            UpdateClassificationValidationEntitieModule(
                data:
                    updateClassificationValidationEntitieModule.data?.copyWith(
                  message: model.message,
                ),
                failCode: model.failCode,
                message: model.message,
                success: model.success);
        emit(UpdateClassificationValidationSucssesState(
            model: updateClassificationValidationEntitieModule));
      }
    } catch (e) {
      emit(UpdateClassificationValidationFailureState());
    }
  }
}
