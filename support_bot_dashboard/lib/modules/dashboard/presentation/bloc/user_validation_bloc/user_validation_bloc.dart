import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_Initial_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/get_validation_by_count_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_validation_by_count_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_get_validation_by_count_usecase.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';

part 'user_validationevent.dart';
part 'uservalidation_state.dart';

late DashboardDataModel dashboardDataModel = DashboardDataModel();

class UserValidationBloc
    extends Bloc<UserValidationsEvent, UservalidationState> {
  DashboardAnswerDataInitialRequestModel requestBody =
      DashboardAnswerDataInitialRequestModel();
  UserValidationBloc() : super(UserValidationIntialState()) {
    on<UserValidationsEvent>(_onUserValidationEvent);
  }

  FutureOr<void> _onUserValidationEvent(
      UserValidationsEvent event, Emitter<UservalidationState> emit) async {
    emit(UserValidationLoadingState());

    try {
      final repository = serviceLocator<DashboardGetValidationByCountUsecase>();
      final datesList = await getSelectedDates();

      final startDate = (datesList.firstOrNull ?? DateTime.parse("2024-10-23"))
          .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)
          .toIso8601String();
      final endDate = (datesList.lastOrNull ?? DateTime.now())
          .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999)
          .toIso8601String();

      final List<Filter> filter = [
        Filter(
          fieldValue: event.selectedPipelineValue ?? ["11257490"],
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
        emit(UserValidationFailureSate(
          message: response.left.toString(),
          selectedDate: event.selectedDate ?? DateTime.now(),
          selectedMonth: event.selectedMonth ?? DateTime.now(),
        ));
      } else {
        final GetValidationByCountResponseModel model = response.right;

        dashboardDataModel =
            (dashboardDataModel ?? DashboardDataModel()).copyWith(
          getValidationByCountAttributeModel:
              (dashboardDataModel.getValidationByCountAttributeModel ??
                      GetValidationByCountAttributeModel())
                  .copyWith(
            data:
                (dashboardDataModel.getValidationByCountAttributeModel?.data ??
                        ValidationByCountData())
                    .copyWith(
              counts: model.data?.counts ?? <String, double>{},
              percentages: model.data?.percentages ?? <String, double>{},
            ),
          ),
        );

        if (dashboardDataModel
                .getValidationByCountAttributeModel?.data?.counts?.isEmpty ==
            true) {
          emit(UserValidationEmptyState());
        } else {
          emit(UserValidationSucssesState(
              dashboardDataModel: dashboardDataModel));
        }
      }
    } catch (e) {
      emit(UserValidationFailureSate(
        message: 'Exception: $e',
        selectedDate: event.selectedDate ?? DateTime.now(),
        selectedMonth: event.selectedMonth ?? DateTime.now(),
      ));
    }
  }

  Future<List<DateTime?>> getSelectedDates() async {
    return await LocalStorage.getSelectedDates();
  }
}
