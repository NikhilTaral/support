import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';

part 'ticket_clssification_pipeline_dropdown_event.dart';
part 'ticket_clssification_pipeline_dropdown_state.dart';

class TicketClssificationPipelineDropdownBloc extends Bloc<
    TicketClssificationPipelineDropdownEvent,
    TicketClssificationPipelineDropdownState> {
  List<GetAllPipelineData> _items = [];
  List<String> selectedItems = [];

  TicketClssificationPipelineDropdownBloc()
      : super(TicketClssificationPipelineDropdownInitialState()) {
    on<TicketClssificationLoadPipelineTypesEvent>(
        _onTicketClssificationLoadPipelineTypesEvent);
    on<TicketClssificationFilterItemsEvent>(
        _onTicketClssificationFilterItemsEvent);
    on<TicketClssificationUpdateSelectedItemEvent>(
        _onTicketClssificationUpdateSelectedItemEvent);
    on<FiltersItemsEvent>(_onFilterItemsEvent);
  }

  Future<void> _onTicketClssificationLoadPipelineTypesEvent(
      TicketClssificationLoadPipelineTypesEvent event,
      Emitter<TicketClssificationPipelineDropdownState> emit) async {
    _items = event.items;
    selectedItems = List<String>.from(event.selectedItems);

    emit(TicketClssificationDropdownPipelineTypesLoadedState(
      filteredItems: _items,
      selectedItems: selectedItems,
    ));
  }

  Future<void> _onFilterItemsEvent(FiltersItemsEvent event,
      Emitter<TicketClssificationPipelineDropdownState> emit) async {
    final filteredItems = _filterItems(event.query);

    emit(TicketClssificationDropdownPipelineTypesLoadedState(
      filteredItems: filteredItems,
      selectedItems: selectedItems,
    ));
  }

  Future<void> _onTicketClssificationFilterItemsEvent(
      TicketClssificationFilterItemsEvent event,
      Emitter<TicketClssificationPipelineDropdownState> emit) async {
    final filteredItems = _filterItems(event.query);

    emit(TicketClssificationDropdownPipelineTypesLoadedState(
      filteredItems: filteredItems,
      selectedItems: selectedItems,
    ));
  }

  Future<void> _onTicketClssificationUpdateSelectedItemEvent(
      TicketClssificationUpdateSelectedItemEvent event,
      Emitter<TicketClssificationPipelineDropdownState> emit) async {
    if (event.isChecked == true) {
      if (event.item?.isNotEmpty == true && event.item != null) {
        _addSelectedItem(event.item!);
      }
    } else {
      if (event.item?.isNotEmpty == true && event.item != null) {
        _removeSelectedItem(event.item!);
      }
    }
    emit(TicketClssificationDropdownPipelineTypesLoadedState(
      filteredItems: _items,
      selectedItems: selectedItems,
    ));
  }

  List<GetAllPipelineData> _filterItems(String query) {
    return _items
        .where((item) =>
            item.pipelineName
                ?.toLowerCase()
                .contains(query.trim().toLowerCase()) ??
            false)
        .toList();
  }

  void _addSelectedItem(String item) {
    if (!selectedItems.contains(item)) {
      selectedItems.add(item);
    }
  }

  void _removeSelectedItem(String item) {
    selectedItems.remove(item);
  }
}
