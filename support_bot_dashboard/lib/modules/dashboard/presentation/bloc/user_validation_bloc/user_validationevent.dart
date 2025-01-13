part of 'user_validation_bloc.dart';

abstract class UserValidationevent {}

class UserValidationsEvent extends UserValidationevent {
  final List<String>? selectedPipelineValue;
  final String? fildName;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  UserValidationsEvent(
      {this.fildName,
      this.selectedDate,
      this.selectedMonth,
      this.selectedPipelineValue});
}
