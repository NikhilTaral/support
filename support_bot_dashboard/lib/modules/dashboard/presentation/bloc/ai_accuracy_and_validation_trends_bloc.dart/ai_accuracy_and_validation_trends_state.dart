part of 'ai_accuracy_and_validation_trends_bloc.dart';

abstract class AiAccuracyAndValidationTrendsState {}

class AiAccuracyAndValidationTrendsIntialState
    extends AiAccuracyAndValidationTrendsState {}

class AiAccuracyAndValidationTrendsLoadingState
    extends AiAccuracyAndValidationTrendsState {}

class AiAccuracyAndValidationTrendsEmptyState
    extends AiAccuracyAndValidationTrendsState {}

class AiAccuracyAndValidationTrendsSucssesState
    extends AiAccuracyAndValidationTrendsState {
  final AiAccuracyAndValidationTrendsAttributeModel? model;
  final String? isVisible;
  AiAccuracyAndValidationTrendsSucssesState({this.model,this.isVisible});
}

class AiAccuracyAndValidationTrendsFailureState
    extends AiAccuracyAndValidationTrendsState {}
