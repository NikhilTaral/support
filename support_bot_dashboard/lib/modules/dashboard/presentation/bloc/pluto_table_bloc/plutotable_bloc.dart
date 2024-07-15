import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_pluto_table_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_table_data_usecase.dart';

part 'plutotable_event.dart';
part 'plutotable_state.dart';

class PlutotableBloc extends Bloc<PlutotableEvent, PlutotableState> {
  PlutotableBloc() : super(PlutotableInitial()) {
    on<FetchTableDataEvent>(_onFetchTableDataEvent);
    on<SelectDateEvent>(_onSelectDateEvent);
    on<SelectMonthEvent>(_onSelectMonthEvent);
  }

FutureOr<void> _onFetchTableDataEvent(FetchTableDataEvent event, Emitter<PlutotableState> emit) async {
  emit(FetchTableDataLoading());
  try {
    print('Fetching table data for ${event.selectedDate}, ${event.selectedMonth}');
    final repository = serviceLocator<DashboardTableDatausecase>();
    final response = await repository.invoke(event.selectedDate, event.selectedMonth);
    response.fold(
      (failure) {
        print('Failed to fetch data: $failure'); 
        emit(FetchTableDataError("Failed to fetch data"));
      },
      (model) {
        if (model.success == true) {
          List<TableItem> items = (model.data?.items as List<Item>).map((item) {
            return TableItem(
              id: item.id.s,
              classification: item.classification.s,
              hsPipelineStage: item.hsPipelineStage.s,
              reasoning: item.reasoning.s,
              createdAt: item.createdAt.s, 
              ticketDescription: item.ticketDescription.s,
            );
          }).toList();

          final tableData = DashboardTableAttributeModel(
            totalRecords: model.data?.totalRecords,
            items: items,
          );

          emit(FetchTableDataSuccess(
            tableData: tableData,
            selectedDate: event.selectedDate ?? DateTime.now(),
            selectedMonth: event.selectedMonth ?? DateTime(2024, 1),
          ));
        } else {
          print('Fetch data success but model.success is false'); 
          emit(FetchTableDataError(model.message ?? 'Unknown error'));
        }
      },
    );
  } catch (e) {
    print('Exception occurred: $e'); 
    emit(FetchTableDataError("Exception occurred: $e"));
  }
}


  FutureOr<void> _onSelectDateEvent(SelectDateEvent event, Emitter<PlutotableState> emit) {
  emit(UpdateDateState(selectedDate: event.selectedDate));
  print('Dateeee ->>>>> ${event.selectedDate}');
    add(FetchTableDataEvent(selectedDate: event.selectedDate,selectedMonth: DateTime(2024, 1)));

  }

  FutureOr<void> _onSelectMonthEvent(SelectMonthEvent event, Emitter<PlutotableState> emit) {
      emit(UpdateMonthState(selectedMonth:event.selectedMonth ));
    add(FetchTableDataEvent(selectedDate: null, selectedMonth: event.selectedMonth));
  }
}
