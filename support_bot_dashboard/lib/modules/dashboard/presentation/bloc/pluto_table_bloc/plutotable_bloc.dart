import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_get_validation_details_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_pluto_table_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_get_validation_details_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_get_validation_details_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_table_data_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_validation_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/revert_classification_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/unrevert_classification_usecase.dart';
part 'plutotable_event.dart';
part 'plutotable_state.dart';

class PlutotableBloc extends Bloc<PlutotableEvent, PlutotableState> {
  bool isUpdatedToHubspot = false;
  GetValidationDetailsAttributeModel? getValidationAttributeModel;
  DashboardTableAttributeModel? tableData;
  List<PlutoRow>? rows;
  PlutotableBloc() : super(PlutotableInitial()) {
    on<FetchTableDataEvent>(_onFetchTableDataEvent);
    on<SelectDateEvent>(_onSelectDateEvent);
    on<SelectMonthEvent>(_onSelectMonthEvent);
    on<UpdateValidationEvent>(_onUpdateValidationEvent);
    on<RevertClassificationEvent>(_onRevertClassificationEvent);
    on<UnRevertClassificationEvent>(_onUnRevertClassificationEvent);
    on<GetValidationDetailsEvent>(_onGetValidationDetailsEvent);
  }

  FutureOr<void> _onFetchTableDataEvent(
      FetchTableDataEvent event, Emitter<PlutotableState> emit) async {
    emit(FetchTableDataLoading());
    try {
      String? validationFilter;
      if (event.selectedClassificationValidation == 'all') {
        validationFilter = null;
      } else if (event.selectedClassificationValidation == 'not validated') {
        validationFilter = "";
      } else {
        validationFilter = event.selectedClassificationValidation;
      }
      final repository = serviceLocator<DashboardTableDatausecase>();
      final response;
      if (event.selectedClassification == 'All') {
        response = await repository.invoke(
            event.selectedDate,
            event.selectedMonth,
            event.selectedPipeline,
            event.ticketId,
            null,
            validationFilter,
            event.page,
            event.pageSize);
      } else {
        response = await repository.invoke(
            event.selectedDate,
            event.selectedMonth,
            event.selectedPipeline,
            event.ticketId,
            event.selectedClassification,
            validationFilter,
            event.page,
            event.pageSize);
      }

      if (response.isLeft) {
        emit(FetchTableDataError(
            message: "Failed to fetch data",
            selectedClassification: event.selectedClassification ?? "",
            selectedValidation: event.selectedClassificationValidation ?? ""));
      } else {
        //final model = response.right;
        final model = DashboardPlutotableResponseModel.fromJson(
            json.decode(response.right));
        if (model.success == true) {
          List<TableItem> items = (model.data?.items as List<Item>).map((item) {
            return TableItem(
                id: item.id.s ?? "",
                classification: item.classification.s ?? "",
                hsPipelineStage: item.hsPipelineStage.s ?? "",
                reasoning: item.reasoning.s ?? "",
                createdAt: item.createdAt.s ?? "",
                ticketDescription: item.ticketDescription.s ?? "",
                classificationValidation: item.classificationValidation.s ?? "",
                classificationValidationReason:
                    item.classificationValidationReason.s ?? "",
                isUpdatedToHubspot:
                    item.isUpdatedToHubspot?.isUpdatedToHubspotBool,
                validatedClassification: item.validatedClassification.s ?? "",
                classificationValidatedBy:
                    item.classificationValidatedBy.s ?? "");
          }).toList();

          tableData = DashboardTableAttributeModel(
              totalRecords: model.data?.totalRecords,
              items: items,
              pageSize: model.data.pageSize,
              currentPage: model.data.currentPage);

          // initialData = tableData;
          emit(FetchTableDataSuccess(
              selectedClassification: event.selectedClassification ?? "",
              tableData: tableData,
              selectedDate: event.selectedDate ?? null,
              selectedMonth: event.selectedMonth ?? null,
              selectedValidation: event.selectedClassificationValidation ?? "",
              noDataAvailable: items.isEmpty,
              selectedPipeline: event.selectedPipeline ?? "",
              getValidationDetailsAttributeModel: getValidationAttributeModel));
        } else {
          emit(FetchTableDataEmpty());
        }
      }
    } catch (e) {
      emit(FetchTableDataError(
          message: "Exception occurred: $e",
          selectedClassification: event.selectedClassification ?? "",
          selectedValidation: event.selectedClassificationValidation ?? ""));
    }
  }

