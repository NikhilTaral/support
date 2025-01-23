part of 'user_validation_bloc.dart';

abstract class UserValidationevent {}

class UserValidationsEvent extends UserValidationevent {
  final List<String>? selectedPipelineValue;
  final String? fildName;
  final DateTime? startDate;
  final DateTime? endDate;
  UserValidationsEvent(
      {this.fildName,
      this.startDate,
      this.endDate,
      this.selectedPipelineValue});
}
