part of 'user_validation_bloc.dart';

abstract class UservalidationState {}

class UserValidationIntialState extends UservalidationState {}

class UserValidationLoadingState extends UservalidationState {}

class UserValidationEmptyState extends UservalidationState {}

class UserValidationSucssesState extends UservalidationState {
  final DashboardDataModel? dashboardDataModel;
  UserValidationSucssesState({required this.dashboardDataModel});
}

class UserValidationFailureSate extends UservalidationState {
  final String message;

  UserValidationFailureSate({
    required this.message,
  });
}
