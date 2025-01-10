import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';

abstract class PipelineDropdownState {}

class PipelineDropdownInitialState extends PipelineDropdownState {}

class PipelineDropdownLoadedState extends PipelineDropdownState {
  final List<Datums> filteredItems;
  final List<String> selectedItems;

  PipelineDropdownLoadedState({
    required this.filteredItems,
    required this.selectedItems,
  });
}
