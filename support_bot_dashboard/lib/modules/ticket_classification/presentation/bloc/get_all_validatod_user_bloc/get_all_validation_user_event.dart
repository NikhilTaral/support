part of 'get_all_validation_user_bloc.dart';

abstract class GetAllValidationUsersEvent {}

class GetValidationUsersInitialEvent extends GetAllValidationUsersEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String>? filter;
  GetValidationUsersInitialEvent({this.endDate, this.filter, this.startDate});
}

class SetUserNameEvent extends GetAllValidationUsersEvent {
  final String? email;
  final String? name;
  SetUserNameEvent({this.email,this.name});
}
