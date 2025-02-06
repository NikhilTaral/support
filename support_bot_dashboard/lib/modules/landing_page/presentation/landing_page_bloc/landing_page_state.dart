part of 'landing_page_bloc.dart';

abstract class LandingPageState {}

class LandingPageIntialState extends LandingPageState {}

class LandingPageLoadingState extends LandingPageState {}

class LandingPageSuccessState extends LandingPageState {
  final List<Datums>? filteredItems;
  final List<String>? selectedItems;

  final GetAllPipelinesAttributeModel? getAllPipelinesAttributeModel;
  LandingPageSuccessState({
    this.getAllPipelinesAttributeModel,
     this.filteredItems,
     this.selectedItems,
  });
}

class LandingPageEmptyState extends LandingPageState {}

class LandingPageFailureState extends LandingPageState {}
