part of 'update_classification_validation_bloc.dart';

abstract class UpdateClassificationValidationState {}

class UpdateClassificationValidationIntialState
    extends UpdateClassificationValidationState {}

class UpdateClassificationValidationLoadingState
    extends UpdateClassificationValidationState {}

class UpdateClassificationValidationSucssesState
    extends UpdateClassificationValidationState {
  UpdateClassificationValidationEntitieModule? model;
  UpdateClassificationValidationSucssesState({this.model});
}

class UpdateClassificationValidationFailureState
    extends UpdateClassificationValidationState {}

class UpdateClassificationValidationEmptyState
    extends UpdateClassificationValidationState {}
