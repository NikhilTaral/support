part of 'revert_classification_bloc.dart';

abstract class RevertClassificationState {}

final class RevertClassificationInitialState
    extends RevertClassificationState {}

final class RevertClassificationSuccessState extends RevertClassificationState {
  RevertClassificationSuccessState();
}

final class RevertClassificationLoadingState
    extends RevertClassificationState {}

final class RevertClassificationEmptyState extends RevertClassificationState {}

final class RevertClassificationFailureState extends RevertClassificationState {
  final String message;

  RevertClassificationFailureState(this.message);
}
