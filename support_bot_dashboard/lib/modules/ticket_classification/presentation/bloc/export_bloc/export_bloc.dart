import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_Initial_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/dashboard_export_request_model.dart';
import 'dart:html' as html;

import 'package:support_bot_dashboard/modules/ticket_classification/domain/usecases/common_ticket_classification_usecases.dart';

part 'export_event.dart';
part 'export_state.dart';

class ExportBloc extends Bloc<ExportEvent, ExportState> {
  String? selectedValidation = "";
  String? bopsState = "";
  String? selectedClassifications = "";
  String? selectedPipeline = "11257490";
  ExportBloc() : super(ExportInitial()) {
    on<FetchExportDataEvent>(_onFetchExportDataEvent);
  }

  FutureOr<void> _onFetchExportDataEvent(
      FetchExportDataEvent event, Emitter<ExportState> emit) async {
    emit(ExportLoadingState());
    selectedValidation = event.selectedClassificationValidation;
    bopsState = event.bopsState;
    selectedClassifications = event.selectedClassification;
    selectedPipeline = event.selectedPipeline;
    final repository = serviceLocator<DashboardExportusecase>();

    final req = DashboardExportRequestModel(
      startDate: event.startDate
          ?.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0),
      endDate: event.endDate
          ?.copyWith(hour: 23, minute: 59, second: 59, millisecond: 999),
      filter: [
        if (event.bopsState != null && event.bopsState!.isNotEmpty)
          Filter(
              fieldName: "BOPS_States",
              fieldValue: event.bopsState?.split(",")),
        if (event.selectedClassification != null &&
            event.selectedClassification!.isNotEmpty)
          Filter(
              fieldName: "classifications",
              fieldValue: event.selectedClassification?.split(',')),
        if (event.selectedClassificationValidation != null &&
            event.selectedClassificationValidation!.isNotEmpty)
          Filter(
              fieldName: "classificationValidations",
              fieldValue: event.selectedClassificationValidation?.split(',')),
        Filter(
          fieldName: "pipelines",
          fieldValue: [selectedPipeline ?? "11257490"],
        ),
      ],
      page: 1,
      pageSize: 10,
    );

    final response = await repository.invoke(req);
    response.fold(
      (failure) {
        emit(ExportFailureState());
      },
      (bytes) async {
        try {
          if (bytes == null) {
            emit(ExportFailureState());
            return;
          }

          final blob = html.Blob([bytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute('download', 'exported_records.csv')
            ..style.display = 'none';

          html.document.body?.children.add(anchor);
          anchor.click();

          html.document.body?.children.remove(anchor);
          html.Url.revokeObjectUrl(url);

          emit(ExportSuccessState());
        } catch (e) {
          emit(ExportFailureState());
        }
      },
    );
  }

  void clearFiltersExport() {
    selectedValidation = "";
    bopsState = "";
    selectedClassifications = "";
    selectedPipeline = "11257490";
  }
}
