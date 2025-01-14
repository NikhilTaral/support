part of 'validation_status_bloc.dart';

abstract class ValidationStatusState {}

class ValidationStatusInitialState extends ValidationStatusState {}

class ValidationStatusLoadingState extends ValidationStatusState {}

class ValidationStatusEmptyState extends ValidationStatusState {}

class ValidationStatusSucssesState extends ValidationStatusState {
  final ValidationStatusAttributeModel? attributeModel;
  ValidationStatusSucssesState({this.attributeModel});
}

class ValidationStatusFailureState extends ValidationStatusState {}
