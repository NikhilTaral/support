part of 'filter_bloc.dart';

abstract class FilterEvent {}

class FilterInitialEvent extends FilterEvent {}

class SelcetPiplineEvent extends FilterEvent {
  final String? piplineName;
  final String? pipelineId;
  SelcetPiplineEvent({this.piplineName, this.pipelineId});
}

class SelecrtDateRangeEvent extends FilterEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  SelecrtDateRangeEvent({this.startDate, this.endDate});
}

class SelectBopsStateEvent extends FilterEvent {
  final String? bopsState;
  SelectBopsStateEvent({this.bopsState});
}

class AIClassificationEvent extends FilterEvent {
  final String? aiClassification;
  AIClassificationEvent({this.aiClassification});
}

class ValidationEvent extends FilterEvent {
  final String? validation;
  ValidationEvent({this.validation});
}

class UserValidationEvent extends FilterEvent {
  final String? selectedUserName;
  final String? selectedUserEmail;

  UserValidationEvent({this.selectedUserName, this.selectedUserEmail});
}

class ApplyFilterEvent extends FilterEvent {}

class ClearFilterEvent extends FilterEvent {}

class ToggleSearchEvent extends FilterEvent {
  final bool isSearchOpen;
  final String searchText;
  final String? value;
  ToggleSearchEvent(
      {required this.isSearchOpen, required this.searchText, this.value});
}
