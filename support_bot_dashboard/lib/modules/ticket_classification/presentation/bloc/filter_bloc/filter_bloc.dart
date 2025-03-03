import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';

part 'filkter_event.dart';
part 'fliter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final String? defualtPipeline;
  FilterBloc({this.defualtPipeline}) : super(FliterInitialState()) {
    on<FilterInitialEvent>(
      (event, emit) {
        emit(FilterSuccessState());
      },
    );
    on<SelcetPiplineEvent>(_onSelcetPiplineEvent);
    on<SelecrtDateRangeEvent>(_onSelectDateRangeEvent);
    on<ApplyFilterEvent>(_onApplyFilterEvent);
    on<SelectBopsStateEvent>(_onSelectBopsStateEvent);
    on<AIClassificationEvent>(_onAIClassificationEvent);
    on<ValidationEvent>(_onValidationEvent);
    on<UserValidationEvent>(_onUserValidationEvent);
    on<ClearFilterEvent>(_onClearFilterEvent);
  }

  FutureOr<void> _onSelcetPiplineEvent(
      SelcetPiplineEvent event, Emitter<FilterState> emit) async {
    try {
      List<GetAllPipelineData> updatedItems =
          await _fetchPipelineData(event.piplineName ?? "");

      if (state is FilterSuccessState) {
        final currentState = state as FilterSuccessState;

        emit(currentState.copyWith(
          piplineName: event.piplineName ?? currentState.piplineName,
          piplineId: event.pipelineId ?? currentState.piplineId,
          items: updatedItems.isNotEmpty ? updatedItems : currentState.items,
        ));
      }
    } catch (e) {
      emit(FliterFailureState());
    }
  }

  Future<List<GetAllPipelineData>> _fetchPipelineData(
      String selectedName) async {
    await "";

    return [];
  }

  FutureOr<void> _onSelectDateRangeEvent(
      SelecrtDateRangeEvent event, Emitter<FilterState> emit) async {
    try {
      if (state is FilterSuccessState) {
        final currentState = state as FilterSuccessState;
        emit(currentState.copyWith(
          startDate: event.startDate ?? currentState.startDate,
          endDate: event.endDate ?? currentState.endDate,
        ));
      }
    } catch (e) {
      emit(FliterFailureState());
    }
  }

  FutureOr<void> _onSelectBopsStateEvent(
      SelectBopsStateEvent event, Emitter<FilterState> emit) {
    try {
      if (state is FilterSuccessState) {
        final currentState = state as FilterSuccessState;
        emit(currentState.copyWith(bopsState: event.bopsState));
      }
    } catch (e) {
      emit(FliterFailureState());
    }
  }

  FutureOr<void> _onAIClassificationEvent(
      AIClassificationEvent event, Emitter<FilterState> emit) async {
    try {
      if (state is FilterSuccessState) {
        final currentState = state as FilterSuccessState;
        emit(currentState.copyWith(aiClassification: event.aiClassification));
      }
    } catch (e) {
      emit(FliterFailureState());
    }
  }

  FutureOr<void> _onValidationEvent(
      ValidationEvent event, Emitter<FilterState> emit) async {
    try {
      if (state is FilterSuccessState) {
        final currentState = state as FilterSuccessState;
        emit(currentState.copyWith(validation: event.validation));
      }
    } catch (e) {
      emit(FliterFailureState());
    }
  }

  FutureOr<void> _onUserValidationEvent(
      UserValidationEvent event, Emitter<FilterState> emit) async {
    try {
      if (state is FilterSuccessState) {
        final currentState = state as FilterSuccessState;
        emit(currentState.copyWith(
            selectedUserName: event.selectedUserName,
            selectedUserId: event.selectedUserEmail));
      }
    } catch (e) {
      emit(FliterFailureState());
    }
  }

  FutureOr<void> _onApplyFilterEvent(
      ApplyFilterEvent event, Emitter<FilterState> emit) async {
    try {
      if (state is FilterSuccessState) {
        final currentState = state as FilterSuccessState;
        emit(currentState.copyWith(
          aiClassification: currentState.aiClassification,
          bopsState: currentState.bopsState,
          endDate: currentState.endDate,
          items: currentState.items,
          piplineId: currentState.piplineId,
          piplineName: currentState.piplineName,
          selectedUserId: currentState.selectedUserId,
          selectedUserName: currentState.selectedUserName,
          startDate: currentState.startDate,
          validation: currentState.validation,
        ));

        emit(ApplyFilterState(
          aiClassification: currentState.aiClassification,
          bopsState: currentState.bopsState,
          endDate: currentState.endDate,
          items: currentState.items,
          piplineId: currentState.piplineId,
          piplineName: currentState.piplineName,
          selectedUserId: currentState.selectedUserId,
          selectedUserName: currentState.selectedUserName,
          startDate: currentState.startDate,
          validation: currentState.validation,
        ));
      }
    } catch (e) {
      emit(FliterFailureState());
    }
  }

  FutureOr<void> _onClearFilterEvent(
      ClearFilterEvent event, Emitter<FilterState> emit) async {
    try {
      if (state is FilterSuccessState) {
        final currentState = state as FilterSuccessState;
        emit(currentState.copyWith(
          aiClassification: "",
          bopsState: "",
          endDate: currentState.endDate,
          items: [],
          piplineId: "",
          piplineName: "",
          selectedUserId: "",
          selectedUserName: "",
          startDate: currentState.startDate,
          validation: "",
        ));
      }
    } catch (e) {
      emit(FliterFailureState());
    }
  }
}
