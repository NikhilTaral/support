import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';

abstract class PipelineDropdownEvent {}

class LoadPipelineTypesEvent extends PipelineDropdownEvent {
  final List<Datums> items;
  final List<String> selectedItems;

  LoadPipelineTypesEvent(this.items, this.selectedItems);
}

class FilterItemsEvent extends PipelineDropdownEvent {
  final String query;

  FilterItemsEvent(this.query);
}

class UpdateSelectedItemEvent extends PipelineDropdownEvent {
  final String? item;
  final bool? isChecked;

  UpdateSelectedItemEvent({this.item, this.isChecked});
}
