import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/get_validation_details_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/update_classification_validation_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/get_validation_details_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/usecases/common_ticket_classification_usecases.dart';

part 'get_validation_details_event.dart';
part 'get_validation_details_state.dart';

class GetValidationDetailsBloc
    extends Bloc<GetValidationDetailsEvent, GetValidationDetailsState> {
  GetValidationDetailsAttributeModel getValidationDetailsEntiterModel =
      GetValidationDetailsAttributeModel();
  GetValidationDetailsBloc() : super(GetValidationDetailsIntialState()) {
    on<GetValidationDetailsvalidateEvent>(_onGetValidationDetailsvalidateEvent);
  }
  Future<void> _onGetValidationDetailsvalidateEvent(
      GetValidationDetailsvalidateEvent event,
      Emitter<GetValidationDetailsState> emit) async {
    emit(GetValidationDetailsLoadedState());
    try {
      final repository = serviceLocator<GetValidationDetailsUsecase>();
      final req = GetValidationDetailsRequestModel(
        id: event.id ?? "",
      );
      final response = await repository.invoke(req);
      if (response is Left) {
        emit(GetValidationDetailsFailureState());
      } else {
        final UpdateClassificationValidationResponseModel model =
            response.right;
        getValidationDetailsEntiterModel = GetValidationDetailsAttributeModel(
            data: getValidationDetailsEntiterModel.data?.copyWith(
          message: model.data?.message,
        ));

        emit(GetValidationDetailsSuccessState());
      }
    } catch (e) {
      emit(GetValidationDetailsFailureState());
    }
  }
}
