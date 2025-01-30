import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/bops_state_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/bops_state_entitie_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/usecases/common_ticket_classification_usecases.dart';

part 'bops_states__event.dart';
part 'bops_states_state.dart';

class BopsStatesBloc extends Bloc<BopsStateEvent, BopsStatesState> {
  BOpsResponseEntitieModel bOpsResponseEntitieModel =
      BOpsResponseEntitieModel();

  BopsStatesBloc() : super(BopsStatesIntialState()) {
    on<BopsStateDataEvent>(_onBopsStateDataEvent);
  }

  FutureOr<void> _onBopsStateDataEvent(
      BopsStateDataEvent event, Emitter<BopsStatesState> emit) async {
    try {
      emit(BopsStatesLoadingState());
      final repository = serviceLocator<BopsUsecases>();
      final response = await repository.invoke();
      if (response is Left) {
        emit(BopsStatesFailureState());
      } else {
        final BOpsResponseModel model = response.right;

        bOpsResponseEntitieModel = BOpsResponseEntitieModel(
          data: model.data,
          failCode: model.failCode,
          message: model.message,
        );

        emit(BopsStatesSucssesState(model: bOpsResponseEntitieModel));
      }
    } catch (e) {
      emit(BopsStatesFailureState());
    }
  }
}
