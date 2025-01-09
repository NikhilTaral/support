import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/Pipline_bloc/event.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/Pipline_bloc/state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  List<Datums> _items = [];
  List<String> _selectedItems = [];

  DropdownBloc() : super(DropdownInitialState()) {
    on<LoadItemsEvent>((event, emit) {
      _items = event.items;
      _selectedItems = List<String>.from(event.selectedItems);
      emit(DropdownLoadedState(
        filteredItems: _items,
        selectedItems: _selectedItems,
      ));
    });

    on<FilterItemsEvent>((event, emit) {

      final List<String> selectedItems;

      final filteredItems = _items
          .where((item) =>
              item.pipelineName
                  ?.toLowerCase()
                  .contains(event.query.trim().toLowerCase()) ??
              false)
          .toList();

      emit(DropdownLoadedState(
        filteredItems: filteredItems,
        selectedItems: _selectedItems,
      ));
    });

    on<UpdateSelectedItemEvent>((event, emit) {
      if (event.isChecked) {
        _selectedItems.add(event.item);
      } else {
        _selectedItems.remove(event.item);
      }
      emit(DropdownLoadedState(
        filteredItems: _items,
        selectedItems: _selectedItems,
      ));
    });
  }
}
