part of 'revert_classification_bloc.dart';

abstract class RevertClassificationEvent {}

class RevertClassificationInitialEvent extends RevertClassificationEvent {
  String ticketId;
  RevertClassificationInitialEvent({required this.ticketId});
}
