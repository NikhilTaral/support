part of 'export_bloc.dart';

abstract class ExportState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExportInitial extends ExportState {}

class ExportLoadingState extends ExportState {}

class ExportSuccessState extends ExportState {}

class ExportFailureState extends ExportState {
  final String message;
  
  ExportFailureState({required this.message});
  
  @override
  List<Object?> get props => [message];
}