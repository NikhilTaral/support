part of 'get_validation_details_bloc.dart';

abstract class GetValidationDetailsState {}

class GetValidationDetailsIntialState extends GetValidationDetailsState {}

class GetValidationDetailsSucssesState extends GetValidationDetailsState {
  final GetValidationDetailsEntiterModel? getValidationDetailsEntiterModel;
  GetValidationDetailsSucssesState({this.getValidationDetailsEntiterModel});
}

class GetValidationDetailsFailureState extends GetValidationDetailsState {}

class GetValidationDetailsLoadedState extends GetValidationDetailsState {}

class GetValidationDetailsEmptyState extends GetValidationDetailsState {}
