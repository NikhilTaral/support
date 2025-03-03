part of 'filter_bloc.dart';

abstract class FilterState {}

class FliterInitialState extends FilterState {}

class FliterLoadingState extends FilterState {}

class FilterSuccessState extends FilterState {
  final String? piplineName;
  final String? piplineId;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<GetAllPipelineData>? items;
  final String? bopsState;
  final String? aiClassification;
  final String? validation;
  final String? selectedUserName;
  final String? selectedUserId;

  FilterSuccessState(
      {this.piplineName,
      this.piplineId,
      this.startDate,
      this.endDate,
      this.items,
      this.bopsState,
      this.aiClassification,
      this.validation,
      this.selectedUserName,
      this.selectedUserId});
  FilterSuccessState copyWith({
    String? aiClassification,
    String? bopsState,
    DateTime? endDate,
    DateTime? startDate,
    String? piplineId,
    String? piplineName,
    List<GetAllPipelineData>? items,
    String? selectedUserId,
    String? selectedUserName,
    String? validation,
  }) {
    return FilterSuccessState(
      aiClassification: aiClassification ?? this.aiClassification,
      bopsState: bopsState ?? this.bopsState,
      endDate: endDate ?? this.endDate,
      startDate: startDate ?? this.startDate,
      piplineId: piplineId ?? this.piplineId,
      piplineName: piplineName ?? this.piplineName,
      items: items ?? this.items,
      selectedUserId: selectedUserId ?? this.selectedUserId,
      selectedUserName: selectedUserName ?? this.selectedUserName,
      validation: validation ?? this.validation,
    );
  }
}

class FliterFailureState extends FilterState {}

class FilterEmptyState extends FilterState {}

class ApplyFilterState extends FilterState {
  final String? piplineName;
  final String? piplineId;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<GetAllPipelineData>? items;
  final String? bopsState;
  final String? aiClassification;
  final String? validation;
  final String? selectedUserName;
  final String? selectedUserId;
  ApplyFilterState(
      {this.piplineName,
      this.piplineId,
      this.startDate,
      this.endDate,
      this.items,
      this.bopsState,
      this.aiClassification,
      this.validation,
      this.selectedUserName,
      this.selectedUserId});
}

class ClearFilterState extends FilterState {
  final String? piplineName;
  final String? piplineId;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<GetAllPipelineData>? items;
  final String? bopsState;
  final String? aiClassification;
  final String? validation;
  final String? selectedUserName;
  final String? selectedUserId;
  ClearFilterState({
    this.piplineName,
    this.piplineId,
    this.startDate,
    this.endDate,
    this.items,
    this.bopsState,
    this.aiClassification,
    this.validation,
    this.selectedUserName,
    this.selectedUserId,
  });
}
