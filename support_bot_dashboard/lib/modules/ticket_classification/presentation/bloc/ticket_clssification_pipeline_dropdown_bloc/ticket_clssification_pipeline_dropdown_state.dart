part of 'ticket_clssification_pipeline_dropdown_bloc.dart';

abstract class TicketClssificationPipelineDropdownState {}

class TicketClssificationPipelineDropdownInitialState
    extends TicketClssificationPipelineDropdownState {}

class TicketClssificationDropdownPipelineTypesLoadedState
    extends TicketClssificationPipelineDropdownState {
  final List<Datums> filteredItems;
  final List<String> selectedItems;

  TicketClssificationDropdownPipelineTypesLoadedState({
    required this.filteredItems,
    required this.selectedItems,
  });
}
