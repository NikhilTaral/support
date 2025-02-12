part of 'get_all_validation_user_bloc.dart';

abstract class GetAllValidationUsersState {}

class GetAllValidationUsersInitialState extends GetAllValidationUsersState {}

class GetAllValidationUsersLoadingState extends GetAllValidationUsersState {}

class GetAllValidationUsersSuccessState extends GetAllValidationUsersState {
  final GetAllValidationUsersAttributeModel?
      getAllValidationUsersAttributeModel;
  GetAllValidationUsersSuccessState({this.getAllValidationUsersAttributeModel});
}

class GetAllValidationUsersFailureState extends GetAllValidationUsersState {}

class GetAllValidationUsersSelectedState extends GetAllValidationUsersState {
  final String? email;
  final String? name;
  GetAllValidationUsersSelectedState({this.email, this.name});
}
