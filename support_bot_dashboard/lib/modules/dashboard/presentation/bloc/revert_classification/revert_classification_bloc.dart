import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/revert_classification_usecase.dart';

part 'revert_classification_event.dart';
part 'revert_classification_state.dart';

class RevertClassificationBloc
    extends Bloc<RevertClassificationEvent, RevertClassificationState> {
  bool isUpdatedToHubspot = false;
  RevertClassificationBloc() : super(RevertClassificationInitialState()) {
    on<RevertClassificationInitialEvent>(_onRevertClassificationInitialEvent);
  }

  FutureOr<void> _onRevertClassificationInitialEvent(
      RevertClassificationInitialEvent event,
      Emitter<RevertClassificationState> emit) async {
    print('loading');
    emit(RevertClassificationLoadingState());
    try {
      if (isUpdatedToHubspot == false) {
        final repository = serviceLocator<RevertClassificationUsecase>();
        await repository.invoke(event.ticketId);
        print('success');
        emit(RevertClassificationSuccessState());
      } else {
        emit(RevertClassificationFailureState(message: 'Not updated to hubspot'));
      }
    } catch (e) {
      emit(RevertClassificationFailureState(message: 'Exception occurred: $e'));
    }
  }
}
