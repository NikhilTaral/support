import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/common/attribute_mapper.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/get_all_pipelines_usecase.dart';

part 'landing_page_event.dart';
part 'landing_page_state.dart';

class LandingPageBloc extends Bloc<LandingPageEvent, LandingPageState> {
  GetAllPipelinesAttributeModel attributeModel =
      GetAllPipelinesAttributeModel();
  List<String> selectedPipelineId = [];
  LandingPageBloc() : super(LandingPageIntialState()) {
    on<LandingPageInitialEvent>(_onLandingPageStartEvent);
  }
  FutureOr<void> _onLandingPageStartEvent(
      LandingPageInitialEvent event, Emitter<LandingPageState> emit) async {
    emit(LandingPageLoadingState());
    try {
      final repository = serviceLocator<GetAllPipelinesUsecase>();
      final response = await repository.invoke();

      if (response.isLeft) {
        emit(LandingPageFailureState());
      } else {
        attributeModel =
            AttributeMapper.mapGetAllPipelinesAttributeModel(response.right);
        emit(LandingPageSuccessState(
            getAllPipelinesAttributeModel: attributeModel));
      }
    } catch (e) {
      emit(LandingPageFailureState());
    }
  }
}
