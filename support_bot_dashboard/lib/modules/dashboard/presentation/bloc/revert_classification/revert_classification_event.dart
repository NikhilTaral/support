part of 'revert_classification_bloc.dart';

abstract class RevertClassificationEvent {}

class RevertClassificationInitialEvent extends RevertClassificationEvent {
  String ticketid;
  RevertClassificationInitialEvent({required this.ticketid});
}
