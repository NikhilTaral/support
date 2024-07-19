part of 'plutotable_bloc.dart';

abstract class PlutotableState {}

final class PlutotableInitial extends PlutotableState {}

class FetchTableDataLoading extends PlutotableState {}

class FetchTableDataSuccess extends PlutotableState {
  final DashboardTableAttributeModel tableData;
  final String selectedClassification;
  final String selectedValidation;
  final DateTime selectedDate;
  final DateTime selectedMonth;

  FetchTableDataSuccess(
      {required this.tableData,
      required this.selectedDate,
      required this.selectedMonth,
      required this.selectedClassification,
      required this.selectedValidation
      });
}

class FetchTableDataError extends PlutotableState {
  final String message;

  FetchTableDataError(this.message);
}

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

  UpdateValidationError(this.errorMessage);
}