part of 'ticket_classification_action_bloc.dart';

abstract class TicketClassificationActionState {}

class RevertClassificationInitialState
    extends TicketClassificationActionState {}

class RevertClassificationLoadingState
    extends TicketClassificationActionState {}

class RevertClassificationSuccessState extends TicketClassificationActionState {
  final RevertAttributeModel model;
  RevertClassificationSuccessState({
    required this.model,
  });
}

class RevertClassificationFailureState extends TicketClassificationActionState {
  final String? errorMsg;

  RevertClassificationFailureState({
    this.errorMsg,
  });
}

class UpdateClassificationInitialState
    extends TicketClassificationActionState {}

class UpdateClassificationLoadingState
    extends TicketClassificationActionState {}

class UpdateClassificationSuccessState extends TicketClassificationActionState {
  final TicketClassificationActionAttributeModel?
      ticketClassificationActionAttributeModel;
  UpdateClassificationSuccessState(
      {this.ticketClassificationActionAttributeModel});
}

class UpdateClassificationFailureState
    extends TicketClassificationActionState {}
