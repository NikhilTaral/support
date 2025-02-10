import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_clssification_pipeline_dropdown_bloc/ticket_clssification_pipeline_dropdown_bloc.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
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
    final s = serviceLocator<S>();
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: const BorderSide(color: Colors.transparent, width: 1.0),
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
                                  style: SupportBotTextstyle
                                                .small
                                                .copyWith(
                                             
                                             fontWeight: FontWeight.bold,
                                            ),
                                          
                              
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: s.searchText,
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
                            const Divider(),
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: state.filteredItems.map((item) {
                                  final isSelected =
                                      selectedItem == item.pipelineName;

                                  return ListTile(
                                    title: Text(item.pipelineName ??
                                       s.unknownPipelineText),
                                    selected: isSelected,
                                    onTap: () {
                                      onChanged(item.pipelineName ??
                                         s.unknownPipelineText);
                                      Navigator.of(context).pop();
                                    },
                                  );
                                }).toList(),
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
        child: BlocBuilder<TicketClssificationPipelineDropdownBloc,
            TicketClssificationPipelineDropdownState>(
          bloc: TicketClssificationPipelineDropdownBloc()
            ..add(TicketClssificationLoadPipelineTypesEvent(
                items, [selectedItem])),
          builder: (context, state) {
            String displayedItem = hintText;
            if (selectedItem.isNotEmpty) {
              displayedItem = selectedItem;
            }
            return Text(
              displayedItem,
              style: const TextStyle(color: SupportBotColors.bluePrimary),
            );
          },
        ),
      ),
    );
  }
}
