part of 'ai_accuracy_and_validation_trends_bloc.dart';
abstract class AiAccuracyAndValidationTrendsEvent {}
class AiAccuracyAndValidationTrendsIntialEvent extends AiAccuracyAndValidationTrendsEvent {
  final String? startDate;
  final String? endDate;
  final List<String>? piplineId;
  AiAccuracyAndValidationTrendsIntialEvent({
    this.startDate,
    this.endDate,
    this.piplineId,
  });
}
class GraphToggalEvent extends AiAccuracyAndValidationTrendsEvent {
  final String isVisible;
  GraphToggalEvent({required this.isVisible});
}