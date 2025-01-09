import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';

abstract class DropdownState {}

class DropdownInitialState extends DropdownState {}

class DropdownLoadedState extends DropdownState {
  final List<Datums> filteredItems;
  final List<String> selectedItems;

  DropdownLoadedState({
    required this.filteredItems,
    required this.selectedItems,
  });
}
