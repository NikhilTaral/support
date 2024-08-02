import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_pluto_table_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_table_data_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_validation_usecase.dart';
part 'plutotable_event.dart';
part 'plutotable_state.dart';

class PlutotableBloc extends Bloc<PlutotableEvent, PlutotableState> {
  DashboardTableAttributeModel? initialData;
  PlutotableBloc() : super(PlutotableInitial()) {
    on<FetchTableDataEvent>(_onFetchTableDataEvent);
    on<SelectDateEvent>(_onSelectDateEvent);
    on<SelectMonthEvent>(_onSelectMonthEvent);
    on<UpdateValidationEvent>(_onUpdateValidationEvent);
    on<FilterClassificationEvent>(_onFilterClassificationEvent);
    on<FilterValidationEvent>(_onFilterValidationEvent);
  }

  FutureOr<void> _onFetchTableDataEvent(
      FetchTableDataEvent event, Emitter<PlutotableState> emit) async {
    emit(FetchTableDataLoading());
    try {
      final repository = serviceLocator<DashboardTableDatausecase>();
      final response =
          await repository.invoke(event.selectedDate, event.selectedMonth);
      if (response.isLeft) {
        emit(FetchTableDataError("Failed to fetch data"));
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
            );
          }).toList();

          final tableData = DashboardTableAttributeModel(
            totalRecords: model.data?.totalRecords,
            items: items,
          );

          initialData = tableData;

          emit(FetchTableDataSuccess(
            selectedClassification: "Select",
            tableData: tableData,
            selectedDate: event.selectedDate ?? DateTime.now(),
            selectedMonth: event.selectedMonth ?? DateTime(2024, 01),
            selectedValidation: 'Select',
            noDataAvailable:
                items.isEmpty, // Set this flag based on the fetched items
          ));
        } else {
          emit(FetchTableDataError(model.message ?? 'Unknown error'));
        }
      }
    } catch (e) {
      emit(FetchTableDataError("Exception occurred: $e"));
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
      emit(UpdateValidationError('Exception occurred: $e'));
    }
  }

  FutureOr<void> _onFilterClassificationEvent(
      FilterClassificationEvent event, Emitter<PlutotableState> emit) async {
    emit(FetchTableDataLoading());

    if (event.selectedClassification == 'Select') {
      emit(FetchTableDataSuccess(
        selectedClassification: event.selectedClassification,
        tableData: initialData!,
        selectedDate: event.selectedDate,
        selectedMonth: event.selectedMonth,
        selectedValidation: 'Select',
        noDataAvailable: false, // Add a flag for no data
      ));
    } else {
      final filteredData = await filterClassificationData(
        initialData!,
        event.selectedClassification,
      );
      emit(FetchTableDataSuccess(
        selectedClassification: event.selectedClassification,
        tableData: filteredData,
        selectedDate: event.selectedDate,
        selectedMonth: event.selectedMonth,
        selectedValidation: 'Select',
        noDataAvailable: filteredData.items.isEmpty,
      ));
    }
  }

  Future<DashboardTableAttributeModel> filterClassificationData(
      DashboardTableAttributeModel initialData,
      String selectedClassification) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final filteredItems = initialData.items.where((item) {
      return item.classification == selectedClassification;
    }).toList();

    return DashboardTableAttributeModel(
      totalRecords: filteredItems.length,
      items: filteredItems,
    );
  }

  FutureOr<void> _onFilterValidationEvent(
      FilterValidationEvent event, Emitter<PlutotableState> emit) async {
    emit(FetchTableDataLoading());

    if (event.selectedValidation == 'Select') {
      emit(FetchTableDataSuccess(
        selectedClassification: event.selectedClassification,
        tableData: initialData!,
        selectedDate: event.selectedDate,
        selectedMonth: event.selectedMonth,
        selectedValidation: event.selectedValidation,
        noDataAvailable: false, // Add a flag for no data
      ));
    } else {
      final filterdClassificationData = await filterClassificationData(
        initialData!,
        event.selectedClassification,
      );
      final filteredData = await filterValidationData(
        filterdClassificationData,
        event.selectedValidation,
      );
      emit(FetchTableDataSuccess(
        selectedClassification: event.selectedClassification,
        tableData: filteredData,
        selectedDate: event.selectedDate,
        selectedMonth: event.selectedMonth,
        selectedValidation: event.selectedValidation,
        noDataAvailable:
            filteredData.items.isEmpty, // Set the flag based on data
      ));
    }
  }

  Future<DashboardTableAttributeModel> filterValidationData(
      DashboardTableAttributeModel initialData,
      String selectedValidation) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final filteredItems = initialData.items.where((item) {
      return item.classificationValidation == selectedValidation;
    }).toList();
    return DashboardTableAttributeModel(
      totalRecords: filteredItems.length,
      items: filteredItems,
    );
  }
}
