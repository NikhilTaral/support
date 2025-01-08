part of 'ticket_classification_bloc.dart';

abstract class TicketClassificationState {}

class TicketClassificationInitialState extends TicketClassificationState {}

class TicketClassificationLoadingState extends TicketClassificationState {}

class TicketClassificationSucssesState extends TicketClassificationState {
  final DashboardDataModel? dashboardDataModel;
  TicketClassificationSucssesState({this.dashboardDataModel});
}

class TicketClassificationFailureState extends TicketClassificationState {
  final String message;
  final DateTime selectedDate;
  final DateTime selectedMonth;
  TicketClassificationFailureState(
      {required this.message,
      required this.selectedDate,
      required this.selectedMonth});
}
