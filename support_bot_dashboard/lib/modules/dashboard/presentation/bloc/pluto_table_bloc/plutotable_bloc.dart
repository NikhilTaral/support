import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_pluto_table_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_filter_classification_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_table_data_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_validation_usecase.dart';
part 'plutotable_event.dart';
part 'plutotable_state.dart';

class PlutotableBloc extends Bloc<PlutotableEvent, PlutotableState> {
  DashboardTableAttributeModel? initialData;
  List<PlutoRow>? rows;
  PlutotableBloc() : super(PlutotableInitial()) {
    on<FetchTableDataEvent>(_onFetchTableDataEvent);
    on<SelectDateEvent>(_onSelectDateEvent);
    on<SelectMonthEvent>(_onSelectMonthEvent);
    on<UpdateValidationEvent>(_onUpdateValidationEvent);
    on<FilterClassificationEvent>(_onFilterClassificationEvent);
    on<FilterValidationEvent>(_onFilterValidationEvent);
    on<CustomSidebarLoadRowData>(_onCustomSidebarLoadRowData);
  }

  FutureOr<void> _onFetchTableDataEvent(
      FetchTableDataEvent event, Emitter<PlutotableState> emit) async {
    emit(FetchTableDataLoading());
    try {
      final repository = serviceLocator<DashboardTableDatausecase>();
      final response =
          await repository.invoke(event.selectedDate, event.selectedMonth);
      if (response.isLeft) {
        emit(FetchTableDataError(message: "Failed to fetch data", selectedClassification: event.selectedClassification ?? "", selectedValidation: event.selectedClassificationValidation ?? ""));
      } else {
        final model = response.right;

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
              selectedDate: event.selectedDate ?? DateTime.now(),
              selectedMonth: event.selectedMonth ?? DateTime(2024, 01),
              selectedValidation: event.selectedClassificationValidation ?? "",
              noDataAvailable: items.isEmpty,
              selectedPipeline: event.selectedPipeline ?? ""));
        } else {
          emit(FetchTableDataEmpty());
        }
      }
    } catch (e) {
      emit(FetchTableDataError(message: "Exception occurred: $e", selectedClassification: event.selectedClassification ?? "", selectedValidation: event.selectedClassificationValidation ?? ""));
    }
  }

  FutureOr<void> _onSelectDateEvent(
      SelectDateEvent event, Emitter<PlutotableState> emit) {
    emit(UpdateDateState(selectedDate: event.selectedDate));
    add(FetchTableDataEvent(
        selectedDate: event.selectedDate, selectedMonth: DateTime(2024 - 01)));
  }

  FutureOr<void> _onSelectMonthEvent(
      SelectMonthEvent event, Emitter<PlutotableState> emit) {
    emit(UpdateMonthState(selectedMonth: event.selectedMonth));
    add(FetchTableDataEvent(
        selectedDate: null, selectedMonth: event.selectedMonth));
  }

  FutureOr<void> _onUpdateValidationEvent(
      UpdateValidationEvent event, Emitter<PlutotableState> emit) async {
    emit(UpdateValidationLoading());
    try {
      final repository = serviceLocator<DashboardValidationUsecase>();
      await repository.invoke(event.id, event.validation, event.reason);
      emit(UpdateValidationSuccess(
          selectedDate: event.selectedDate ?? DateTime.now(),
          selectedMonth: event.selectedMonth ?? DateTime(2024 - 01)));
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
          selectedDate: event.selectedDate,
          selectedMonth: event.selectedMonth,
          selectedValidation: 'Select',
          noDataAvailable: false,
          selectedPipeline: 'Select'));
    } else {
      try {
        final repository =
            serviceLocator<DashboardFilterClassificationDatausecase>();
        final response = await repository.invoke(
            event.selectedDate,
            event.selectedMonth,
            event.selectedClassification,
            event.selectedClassificationValidation);
        if (response.isLeft) {
          emit(FetchTableDataError(message: "Failed to fetch data", selectedClassification: event.selectedClassification, selectedValidation: event.selectedClassificationValidation));
        } else {
          final model = response.right;
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
                selectedPipeline: 'Select'));
          } else {
            emit(FetchTableDataEmpty());
          }
        }
      } catch (e) {
        emit(FetchTableDataError(message: "Exception occurred: $e", selectedClassification: event.selectedClassification, selectedValidation: event.selectedClassificationValidation));
      }
    }
  }

  FutureOr<void> _onFilterValidationEvent(
      FilterValidationEvent event, Emitter<PlutotableState> emit) async {
    emit(FetchTableDataLoading());

    if (event.selectedClassificationValidation == 'Select') {
      if (event.selectedClassification != 'Select') {
        final repository =
            serviceLocator<DashboardFilterClassificationDatausecase>();
        final response = await repository.invoke(event.selectedDate,
            event.selectedMonth, event.selectedClassification, null);
        if (response.isLeft) {
          emit(FetchTableDataError(message: "Failed to fetch data", selectedClassification: event.selectedClassification, selectedValidation: event.selectedClassificationValidation));
        } else {
          final model = response.right;
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
                selectedPipeline: 'Select'));
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
            selectedValidation: 'Select',
            noDataAvailable: initialData!.items.isEmpty,
            selectedPipeline: 'Select'));
      }
    } else {
      // both classification and validation filters
      try {
        final repository =
            serviceLocator<DashboardFilterClassificationDatausecase>();
        final response = await repository.invoke(
            event.selectedDate,
            event.selectedMonth,
            event.selectedClassification,
            event.selectedClassificationValidation);
        if (response.isLeft) {
          emit(FetchTableDataError(message: "Failed to fetch data", selectedClassification: event.selectedClassification, selectedValidation: event.selectedClassificationValidation));
        } else {
          final model = response.right;

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
                selectedValidation: event.selectedClassificationValidation,
                noDataAvailable: items.isEmpty,
                selectedPipeline: 'Select'));
          } else {
            emit(FetchTableDataEmpty());
          }
        }
      } catch (e) {
        emit(FetchTableDataError(message: "Exception occurred: $e", selectedClassification: event.selectedClassification, selectedValidation: event.selectedClassificationValidation));
      }
    }
  }

  FutureOr<void> _onCustomSidebarLoadRowData(
      CustomSidebarLoadRowData event, Emitter<PlutotableState> emit) {
    if (event.rowIndex >= 0 && event.rowIndex < rows!.length) {
      emit(CustomSidebarLoaded(event.rowIndex));
    }
  }
}
