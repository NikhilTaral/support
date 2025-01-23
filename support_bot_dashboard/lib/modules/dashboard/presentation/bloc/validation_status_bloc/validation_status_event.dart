part of 'validation_status_bloc.dart';

abstract class ValidationStatusEvent {}

class ValidationStatuseCallEvent extends ValidationStatusEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String>? selectedPipelineValue;
  final String? fildName;
  ValidationStatuseCallEvent(
      {this.startDate,
      this.endDate,
      this.selectedPipelineValue,
      this.fildName});
}
