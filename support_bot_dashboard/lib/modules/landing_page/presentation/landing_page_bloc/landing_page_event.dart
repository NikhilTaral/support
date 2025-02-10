part of'landing_page_bloc.dart';
abstract class LandingPageEvent {}
class LandingPageInitialEvent extends LandingPageEvent{} 

class PipelineSelectionChangedEvent extends LandingPageEvent {
  final String selectedName;
  final List<GetAllPipelineData> items;

  PipelineSelectionChangedEvent(this.selectedName, this.items);
}