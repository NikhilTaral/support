import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/common/attribute_mapper.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_Initial_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/validation_status_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/validation_status_usecase.dart';

part 'validation_status_event.dart';
part 'validation_status_state.dart';

class ValidationStatusBloc
    extends Bloc<ValidationStatusEvent, ValidationStatusState> {
  ValidationStatusBloc() : super(ValidationStatusInitialState()) {
    on<ValidationStatuseCallEvent>(_onValidationStatuseCallEvent);
  }

  FutureOr<void> _onValidationStatuseCallEvent(ValidationStatuseCallEvent event,
      Emitter<ValidationStatusState> emit) async {
    emit(ValidationStatusLodingState());

    final repository = serviceLocator<ValidationStatusUsecase>();
    final req = DashboardChartDataInitialRequestModel(
      filter: [
        Filter(
            fieldValue: [event.selectedPipeline ?? "11257490"],
            fieldName: event.fildName ?? "pipelines")
      ],
      startDate: (event.selectedDate ?? DateTime.parse("2024-12-31"))
          .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)
          .toIso8601String(),
      endDate: (event.selectedMonth ?? DateTime.now())
          .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999)
          .toIso8601String(),
    );
    final response = await repository.invoke(req);
    if (response.isLeft) {
      emit(VsalidationStatusFailureState());
    } else {
      try {
        final ValidationStatusAttributeModel attributeModel =
            AttributeMapper.mapValidationStatuseResponseModel(response.right);
        emit(ValidationStatusSucssesState(attributeModel: attributeModel));
      } catch (e) {
        emit(VsalidationStatusFailureState());
      }
    }
  }
}
