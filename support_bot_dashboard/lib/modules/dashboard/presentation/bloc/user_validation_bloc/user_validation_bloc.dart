import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_initial_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/get_validation_by_count_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_validation_by_count_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_get_validation_by_count_usecase.dart';

part 'user_validationevent.dart';
part 'uservalidation_state.dart';

DashboardDataModel dashboardDataModel = DashboardDataModel();

class UserValidationBloc
    extends Bloc<UserValidationevent, UservalidationState> {
  List<String>? selectedPipelineId = [""];
  DashboardAnswerDataInitialRequestModel requestBody =
      DashboardAnswerDataInitialRequestModel();
  UserValidationBloc() : super(UserValidationIntialState()) {
    on<UserValidationsEvent>(_onUserValidationEvent);
  }

  FutureOr<void> _onUserValidationEvent(
      UserValidationsEvent event, Emitter<UservalidationState> emit) async {
    emit(UserValidationLoadingState());

    try {
      selectedPipelineId = event.selectedPipelineValue;
      final repository = serviceLocator<DashboardGetValidationByCountUsecase>();

      final startDate = (event.startDate ?? DateTime.now())
          .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)
          .toIso8601String();
      final endDate = (event.endDate ?? DateTime.now())
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
        emit(UserValidationFailureSate());
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
        bool isEmpty = (dashboardDataModel.getValidationByCountAttributeModel
                    ?.data?.counts?.isEmpty ==
                true &&
            dashboardDataModel.getValidationByCountAttributeModel?.data
                    ?.percentages?.isEmpty ==
                true);

        if (isEmpty) {
          emit(UserValidationEmptyState());
        } else {
          emit(UserValidationSucssesState(
              dashboardDataModel: dashboardDataModel));
        }
      }
    } catch (e) {
      emit(UserValidationFailureSate());
    }
  }
}
