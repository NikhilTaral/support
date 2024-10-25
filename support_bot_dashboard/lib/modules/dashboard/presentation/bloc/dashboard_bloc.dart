import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_get_validation_count_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/get_user_settings_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/get_validation_by_count_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_chart_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_get_validation_count_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_user_settings_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_validation_by_count_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_chartdata_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_get_user_settings_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_get_validation_by_count_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_get_validation_count_usecase.dart';
import 'package:support_bot_dashboard/utils/service/auth/auth_service.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<UpdateSelectedMonthEvent>(_onUpdateSelectedMonthEvent);
    on<UpdateSelectedDateEvent>(_onUpdateSelectedDateEvent);
    on<FetchDashboardDataEvent>(_onFetchDashboardData);
    on<GetValidationCountEvent>(_onGetValidationCount);
    on<GetValidationByCountEvent>(_onGetValidationByCountEvent);
    on<GetUserSettingsEvent>(_onGetUserSettingsEvent);
  }

  ValidationCountAttributeModel? getValidationCountAttribute;
  DashboardChartAttributeModel? dashboardChartData;
  GetValidationByCountAttributeModel? getValidationByCountAttribute;
  GetUserSettingsAttributeModel? userSettingsAtrribute;

  Future<void> _onUpdateSelectedDateEvent(
      UpdateSelectedDateEvent event, Emitter<DashboardState> emit) async {
    emit(DateUpdatedState(event.selectedDate, event.selectedPipeline));
    add(FetchDashboardDataEvent(
      selectedDate: event.selectedDate,
      selectedMonth: null,
      selectedPipeline: event.selectedPipeline,
    ));
  }

  Future<void> _onUpdateSelectedMonthEvent(
      UpdateSelectedMonthEvent event, Emitter<DashboardState> emit) async {
    emit(MonthUpdatedState(event.selectedMonth, event.selectedPipeline));
    add(FetchDashboardDataEvent(
        selectedDate: null,
        selectedMonth: event.selectedMonth,
        selectedPipeline: event.selectedPipeline ?? ""));
  }

  Future<void> _onFetchDashboardData(
      FetchDashboardDataEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardDataLoading());
    final repository = serviceLocator<DashboardChartdataUsecase>();
    final response = await repository.invoke(
        event.selectedDate, event.selectedMonth, event.selectedPipeline);
    if (response.isLeft) {
      emit(DashboardDataError(
        message: "Failed to fetch data",
        selectedDate: event.selectedDate ?? DateTime.now(),
        selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
      ));
    } else {
      try {
        final model =
            dashboardChartResponseModelFromJson(jsonEncode(response.right));

        if (model.success == true && model.data != null) {
          dashboardChartData = DashboardChartAttributeModel(
              genuineQuery: model.data?.genuineQuery ?? 0,
              noActionRequired: model.data?.noActionRequired ?? 0,
              spamMarketing: model.data?.spamMarketing ?? 0,
              acknowledgement: model.data?.acknowledgement ?? 0,
              notClassified: model.data?.notClassified ?? 0);
          emit(DashboardDataSuccess(
              getValidationCountAttributeModel: getValidationCountAttribute,
              pieChartData: dashboardChartData,
              selectedDate: event.selectedDate ?? DateTime.now(),
              selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
              selectedPipeline: event.selectedPipeline,
              getValidationByCountAttributeModel:
                  getValidationByCountAttribute,
                  ));
        } else {
          emit(DashboardDataError(
            message: model.message ?? 'Unknown error',
            selectedDate: event.selectedDate ?? DateTime.now(),
            selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
          ));
        }
      } catch (e) {
        emit(DashboardDataError(
          message: 'Failed to parse data',
          selectedDate: event.selectedDate ?? DateTime.now(),
          selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
        ));
      }
    }
  }

  FutureOr<void> _onGetValidationCount(
      GetValidationCountEvent event, Emitter<DashboardState> emit) async {
    // emit(DashboardDataLoading());
    final repository = serviceLocator<DashboardGetValidationCountUsecase>();
    final response = await repository.invoke(
        event.selectedDate, event.selectedMonth, event.selectedPipeline);
    if (response.isLeft) {
      emit(DashboardDataError(
          selectedDate: event.selectedDate ?? DateTime.now(),
          selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
          message: 'Failed to load data'));
    } else {
      try {
        final model = GetValidationCountResponseModel.fromJson(response.right);
        getValidationCountAttribute = ValidationCountAttributeModel(
            correct: model.data?.correct ?? 0,
            incorrect: model.data?.incorrect ?? 0,
            notValidated: model.data?.notValidated ?? 0);
        emit(DashboardDataSuccess(
            pieChartData: dashboardChartData,
            selectedDate: event.selectedDate,
            selectedMonth: event.selectedMonth,
            selectedPipeline: event.selectedPipeline,
            getValidationCountAttributeModel: getValidationCountAttribute,
            getValidationByCountAttributeModel: getValidationByCountAttribute));
      } catch (e) {
        emit(DashboardDataError(
            selectedDate: event.selectedDate ?? DateTime.now(),
            selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
            message: 'Exception: $e'));
      }
    }
  }

  FutureOr<void> _onGetValidationByCountEvent(
      GetValidationByCountEvent event, Emitter<DashboardState> emit) async {
    // emit(DashboardDataLoading());
    final repository = serviceLocator<DashboardGetValidationByCountUsecase>();
    final response = await repository.invoke(
        event.selectedDate, event.selectedMonth, event.selectedPipeline);
    if (response.isLeft) {
      emit(DashboardDataError(
          selectedDate: event.selectedDate ?? DateTime.now(),
          selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
          message: 'Failed to load data'));
    } else {
      try {
        final model =
            GetValidationByCountResponseModel.fromJson(response.right);
          getValidationByCountAttribute = GetValidationByCountAttributeModel(
        data: model.data,
      );

     
          emit(DashboardDataSuccess(
              pieChartData: dashboardChartData,
              selectedDate: event.selectedDate,
              selectedMonth: event.selectedMonth,
              selectedPipeline: event.selectedPipeline,
              getValidationCountAttributeModel: getValidationCountAttribute,
              getValidationByCountAttributeModel:
                  getValidationByCountAttribute ));
       
      } catch (e) {
        emit(DashboardDataError(
            selectedDate: event.selectedDate ?? DateTime.now(),
            selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
            message: 'Exception: $e'));
      }
    }
  }

  FutureOr<void> _onGetUserSettingsEvent(
      GetUserSettingsEvent event, Emitter<DashboardState> emit) async {
    emit(UserSettingsLoadingState());
    final repository = serviceLocator<DashboardGetUserSettingsUsecase>();
    final AuthService authService = serviceLocator<AuthService>();

    String? email = await authService.getUseremail();
    final response = await repository.invoke(email);
    if (response.isLeft) {
      emit(UserSettingsFailureState(message: 'Failed to load data'));
    } else {
      try {
        final model = GetUserSettingsResponseModel.fromJson(response.right);
         userSettingsAtrribute = GetUserSettingsAttributeModel(
            data: UserSettingsData(accessRole: model.data?.accessRole));
        emit(DashboardDataSuccess(
           pieChartData: dashboardChartData,
             
              getValidationCountAttributeModel: getValidationCountAttribute,
              getValidationByCountAttributeModel:
                  getValidationByCountAttribute,
            getUserSettingsAttributeModel: userSettingsAtrribute));
      } catch (e) {
        emit(UserSettingsFailureState(message: 'Exception: $e'));
      }
    }
  }
}
