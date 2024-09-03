import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_pipeline_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_pipeline_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_pipeline_usecase.dart';

part 'dashboard_pipeline_event.dart';
part 'dashboard_pipeline_state.dart';

class DashboardPipelineBloc
    extends Bloc<DashboardPipelineEvent, DashboardPipelineState> {
  DashboardPipelineBloc() : super(DashboardPipelineInitial()) {
    on<FilterPipelineEvent>(_onFilterPipelineEvent);
    on<UpdateSelectedPipelineEvent>(_onUpdateSelectedPipelineEvent);
  }
  late DashboardPipelineAttributeModel dashboardPipelineAttributeModel;
  FutureOr<void> _onFilterPipelineEvent(
      FilterPipelineEvent event, Emitter<DashboardPipelineState> emit) async {
    emit(DashboardPipelineLoading());
    final respository = serviceLocator<DashboardPipelineUsecase>();
    final response = await respository.invoke();
    if (response.isLeft) {
      emit(DashboardPipelineFailure(message: 'Failed to fetch'));
    } else {
      try {
        print('print 1');
        final model = DashboardPipelineResponseModel.fromJson(
            json.decode(response.right));
        print('print 2');
        dashboardPipelineAttributeModel = DashboardPipelineAttributeModel(
            data: model.data
                .map((p) => PipelineAttribute(
                    pipelineId: p.pipelineId, pipelineName: p.pipelineName))
                .toList());
        emit(DashboardPipelineSuccess(
            dashboardPipelineAttributeModel: dashboardPipelineAttributeModel,
            selectedPipelineValue: event.selectedPipeline,
            selectedDate: event.selectedDate,
            selectedMonth: event.selectedMonth));
      } catch (e) {
        print(e);
        emit(DashboardPipelineFailure(message: 'Exception $e'));
      }
    }
  }

  FutureOr<void> _onUpdateSelectedPipelineEvent(
      UpdateSelectedPipelineEvent event, Emitter<DashboardPipelineState> emit) {
    emit(DashboardPipelineSuccess(
        selectedPipelineValue: event.selectedPipelineValue,
        dashboardPipelineAttributeModel: dashboardPipelineAttributeModel,
        selectedDate: event.selectedDate,
        selectedMonth: event.selectedMonth));
  }
}