  FutureOr<void> _onSelectDateEvent(
      SelectDateEvent event, Emitter<PlutotableState> emit) {
    emit(UpdateDateState(
        selectedDate: event.selectedDate,
        selectedPipeline: event.selectedPipeline));
    add(FetchTableDataEvent(
        selectedDate: event.selectedDate,
        selectedMonth: null,
        selectedPipeline: event.selectedPipeline,
        page: event.page,
        pageSize: event.pageSize));
  }

  FutureOr<void> _onSelectMonthEvent(
      SelectMonthEvent event, Emitter<PlutotableState> emit) {
    emit(UpdateMonthState(
        selectedMonth: event.selectedMonth,
        selectedPipeline: event.selectedPipeline));
    add(FetchTableDataEvent(
        selectedDate: null,
        selectedMonth: event.selectedMonth,
        selectedPipeline: event.selectedPipeline,
        page: event.page,
        pageSize: event.pageSize));
  }

  FutureOr<void> _onUpdateValidationEvent(
      UpdateValidationEvent event, Emitter<PlutotableState> emit) async {
    emit(UpdateValidationLoading());
    try {
      final repository = serviceLocator<DashboardValidationUsecase>();
      await repository.invoke(event.id, event.validation, event.reason,
          event.pipeline, event.classification ?? "");
      emit(UpdateValidationSuccess(
          selectedDate: event.selectedDate ?? null,
          selectedMonth: event.selectedMonth ?? null,
          updatedValidation: event.validation));
    } catch (e) {
      emit(UpdateValidationError(errorMessage: 'Exception occurred: $e'));
    }
  }

  FutureOr<void> _onRevertClassificationEvent(
      RevertClassificationEvent event, Emitter<PlutotableState> emit) async {
    emit(RevertClassificationLoadingState());
    try {
      if (isUpdatedToHubspot == false) {
        final repository = serviceLocator<RevertClassificationUsecase>();
        await repository.invoke(event.ticketId ?? '');
        emit(RevertClassificationSuccessState(event.selectedDate,
            event.selectedMonth, event.selectedClassification));
      } else {
        emit(RevertClassificationFailureState(
            message: 'Not updated to hubspot'));
      }
    } catch (e) {
      emit(RevertClassificationFailureState(message: 'Exception occurred: $e'));
    }
  }

  FutureOr<void> _onUnRevertClassificationEvent(
      UnRevertClassificationEvent event, Emitter<PlutotableState> emit) async {
    emit(UnRevertClassificationLoadingState());
    try {
      if (isUpdatedToHubspot == false) {
        final repository = serviceLocator<UnRevertClassificationUsecase>();
        await repository.invoke(
            event.ticketId ?? '', event.selectedClassification ?? '');
        emit(UnRevertClassificationSuccessState(event.selectedDate,
            event.selectedMonth, event.selectedClassification));
      } else {
        emit(UnRevertClassificationFailureState(message: 'Not Reverted'));
      }
    } catch (e) {
      emit(UnRevertClassificationFailureState(
          message: 'Exception occurred: $e'));
    }
  }

  FutureOr<void> _onGetValidationDetailsEvent(
      GetValidationDetailsEvent event, Emitter<PlutotableState> emit) async {
    //  emit(GetValidationDetailsLoading());
    try {
      final repository = serviceLocator<DashboardGetValidationDetailsUsecase>();
      final response = await repository.invoke(event.ticketId ?? '');
      if (response.isLeft) {
        emit(GetValidationDetailsFailure(message: 'Failed to load data'));
      } else {
        final model =
            GetValidationDetailsResponseModel.fromJson(response.right);
        final getValidationAttributeModel = GetValidationDetailsAttributeModel(
            data: ValidationData(
                message: model.data?.message, status: model.data?.status));

        emit(FetchTableDataSuccess(
            selectedDate: event.selectDate,
            selectedMonth: event.selectMonth,
            selectedPipeline: event.pipeline,
            tableData: tableData,
            getValidationDetailsAttributeModel: getValidationAttributeModel));
      }
    } catch (e) {
      emit(GetValidationDetailsFailure(message: 'Exception occurred: $e'));
    }
  }
}
