import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_dropdown_bloc/pipeline_dropdown_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_dropdown_bloc/pipeline_dropdown_event.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_clssification_pipeline_dropdown_bloc/ticket_clssification_pipeline_dropdown_bloc.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'dart:ui';

import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class TicketClassificationPipelineWidget extends StatelessWidget {
  final String hintText;
  final List<Datums> items;
  final String selectedItem;
  final ValueChanged<String> onChanged;

  const TicketClassificationPipelineWidget({
    Key? key,
    required this.hintText,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final dropdownBloc = TicketClssificationPipelineDropdownBloc()
          ..add(
              TicketClssificationLoadPipelineTypesEvent(items, [selectedItem]));

        showDialog(
          context: context,
          builder: (context) {
            return BlocProvider.value(
              value: dropdownBloc,
              child: Dialog(
                backgroundColor: SupportBotColors.white,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: BlocBuilder<TicketClssificationPipelineDropdownBloc,
                    TicketClssificationPipelineDropdownState>(
                  builder: (context, state) {
                    if (state
                        is TicketClssificationDropdownPipelineTypesLoadedState) {
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
                                      .read<
                                          TicketClssificationPipelineDropdownBloc>()
                                      .add(FiltersItemsEvent(query));
                                },
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.filteredItems.length,
                                itemBuilder: (context, index) {
                                  final item = state.filteredItems[index];
                                  return ListTile(
                                    title: Text(item.pipelineName ??
                                        'Unknown Pipeline'),
                                    selected: item.pipelineName == selectedItem,
                                    onTap: () {
                                      onChanged(item.pipelineName ??
                                          'Unknown Pipeline');
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
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
        child: Text(
          selectedItem.isNotEmpty ? selectedItem : hintText,
          style: const TextStyle(color: SupportBotColors.bluePrimary),
        ),
      ),
    );
  }
}
