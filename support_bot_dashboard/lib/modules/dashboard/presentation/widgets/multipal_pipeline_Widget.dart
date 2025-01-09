import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/Pipline_bloc/bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/Pipline_bloc/event.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/Pipline_bloc/state.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'dart:ui';

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
        final dropdownBloc = DropdownBloc()
          ..add(LoadItemsEvent(items, selectedItems));

        showDialog(
          context: context,
          builder: (context) {
            return BlocProvider.value(
              value: dropdownBloc,
              child: Dialog(
                backgroundColor: SupportBotColors.white,
                child: BlocBuilder<DropdownBloc, DropdownState>(
                  builder: (context, state) {
                    if (state is DropdownLoadedState) {
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
                                      .read<DropdownBloc>()
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
                                    value: isSelected,
                                    title: Text(item.pipelineName ?? ""),
                                    onChanged: (bool? isChecked) {
                                      if (isChecked != null) {
                                        context.read<DropdownBloc>().add(
                                              UpdateSelectedItemEvent(
                                                item.pipelineName ?? "",
                                                isChecked,
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
                                  'Submit',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: SupportBotColors.bluePrimary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: SupportBotColors.bluePrimary),
          ),
        ),
        child: BlocBuilder<DropdownBloc, DropdownState>(
          bloc: DropdownBloc()..add(LoadItemsEvent(items, selectedItems)),
          builder: (context, state) {
            final displayedItems =
                selectedItems.isNotEmpty ? selectedItems.join(', ') : hintText;
            return Text(displayedItems,
                style: const TextStyle(color: Colors.black));
          },
        ),
      ),
    );
  }
}
