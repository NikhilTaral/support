import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_pluto_table_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_filter_classification_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_table_data_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_validation_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/revert_classification_usecase.dart';
part 'plutotable_event.dart';
part 'plutotable_state.dart';

class PlutotableBloc extends Bloc<PlutotableEvent, PlutotableState> {
  DashboardTableAttributeModel? initialData;
  bool isUpdatedToHubspot = false;
  List<PlutoRow>? rows;
  PlutotableBloc() : super(PlutotableInitial()) {
    on<FetchTableDataEvent>(_onFetchTableDataEvent);
    on<SelectDateEvent>(_onSelectDateEvent);
    on<SelectMonthEvent>(_onSelectMonthEvent);
    on<UpdateValidationEvent>(_onUpdateValidationEvent);
    on<FilterClassificationEvent>(_onFilterClassificationEvent);
    on<FilterValidationEvent>(_onFilterValidationEvent);
    on<RevertClassificationEvent>(_onRevertClassificationEvent);
    on<SearchTableEvent>(_onSearchTableEvent);
  }

  FutureOr<void> _onFetchTableDataEvent(
      FetchTableDataEvent event, Emitter<PlutotableState> emit) async {
    emit(FetchTableDataLoading());
    try {
      final repository = serviceLocator<DashboardTableDatausecase>();
      final response = await repository.invoke(
          event.selectedDate,
          event.selectedMonth,
          event.selectedPipeline,
          event.ticketId,
          event.selectedClassification,
          event.selectedClassificationValidation);
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
              id: item.id.s,
              classification: item.classification.s,
              hsPipelineStage: item.hsPipelineStage.s,
              reasoning: item.reasoning.s,
              createdAt: item.createdAt.s,
              ticketDescription: item.ticketDescription.s,
              classificationValidation: item.classificationValidation.s,
              classificationValidationReason:
                  item.classificationValidationReason.s,
              isUpdatedToHubspot:
                  item.isUpdatedToHubspot?.isUpdatedToHubspotBool,
            );
          }).toList();

          final tableData = DashboardTableAttributeModel(
            totalRecords: model.data?.totalRecords,
            items: items,
          );

          initialData = tableData;

          emit(FetchTableDataSuccess(
              selectedClassification: event.selectedClassification ?? "",
              tableData: tableData,
              selectedDate: event.selectedDate ?? null,
              selectedMonth: event.selectedMonth ?? null,
              selectedValidation: event.selectedClassificationValidation ?? "",
              noDataAvailable: items.isEmpty,
              selectedPipeline: event.selectedPipeline ?? ""));
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
    emit(UpdateDateState(selectedDate: event.selectedDate,selectedPipeline: event.selectedPipeline));
    add(FetchTableDataEvent(
        selectedDate: event.selectedDate,
        selectedMonth:null,
        selectedPipeline: event.selectedPipeline));
  }

  FutureOr<void> _onSelectMonthEvent(
      SelectMonthEvent event, Emitter<PlutotableState> emit) {
    emit(UpdateMonthState(selectedMonth: event.selectedMonth,selectedPipeline: event.selectedPipeline));
    add(FetchTableDataEvent(
        selectedDate: null,
        selectedMonth: event.selectedMonth,
        selectedPipeline: event.selectedPipeline));
  }

  FutureOr<void> _onUpdateValidationEvent(
      UpdateValidationEvent event, Emitter<PlutotableState> emit) async {
    emit(UpdateValidationLoading());
    try {
      final repository = serviceLocator<DashboardValidationUsecase>();
      await repository.invoke(event.id, event.validation, event.reason);
      emit(UpdateValidationSuccess(
          selectedDate: event.selectedDate ?? null,
          selectedMonth: event.selectedMonth ?? null));
    } catch (e) {
      emit(UpdateValidationError(errorMessage: 'Exception occurred: $e'));
    }
  }

  FutureOr<void> _onFilterClassificationEvent(
      FilterClassificationEvent event, Emitter<PlutotableState> emit) async {
    emit(FetchTableDataLoading());

    if (event.selectedClassification == 'Select') {
      emit(FetchTableDataSuccess(
          selectedClassification: "Select",
          tableData: initialData!,
          selectedDate: event.selectedDate ?? null,
          selectedMonth: event.selectedMonth ?? null,
          selectedValidation: 'Select',
          noDataAvailable: false,
          selectedPipeline: event.pipeline));
    } else {
      try {
        final repository = serviceLocator<DashboardTableDatausecase>();
        final response = await repository.invoke(
          event.selectedDate,
          event.selectedMonth,
          event.pipeline ?? '11257490',
          event.ticketId,
          event.selectedClassification,
          event.selectedClassificationValidation,
        );
        if (response.isLeft) {
          emit(FetchTableDataError(
              message: "Failed to fetch data",
              selectedClassification: event.selectedClassification,
              selectedValidation: event.selectedClassificationValidation));
        } else {
          final model = DashboardPlutotableResponseModel.fromJson(
            json.decode(response.right));
          if (model.success == true) {
            List<TableItem> items =
                (model.data?.items as List<Item>).map((item) {
              return TableItem(
                id: item.id.s,
                classification: item.classification.s,
                hsPipelineStage: item.hsPipelineStage.s,
                reasoning: item.reasoning.s,
                createdAt: item.createdAt.s,
                ticketDescription: item.ticketDescription.s,
                classificationValidation: item.classificationValidation.s,
                classificationValidationReason:
                    item.classificationValidationReason.s,
                isUpdatedToHubspot:
                    item.isUpdatedToHubspot?.isUpdatedToHubspotBool,
              );
            }).toList();
            
            final tableData = DashboardTableAttributeModel(
              totalRecords: model.data?.totalRecords,
              items: items,
            );
            emit(FetchTableDataSuccess(
                selectedClassification: event.selectedClassification,
                tableData: tableData,
                selectedDate: event.selectedDate,
                selectedMonth: event.selectedMonth,
                selectedValidation: 'Select',
                noDataAvailable: items.isEmpty,
                selectedPipeline: event.pipeline));
          } else {
            emit(FetchTableDataEmpty());
          }
        }
      } catch (e) {
        emit(FetchTableDataError(
            message: "Exception occurred: $e",
            selectedClassification: event.selectedClassification,
            selectedValidation: event.selectedClassificationValidation));
      }
    }
  }

   FutureOr<void> _onFilterValidationEvent(
      FilterValidationEvent event, Emitter<PlutotableState> emit) async {
    emit(FetchTableDataLoading());

    String? validationFilter;
    if (event.selectedClassificationValidation == 'all') {
      validationFilter = null;
    } else if (event.selectedClassificationValidation == 'not updated') {
      validationFilter = "";
    } else {
      validationFilter = event.selectedClassificationValidation;
    }

    if (event.selectedClassification != 'Select') {
      final repository = serviceLocator<DashboardTableDatausecase>();
      final response = await repository.invoke(
          event.selectedDate,
          event.selectedMonth,
          event.pipeline ?? '11257490',
          event.ticketId,
          event.selectedClassification,
          validationFilter);

      if (response.isLeft) {
        emit(FetchTableDataError(
            message: "Failed to fetch data",
            selectedClassification: event.selectedClassification,
            selectedValidation: event.selectedClassificationValidation));
      } else {
        final model = DashboardPlutotableResponseModel.fromJson(
            json.decode(response.right));
        if (model.success == true) {
          List<TableItem> items = (model.data?.items as List<Item>).map((item) {
            return TableItem(
              id: item.id.s,
              classification: item.classification.s,
              hsPipelineStage: item.hsPipelineStage.s,
              reasoning: item.reasoning.s,
              createdAt: item.createdAt.s,
              ticketDescription: item.ticketDescription.s,
              classificationValidation: item.classificationValidation.s,
              classificationValidationReason:
                  item.classificationValidationReason.s,
              isUpdatedToHubspot:
                  item.isUpdatedToHubspot?.isUpdatedToHubspotBool,
            );
          }).toList();

          final tableData = DashboardTableAttributeModel(
            totalRecords: model.data?.totalRecords,
            items: items,
          );
  
          emit(FetchTableDataSuccess(
              selectedClassification: event.selectedClassification,
              tableData: tableData,
              selectedDate: event.selectedDate,
              selectedMonth: event.selectedMonth,
              selectedValidation: event.selectedClassificationValidation,
              noDataAvailable: items.isEmpty,
              selectedPipeline: event.pipeline ?? ""));
        } else {
          emit(FetchTableDataEmpty());
        }
      }
    } else {
      // both classification and validation are "Select"
      emit(FetchTableDataSuccess(
          selectedClassification: 'Select',
          tableData: initialData!,
          selectedDate: event.selectedDate,
          selectedMonth: event.selectedMonth,
          selectedValidation: 'not updated',
          noDataAvailable: initialData!.items.isEmpty,
          selectedPipeline: event.pipeline ?? ""));
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

  FutureOr<void> _onSearchTableEvent(
      SearchTableEvent event, Emitter<PlutotableState> emit) async {
    emit(FetchTableDataLoading());
    final repository = serviceLocator<DashboardTableDatausecase>();
    final response = await repository.invoke(
        event.selectDate,
        event.selectMonth,
        event.pipeline ?? '11257490',
        event.ticketId,
        event.classification,
        event.classificationValidation);
    try {
      if (response.isLeft) {
        emit(SearchFailureState(message: 'Failed to load'));
      } else {
        final model = dashboardPlutotableResponseModelFromJson(response.right);
        if (model.success == true) {
          List<TableItem> items = (model.data?.items as List<Item>).map((item) {
            return TableItem(
              id: item.id.s,
              classification: item.classification.s,
              hsPipelineStage: item.hsPipelineStage.s,
              reasoning: item.reasoning.s,
              createdAt: item.createdAt.s,
              ticketDescription: item.ticketDescription.s,
              classificationValidation: item.classificationValidation.s,
              classificationValidationReason:
                  item.classificationValidationReason.s,
              isUpdatedToHubspot:
                  item.isUpdatedToHubspot?.isUpdatedToHubspotBool,
            );
          }).toList();

          final tableData = DashboardTableAttributeModel(
            totalRecords: model.data?.totalRecords,
            items: items,
          );

          initialData = tableData;

          emit(FetchTableDataSuccess(
              selectedClassification: event.classification ?? "",
              tableData: tableData,
              selectedDate: event.selectDate ?? null,
              selectedMonth: event.selectMonth ?? null,
              selectedValidation: event.classificationValidation ?? "",
              noDataAvailable: items.isEmpty,
              selectedPipeline: event.pipeline ?? ""));
        } else {
          emit(FetchTableDataEmpty());
        }
      }
    } catch (e) {
      emit(SearchFailureState(message: 'Exception: $e'));
    }
  }
}
