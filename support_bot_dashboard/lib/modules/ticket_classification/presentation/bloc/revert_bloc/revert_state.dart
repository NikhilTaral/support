part of 'revert_bloc.dart';

abstract class RevertState {}
class RevertClassificationInitialState extends RevertState {}
class RevertClassificationLoadingState extends RevertState {}

class RevertClassificationSucessState extends RevertState {
  final RevortEntitieModel model;
  RevertClassificationSucessState({
    required this.model,
  });
}

class RevertClassificationFailureState extends RevertState {
  final String? errorMsg;

  RevertClassificationFailureState({
    this.errorMsg,
  });
}
