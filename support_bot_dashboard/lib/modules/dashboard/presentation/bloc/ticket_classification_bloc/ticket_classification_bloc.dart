import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_chart_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_chartdata_usecase.dart';

part 'ticket_classification_event.dart';
part 'ticket_classification_state.dart';

class TicketClassificationBloc
    extends Bloc<TickiteClassificationEvent, TicketClassificationState> {
  List<String>? selectedPipelineId = [""];
  DashboardDataModel dashboardDataModel = DashboardDataModel();
  TicketClassificationBloc() : super(TicketClassificationInitialState()) {
    on<TickiteClassificationEvent>(_onTickitClassification);
  }

  FutureOr<void> _onTickitClassification(TickiteClassificationEvent event,
      Emitter<TicketClassificationState> emit) async {
    emit(TicketClassificationLoadingState());
    selectedPipelineId = event.selectedPipelineValue;
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 0));
    final repository = serviceLocator<DashboardChartdataUsecase>();
   final req = DashboardAnswerDataInitialRequestModel(
      filter: [
        Filter(
            fieldValue: selectedPipelineId ?? [""],
            fieldName: event.fieldName ?? "pipelines")
      ],
      startDate: (event.startDate ?? DateTime.now())
          .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)
          .toIso8601String(),
      endDate: (event.endDate ?? DateTime.now())
          .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999)
          .toIso8601String(),
    );
    final response = await repository.invoke(req);
    if (response.isLeft) {
      emit(TicketClassificationFailureState());
    } else {
      try {
        final model = response.right;
        dashboardDataModel = (dashboardDataModel).copyWith(
          pieChartData: (dashboardDataModel.pieChartData ??
                  DashboardChartAttributeModel())
              .copyWith(
            data:
                (dashboardDataModel.pieChartData?.data ?? ChartAttributeData())
                    .copyWith(
              counts: (dashboardDataModel.pieChartData?.data?.counts ??
                      ChartAttributeCounts())
                  .copyWith(
                acknowledgementRequired:
                    model.data?.counts?.acknowledgementRequired ?? "",
                genuineQuery: model.data?.counts?.genuineQuery ?? "",
                noActionRequired: model.data?.counts?.noActionRequired ?? "",
                notClassified: model.data?.counts?.notClassified ?? "",
                spamMarketing: model.data?.counts?.spamMarketing ?? "",
              ),
              percentages:
                  (dashboardDataModel.pieChartData?.data?.percentages ??
                          ChartAttributeCounts())
                      .copyWith(
                acknowledgementRequired:
                    model.data?.percentages?.acknowledgementRequired ?? "",
                genuineQuery: model.data?.percentages?.genuineQuery ?? "",
                noActionRequired:
                    model.data?.percentages?.noActionRequired ?? "",
                notClassified: model.data?.percentages?.notClassified ?? "",
                spamMarketing: model.data?.percentages?.spamMarketing ?? "",
              ),
            ),
          ),
        );

        final percentages = dashboardDataModel.pieChartData?.data?.percentages;

        bool isEmpty = percentages?.acknowledgementRequired == 0 &&
            percentages?.genuineQuery == 0 &&
            percentages?.noActionRequired == 0 &&
            percentages?.spamMarketing == 0;
        if (isEmpty) {
          emit(TicketClassificationEmptyState());
        } else {
          emit(TicketClassificationSucssesState(
              dashboardDataModel: dashboardDataModel));
        }
      } catch (e) {
        emit(TicketClassificationFailureState());
      }
    }
  }

 
}
