import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/revort_entitie_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/usecases/common_ticket_classification_usecases.dart';

part 'revert_event.dart';
part 'revert_state.dart';

class RevertBloc extends Bloc<RevertEvent, RevertState> {
  RevortEntitieModel? model = RevortEntitieModel();

  RevertBloc() : super(RevertClassificationLoadingState()) {
    on<RevertClassificationEvent>(_onRevertClassificationEvent);
  }

  FutureOr<void> _onRevertClassificationEvent(
      RevertClassificationEvent event, Emitter<RevertState> emit) async {
   emit(RevertClassificationLoadingState());
    try {
      final repository = serviceLocator<RevertClassificationUsecase>();
      final req = event.ticketId ?? "";
      final response = await repository.invoke(req);
       if (response.isLeft) {
        emit(RevertClassificationFailureState(
         
        ));
       } else {
        final model = response.right;
         final data = RevortEntitieModel(
          success: model.success,
        );
         emit(RevertClassificationSucessState(model: data));
         }
    } catch (e) {
      emit(RevertClassificationFailureState(
       
      ));
        }
  }
}
