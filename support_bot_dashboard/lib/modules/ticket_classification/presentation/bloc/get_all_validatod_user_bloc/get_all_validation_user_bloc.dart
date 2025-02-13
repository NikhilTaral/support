import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/get_all_validation_users_response_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/get_all_validation_users_request_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/get_all_validation_users_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/usecases/common_ticket_classification_usecases.dart';
import 'package:support_bot_dashboard/utils/log.dart';

part 'get_all_validation_user_event.dart';
part 'get_all_validation_user_state.dart';

class GetAllValidationUsersBloc
    extends Bloc<GetAllValidationUsersEvent, GetAllValidationUsersState> {
  GetAllValidationUsersAttributeModel? getAllValidationUsersAttributeModel =
      GetAllValidationUsersAttributeModel();
  GetAllValidationUsersBloc() : super(GetAllValidationUsersInitialState()) {
    on<GetValidationUsersInitialEvent>(_onGetAllValidationUsersInitialEvent);
    on<SetUserNameEvent>(_onSetUserNameEvent);
  }
  FutureOr<void> _onSetUserNameEvent(
      SetUserNameEvent event, Emitter<GetAllValidationUsersState> emit) async {
    if (state is GetAllValidationUsersSuccessState) {
      emit(GetAllValidationUsersSuccessState(
        getAllValidationUsersAttributeModel:
            getAllValidationUsersAttributeModel,
        email: event.email,
        name: event.name,
      ));
    }
  }

  FutureOr<void> _onGetAllValidationUsersInitialEvent(
      GetValidationUsersInitialEvent event,
      Emitter<GetAllValidationUsersState> emit) async {
    emit(GetAllValidationUsersLoadingState());
    try {
      final repository = serviceLocator<GetAllValidationUserUsecase>();
      final req = GetAllValidationUsersRequestModel(
        endDate: event.endDate ??
            DateTime.now()
                .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999),
        startDate: event.startDate ??
            DateTime.now()
                .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0),
        filter: [Filter(fieldName: "pipelines", fieldValue: event.filter)],
      );
      final response = await repository.invoke(req);
      if (response.isLeft) {
        emit(GetAllValidationUsersFailureState());
      } else {
        getAllValidationUsersAttributeModel =
            GetAllValidationUsersAttributeModel(
                data: response.right.data
                    ?.map((e) => UserDetails(
                          email: e.email ?? "",
                          name: e.name ?? "",
                        ))
                    .toList(),
                );
        emit(GetAllValidationUsersSuccessState(
            getAllValidationUsersAttributeModel:
                getAllValidationUsersAttributeModel));
      }
    } catch (e) {
      Log.error("Caught Exception: $e", e);
      emit(GetAllValidationUsersFailureState());
    }
  }
}
