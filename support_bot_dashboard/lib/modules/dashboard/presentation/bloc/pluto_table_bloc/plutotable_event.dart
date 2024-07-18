part of 'plutotable_bloc.dart';

abstract class PlutotableEvent{}

class FetchTableDataEvent extends PlutotableEvent{
   final DateTime? selectedDate;
  final DateTime? selectedMonth;

  FetchTableDataEvent({required this.selectedDate, required this.selectedMonth});
}

class SelectDateEvent extends PlutotableEvent{
   final DateTime selectedDate;

  SelectDateEvent({required this.selectedDate});
}

class SelectMonthEvent extends PlutotableEvent{
  final DateTime selectedMonth;

  SelectMonthEvent({required this.selectedMonth});
}