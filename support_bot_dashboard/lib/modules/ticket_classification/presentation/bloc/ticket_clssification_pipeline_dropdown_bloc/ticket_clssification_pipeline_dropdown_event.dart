part of 'ticket_clssification_pipeline_dropdown_bloc.dart';

abstract class TicketClssificationPipelineDropdownEvent {}

class TicketClssificationLoadPipelineTypesEvent
    extends TicketClssificationPipelineDropdownEvent {
  final List<GetAllPipelineData> items;
  final List<String> selectedItems;

  TicketClssificationLoadPipelineTypesEvent(this.items, this.selectedItems);
}

class TicketClssificationFilterItemsEvent
    extends TicketClssificationPipelineDropdownEvent {
  final String query;

  TicketClssificationFilterItemsEvent(this.query);
}

class FiltersItemsEvent extends TicketClssificationPipelineDropdownEvent {
  final String query;

  FiltersItemsEvent(this.query);
}

class TicketClssificationUpdateSelectedItemEvent
    extends TicketClssificationPipelineDropdownEvent {
  final String? item;
  final bool? isChecked;

  TicketClssificationUpdateSelectedItemEvent({this.item, this.isChecked});
}
