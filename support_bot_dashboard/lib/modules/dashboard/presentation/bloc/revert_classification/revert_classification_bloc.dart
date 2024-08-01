import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/revert_classification_usecase.dart';

part 'revert_classification_event.dart';
part 'revert_classification_state.dart';

class RevertClassificationBloc
    extends Bloc<RevertClassificationEvent, RevertClassificationState> {
  RevertClassificationBloc() : super(RevertClassificationInitialState()) {
    on<RevertClassificationInitialEvent>(_onRevertClassificationInitialEvent);
  }

  FutureOr<void> _onRevertClassificationInitialEvent(
      RevertClassificationInitialEvent event,
      Emitter<RevertClassificationState> emit) async {
    emit(RevertClassificationLoadingState());
    try {
      final repository = serviceLocator<RevertClassificationUsecase>();
      await repository.invoke(event.ticketid);
      emit(RevertClassificationSuccessState());
    } catch (e) {
      emit(RevertClassificationFailureState('Exception occurred: $e'));
    }
  }
}
