part of 'validation_status_bloc.dart';

abstract class ValidationStatusEvent {}

class ValidationStatuseCallEvent extends ValidationStatusEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final List<String>? selectedPipelineValue;
  final String? fildName;
  ValidationStatuseCallEvent(
      {this.selectedDate,
      this.selectedMonth,
      this.selectedPipelineValue,
      this.fildName});
}
