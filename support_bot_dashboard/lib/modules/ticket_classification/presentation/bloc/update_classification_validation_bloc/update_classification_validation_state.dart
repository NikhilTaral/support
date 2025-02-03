part of 'update_classification_validation_bloc.dart';

abstract class UpdateClassificationValidationState {}

class UpdateClassificationValidationIntialState
    extends UpdateClassificationValidationState {}

class UpdateClassificationValidationLoadingState
    extends UpdateClassificationValidationState {}

class UpdateClassificationValidationSuccessState
    extends UpdateClassificationValidationState {
  UpdateClassificationValidationAttributeModule? updateClassificationValidationAttributeModule;
  UpdateClassificationValidationSuccessState({this.updateClassificationValidationAttributeModule});
}

class UpdateClassificationValidationFailureState
    extends UpdateClassificationValidationState {}

class UpdateClassificationValidationEmptyState
    extends UpdateClassificationValidationState {}
