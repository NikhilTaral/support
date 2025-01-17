part of 'get_validation_details_bloc.dart';

abstract class GetValidationDetailsEvent {}

class GetValidationDetailsvalidateEvent extends GetValidationDetailsEvent {
  final String? id;
  GetValidationDetailsvalidateEvent({this.id});
}
