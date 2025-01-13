import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_dropdown_bloc/pipeline_dropdown_event.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_dropdown_bloc/pipeline_dropdown_state.dart';

class PipelineDropdownBloc
    extends Bloc<PipelineDropdownEvent, PipelineDropdownState> {
  List<Datums> _items = [];
  List<String> selectedItems = [];

  PipelineDropdownBloc() : super(PipelineDropdownInitialState()) {
    on<LoadPipelineTypesEvent>(_onLoadPipelineTypesEvent);
    on<FilterItemsEvent>(_onFilterItemsEvent);
    on<UpdateSelectedItemEvent>(_onUpdateSelectedItemEvent);
  }

  Future<void> _onLoadPipelineTypesEvent(
      LoadPipelineTypesEvent event, Emitter<PipelineDropdownState> emit) async {
    _items = event.items;
    selectedItems = List<String>.from(event.selectedItems);

    emit(DropdownPipelineTypesLoadedState(
      filteredItems: _items,
      selectedItems: selectedItems,
    ));
  }

  Future<void> _onFilterItemsEvent(
      FilterItemsEvent event, Emitter<PipelineDropdownState> emit) async {
    final filteredItems = _filterItems(event.query);

    emit(DropdownPipelineTypesLoadedState(
      filteredItems: filteredItems,
      selectedItems: selectedItems,
    ));
  }

  Future<void> _onUpdateSelectedItemEvent(UpdateSelectedItemEvent event,
      Emitter<PipelineDropdownState> emit) async {
    if (event.isChecked == true) {
      if (event.item?.isNotEmpty == true && event.item != null) {
        _addSelectedItem(event.item!);
      }
    } else {
      if (event.item?.isNotEmpty == true && event.item != null) {
        _removeSelectedItem(event.item!);
      }
    }
    emit(DropdownPipelineTypesLoadedState(
      filteredItems: _items,
      selectedItems: selectedItems,
    ));
  }

  List<Datums> _filterItems(String query) {
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
