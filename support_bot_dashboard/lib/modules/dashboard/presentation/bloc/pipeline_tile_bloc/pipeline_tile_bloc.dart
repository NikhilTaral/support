import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/pipeline_tile_request_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/pipeline_tile_response_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/pipeline_tile_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/pipeline_tile_usecase.dart';
part 'pipeline_tile_event.dart';
part 'pipeline_tile_state.dart';

class PipelineTileBloc extends Bloc<PipelineTileEvent, PipelineTileState> {
  PipelineTileAttributeModel? pipelineTileAttributeModel;

  PipelineTileBloc() : super(PipelineTileInitialState()) {
    on<PipelineTileInitialEvent>(_onPipelineTileInitialEvent);
    on<TogglePipelineChartVisibilityEvent>(_onToggleVisibilityEvent);
  }

  FutureOr<void> _onPipelineTileInitialEvent(
      PipelineTileInitialEvent event, Emitter<PipelineTileState> emit) async {
    emit(PipelineTileLoadingState());

    try {
      final repository = serviceLocator<PipelineTileUsecase>();

      final request = PipelineTileRequestModel(
        startDate: (event.startDate ?? DateTime.now())
            .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)
            .toIso8601String(),
        endDate: (event.endDate ?? DateTime.now())
            .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999)
            .toIso8601String(),
      );

      final response = await repository.invoke(request);

      if (response.isLeft) {
        emit(PipelineTileFailureState());
      } else {
        final PipelineTileResponseModel pipelineTileResponseModel =
            pipelineTileResponseModelFromJson(
                jsonEncode(response.right).toString());

        pipelineTileAttributeModel =
            mapResponseToAttributeModel(pipelineTileResponseModel);
        bool isEmpty = pipelineTileAttributeModel == null ||
            pipelineTileAttributeModel?.data?.items == null ||
            pipelineTileAttributeModel?.data?.items?.isEmpty == true;
        if (isEmpty) {
          emit(PipelineTileEmptyState());
        }

        emit(PipelineTileSuccessState(
            pipelineTileAttributeModel: pipelineTileAttributeModel));
      }
    } catch (e) {
      emit(PipelineTileFailureState());
    }
  }

  void _onToggleVisibilityEvent(TogglePipelineChartVisibilityEvent event,
      Emitter<PipelineTileState> emit) {
    if (state is PipelineTileSuccessState) {
      final currentState = state as PipelineTileSuccessState;
      emit(currentState.copyWith(isChartVisible: !currentState.isChartVisible));
    }
  }

  PipelineTileAttributeModel mapResponseToAttributeModel(
      PipelineTileResponseModel response) {
    return PipelineTileAttributeModel(
      data: response.data != null
          ? AttributeData(
              totalRecords: response.data?.totalRecords ?? 0,
              items: response.data?.items
                      ?.map((item) => AttributeItem(
                            pipelineId: item.pipelineId ?? "",
                            pipelineName: item.pipelineName ?? "",
                            totalTickets: item.totalTickets ?? 0,
                            correctTickets: item.correctTickets ?? 0,
                            incorrectTickets: item.incorrectTickets ?? 0,
                            validatedTickets: item.validatedTickets ?? 0,
                          ))
                      .toList() ??
                  [],
            )
          : null,
      success: response.success ?? false,
      failCode: response.failCode ?? 0,
      message: response.message ?? "No message",
    );
  }
}
