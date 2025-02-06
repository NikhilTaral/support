import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/common/attribute_mapper.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_Initial_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/validation_status_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/validation_status_usecase.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';

part 'validation_status_event.dart';
part 'validation_status_state.dart';

class ValidationStatusBloc
    extends Bloc<ValidationStatusEvent, ValidationStatusState> {
  List<String>? selectedPipelineId = [""];
  DashboardAnswerDataInitialRequestModel requestBody =
      DashboardAnswerDataInitialRequestModel();
  ValidationStatusBloc() : super(ValidationStatusInitialState()) {
    on<ValidationStatuseCallEvent>(_onValidationStatuseCallEvent);
  }

  FutureOr<void> _onValidationStatuseCallEvent(ValidationStatuseCallEvent event,
      Emitter<ValidationStatusState> emit) async {
    emit(ValidationStatusLoadingState());

    final repository = serviceLocator<ValidationStatusUsecase>();

    final startDate = (event.startDate ?? DateTime.now())
        .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)
        .toIso8601String();
    final endDate = (event.endDate ?? DateTime.now())
        .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999)
        .toIso8601String();
    selectedPipelineId = event.selectedPipelineValue;
    final List<Filter> filter = [
      Filter(
        fieldValue: selectedPipelineId,
        fieldName: event.fildName ?? "pipelines",
      )
    ];
    final requestBody = DashboardAnswerDataInitialRequestModel(
      startDate: startDate,
      endDate: endDate,
      filter: filter,
    );
    final response = await repository.invoke(requestBody);
    if (response.isLeft) {
      emit(ValidationStatusFailureState());
    } else {
      try {
        final ValidationStatusAttributeModel attributeModel =
            AttributeMapper.mapValidationStatuseResponseModel(response.right);
        emit(ValidationStatusSucssesState(attributeModel: attributeModel));
      } catch (e) {
        emit(ValidationStatusFailureState());
      }
    }
  }

  Future<List<DateTime?>> getSelectedDates() async {
    return await LocalStorage.getSelectedDates();
  }
}
