import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';

abstract class DropdownEvent {}

class LoadItemsEvent extends DropdownEvent {
  final List<Datums> items;
  final List<String> selectedItems;

  LoadItemsEvent(this.items, this.selectedItems);
}

class FilterItemsEvent extends DropdownEvent {
  final String query;

  FilterItemsEvent(this.query);
}

class UpdateSelectedItemEvent extends DropdownEvent {
  final String item;
  final bool isChecked;

  UpdateSelectedItemEvent(this.item, this.isChecked);
}
