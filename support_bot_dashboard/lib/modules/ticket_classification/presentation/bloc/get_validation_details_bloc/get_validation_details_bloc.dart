import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/get_validation_details_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/get_validation_details_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/get_validation_detailsentitie_entite_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/usecases/common_ticket_classification_usecases.dart';

part 'get_validation_details_event.dart';
part 'get_validation_details_state.dart';

class GetValidationDetailsBloc
    extends Bloc<GetValidationDetailsEvent, GetValidationDetailsState> {
  GetValidationDetailsEntiterModel getValidationDetailsEntiterModel =
      GetValidationDetailsEntiterModel();
  GetValidationDetailsBloc() : super(GetValidationDetailsIntialState()) {
    on<GetValidationDetailsvalidateEvent>(_onGetValidationDetailsvalidateEvent);
  }

  Future<void> _onGetValidationDetailsvalidateEvent(
      GetValidationDetailsvalidateEvent event,
      Emitter<GetValidationDetailsState> emit) async {
    print('Event received: ${event.id}');
    emit(GetValidationDetailsLoadedState());

    try {
      final repository = serviceLocator<GetValidationDetailsUsecase>();
      print('Calling repository with id: ${event.id}');
      final req = GetValidationDetailsRequestModel(
        id: event.id ?? "",
      );
      final response = await repository.invoke(req);
      print('Repository response: $response');

      if (response is Left) {
        print('Error occurred while fetching validation details');
        emit(GetValidationDetailsFailureState());
      } else {
        print('Successful response, parsing data');
        final GetValidationDetailsResponsrModel model =
            GetValidationDetailsResponsrModel.fromJson(response.right);
        print('Parsed model: ${model.data.message}, ${model.data.status}');
        getValidationDetailsEntiterModel = GetValidationDetailsEntiterModel(
            data: getValidationDetailsEntiterModel.data?.copyWith(
                message: model.data.message, status: model.data.status));
        emit(GetValidationDetailsSucssesState());
      }
    } catch (e) {
      print('Exception occurred: $e');
      emit(GetValidationDetailsFailureState());
    }
  }
}
