import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_export_usecase.dart';
import 'dart:html' as html;

part 'export_event.dart';
part 'export_state.dart';

class ExportBloc extends Bloc<ExportEvent, ExportState> {
  ExportBloc() : super(ExportInitial()) {
    on<FetchExportDataEvent>(_onFetchExportDataEvent);
  }

  FutureOr<void> _onFetchExportDataEvent(
      FetchExportDataEvent event, Emitter<ExportState> emit) async {
    emit(ExportLoadingState());
    final repository = serviceLocator<DashboardExportusecase>();
    final response = await repository.invoke(
        event.selectedDate,
        event.selectedMonth,
        event.selectedPipeline,
        event.ticketId,
        event.selectedClassification,
        event.selectedClassificationValidation);
     response.fold(
      (failure) => emit(ExportFailureState(message: 'Failed to load data')),
      (bytes) async {
        try {
          if (bytes.isEmpty) {
            emit(ExportFailureState(message: 'No data to export'));
            return;
          }

          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          
          final anchor = html.AnchorElement(href: url)
            ..setAttribute('download', 'exported_records.zip')
            ..style.display = 'none';
          
          html.document.body?.children.add(anchor);
          anchor.click();
          
          // Cleanup
          html.document.body?.children.remove(anchor);
          html.Url.revokeObjectUrl(url);
          
          emit(ExportSuccessState());
        } catch (e) {
          emit(ExportFailureState(
              message: 'Failed to process export: ${e.toString()}'));
        }
      },
    );
  }
}
