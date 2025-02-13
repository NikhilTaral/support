import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/common/attribute_mapper.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/get_all_pipelines_usecase.dart';

part 'get_all_pipeline_event.dart';
part 'get_all_pipeline_state.dart';

class GetAllPipelineBloc
    extends Bloc<GetAllPipelineEvent, GetAllPipelineState> {
  GetAllPipelineBloc() : super(GetAllPipelineInitialState()) {
    on<GetAllPiplineInitialEvent>(_onGetAllPipline);
    
  }

  FutureOr<void> _onGetAllPipline(GetAllPiplineInitialEvent event,
      Emitter<GetAllPipelineState> emit) async {
    emit(GetAllPipelineLoadingState());
    try {
      final repository = serviceLocator<GetAllPipelinesUsecase>();
      final response = await repository.invoke();

      if (response.isLeft) {
        emit(GetAllPipelineFailureState());
      } else {
        try {
          final GetAllPipelinesAttributeModel attributeModel =
              AttributeMapper.mapGetAllPipelinesAttributeModel(response.right);
          emit(GetAllAllPipelineSuccessState(attributeModel: attributeModel));
        } catch (e) {
          emit(GetAllPipelineFailureState());
        }
      }
    } catch (e) {
      emit(GetAllPipelineFailureState());
    }
  }
}
