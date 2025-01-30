part of 'revert_bloc.dart';
abstract class RevertEvent {}
class RevertClassificationEvent extends RevertEvent {
  final String? ticketId;

  RevertClassificationEvent({this.ticketId});
}