part of 'get_all_validation_user_bloc.dart';

abstract class GetAllValidationUsersState {}

class GetAllValidationUsersInitialState extends GetAllValidationUsersState {}

class GetAllValidationUsersLoadingState extends GetAllValidationUsersState {}

class GetAllValidationUsersSuccessState extends GetAllValidationUsersState {
  final GetAllValidationUsersAttributeModel?
      getAllValidationUsersAttributeModel;
  final String? email;
  final String? name;
  GetAllValidationUsersSuccessState(
      {this.getAllValidationUsersAttributeModel, this.email, this.name});
}

class GetAllValidationUsersFailureState extends GetAllValidationUsersState {}

