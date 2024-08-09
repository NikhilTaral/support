part of 'plutotable_bloc.dart';

abstract class PlutotableState {}

final class PlutotableInitial extends PlutotableState {}

class FetchTableDataLoading extends PlutotableState {}

class FetchTableDataSuccess extends PlutotableState {
  final DashboardTableAttributeModel tableData;
  final String selectedClassification;
  final String? selectedValidation;
  final DateTime selectedDate;
  final DateTime selectedMonth;
  final bool noDataAvailable;

  FetchTableDataSuccess({
    required this.tableData,
    required this.selectedDate,
    required this.selectedMonth,
    required this.selectedClassification,
     this.selectedValidation,
    required this.noDataAvailable,
  });
}

class FetchTableDataError extends PlutotableState {
  final String message;

  FetchTableDataError({required this.message});
}

class FetchTableDataEmpty extends PlutotableState {}

class UpdateDateState extends PlutotableState {
  final DateTime selectedDate;

  UpdateDateState({required this.selectedDate});
}

class UpdateMonthState extends PlutotableState {
  final DateTime selectedMonth;

  UpdateMonthState({required this.selectedMonth});
}

class UpdateValidationLoading extends PlutotableState {}

class UpdateValidationSuccess extends PlutotableState {
  final DateTime selectedDate;
  final DateTime selectedMonth;

  UpdateValidationSuccess(
      {required this.selectedDate, required this.selectedMonth});
}

class UpdateValidationError extends PlutotableState {
  final String errorMessage;

  UpdateValidationError({required this.errorMessage});
}

class CustomSidebarInitial extends PlutotableState {
  final int initialIndex;

  CustomSidebarInitial(this.initialIndex);
}

class CustomSidebarLoaded extends PlutotableState {
  final int currentIndex;

  CustomSidebarLoaded(this.currentIndex);
}
