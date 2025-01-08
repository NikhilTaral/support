part of 'validation_status_bloc.dart';

abstract class ValidationStatusState {}

class ValidationStatusInitialState extends ValidationStatusState {}

class ValidationStatusLodingState extends ValidationStatusState {}

class ValidationStatusSucssesState extends ValidationStatusState {
  final ValidationStatusAttributeModel? attributeModel;
  ValidationStatusSucssesState({this.attributeModel});
}

class VsalidationStatusFailureState extends ValidationStatusState {}
