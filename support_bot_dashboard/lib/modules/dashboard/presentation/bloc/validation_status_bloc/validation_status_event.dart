part of 'validation_status_bloc.dart';

abstract class ValidationStatusEvent {}

class ValidationStatuseCallEvent extends ValidationStatusEvent {
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? selectedPipeline;
  final String? fildName;
  ValidationStatuseCallEvent(
      {this.selectedDate, this.selectedMonth, this.selectedPipeline,this.fildName});
}
