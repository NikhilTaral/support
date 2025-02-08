import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_dropdown_bloc/pipeline_dropdown_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_dropdown_bloc/pipeline_dropdown_event.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_dropdown_bloc/pipeline_dropdown_state.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class DropdownWithCheckbox extends StatelessWidget {
  final String hintText;
  final List<Datums> items;
  final List<String> selectedItems;
  final ValueChanged<List<String>> onChanged;

  const DropdownWithCheckbox({
    Key? key,
    required this.hintText,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final dropdownBloc = PipelineDropdownBloc()
          ..add(LoadPipelineTypesEvent(items, selectedItems));

        showDialog(
          context: context,
          builder: (context) {
            return BlocProvider.value(
              value: dropdownBloc,
              child: Dialog(
                backgroundColor: SupportBotColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: const BorderSide(color: Colors.transparent, width: 1.0),
                ),
                child: BlocBuilder<PipelineDropdownBloc, PipelineDropdownState>(
                  builder: (context, state) {
                    if (state is DropdownPipelineTypesLoadedState) {
                      return SizedBox(
                        height: 500,
                        width: 400,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                hintText,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  prefixIcon: const Icon(Icons.search),
                                ),
                                onChanged: (query) {
                                  context
                                      .read<PipelineDropdownBloc>()
                                      .add(FilterItemsEvent(query));
                                },
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: state.filteredItems.map((item) {
                                  final isSelected = state.selectedItems
                                      .contains(item.pipelineName);
                                  return CheckboxListTile(
                                    activeColor: SupportBotColors.bluePrimary,
                                    value: isSelected,
                                    title: Text(item.pipelineName ?? ""),
                                    onChanged: (bool? isChecked) {
                                      if (isChecked != null) {
                                        context
                                            .read<PipelineDropdownBloc>()
                                            .add(
                                              UpdateSelectedItemEvent(
                                                item: item.pipelineName ?? "",
                                                isChecked: isChecked,
                                              ),
                                            );
                                      }
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      SupportBotColors.bluePrimary),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  onChanged(state.selectedItems);
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'OK',
                                  style:
                                      TextStyle(color: SupportBotColors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            );
          },
        );
      },
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.only(left: 10, right: 30),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: SupportBotColors.bluePrimary),
          ),
          suffixIcon: const Icon(
            SupportBotIcons.arrowDown14,
            size: 20,
            color: SupportBotColors.bluePrimary,
          ),
          hintStyle: SupportBotTextstyle.hint
              .copyWith(color: SupportBotColors.bluePrimary),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: SupportBotColors.bluePrimary),
          ),
        ),
        child: BlocBuilder<PipelineDropdownBloc, PipelineDropdownState>(
          bloc: PipelineDropdownBloc()
            ..add(LoadPipelineTypesEvent(items, selectedItems)),
          builder: (context, state) {
            final displayedItems =
                selectedItems.isNotEmpty ? selectedItems.join(', ') : hintText;
            return const Text("Select Pipeline",
                style: TextStyle(color: SupportBotColors.bluePrimary));
          },
        ),
      ),
    );
  }
}
