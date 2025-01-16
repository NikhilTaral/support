import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/common/attribute_mapper.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/get_all_pipelines_usecase.dart';

part 'get_all_pipelines_event.dart';
part 'get_all_pipelines_state.dart';

class GetAllPipelinesBloc
    extends Bloc<GetAllPipelinesEvent, GetAllPipelinesState> {
  GetAllPipelinesBloc() : super(GetAllPipelinesInitialState()) {
    on<GetAllPiplinesInitialEvent>(_onGetAllPipline);
  }

  FutureOr<void> _onGetAllPipline(GetAllPiplinesInitialEvent event,
      Emitter<GetAllPipelinesState> emit) async {
    emit(GetAllPipelinesLoadingState());
    try {
      final repository = serviceLocator<GetAllPipelinesUsecase>();
      final response = await repository.invoke();

      if (response.isLeft) {
        emit(GetAllPipelinesFailureState());
      } else {
        try {
          final GetAllPipelinesAttributeModel attributeModel =
              AttributeMapper.mapGetAllPipelinesAttributeModel(response.right);
          emit(GetAllAllPipelinesSuccessState(attributeModel: attributeModel));
        } catch (e) {
          emit(GetAllPipelinesFailureState());
        }
      }
    } catch (e) {
      emit(GetAllPipelinesFailureState());
    }
  }
}
