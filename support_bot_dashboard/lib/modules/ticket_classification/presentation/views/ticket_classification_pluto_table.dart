import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/custom_pagination_dropdown.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/ticket_classification_entitie_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/widgets/ticket_classification_pluto_gride_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class TicketClassificationPlutoTable extends StatelessWidget {
  TicketClassificationPlutoTable({super.key});

  final ValueNotifier<int> currentPage = ValueNotifier<int>(1);
  final ValueNotifier<int> pageSize = ValueNotifier<int>(10);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketClassificationTabBloc, TicketClassificationState>(
      builder: (context, state) {
        debugPrint("********************* state ${state.runtimeType}");
        if (state is TicketClassificationLoadingState) {
          return Center(
              child: LoadingWidget(
            height: UIHelpers.screenHeight(context),
            width: UIHelpers.screenWidth(context),
          ));
        }
        if (state is TicketClassificationSucssesState) {
          return Column(
            children: [
              Expanded(
                child: TicketClassificationPlutoGrideWidget(
                  plutoKey: UniqueKey(),
                  ticketClassificationEntitieModel:
                      state.model ?? TicketClassificationEntitieModel(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Items per page:   ",
                          style: TextStyle(
                              color: SupportBotColors.disablePrimary.shade700,
                              fontWeight: FontWeight.w500),
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: pageSize,
                          builder: (context, value, child) {
                            return CustomPaginationDropdown(
                              selectedValue: value,
                              items: const [10, 25, 50],
                              onChanged: (value) {
                                if (value != null) {
                                  pageSize.value = value;
                                  currentPage.value = 1;

                                  context
                                      .read<TicketClassificationTabBloc>()
                                      .add(
                                        TicketClassificationDataCallEvent(
                                          startDate: state.startDate,
                                          endDate: state.endDate,
                                          page: currentPage.value,
                                          pageSize: pageSize.value,
                                        ),
                                      );
                                }
                              },
                              width: 60,
                              height: 40,
                            );
                          },
                        ),
                      ],
                    ),
                    UIHelpers.horizontalSpaceRegular,
                    Row(
                      children: [
                        Text(
                          "${(currentPage.value - 1) * pageSize.value + 1} - "
                          "${(currentPage.value * pageSize.value > (state.model?.data?.totalRecords ?? 0)) ? state.model?.data?.totalRecords ?? 0 : currentPage.value * pageSize.value} of "
                          "${state.model?.data?.totalRecords ?? 0}",
                          style: TextStyle(
                            color: SupportBotColors.disablePrimary.shade500,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: currentPage.value > 1
                              ? () {
                                  currentPage.value--;
                                  context
                                      .read<TicketClassificationTabBloc>()
                                      .add(
                                        TicketClassificationDataCallEvent(
                                          startDate: state.startDate,
                                          endDate: state.endDate,
                                          page: currentPage.value,
                                          pageSize: pageSize.value,
                                        ),
                                      );
                                }
                              : null,
                          icon: const Icon(Icons.arrow_back_ios_new, size: 15),
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: currentPage,
                          builder: (context, page, _) {
                            return Text(
                              'Page $page',
                              style: TextStyle(
                                  color:
                                      SupportBotColors.disablePrimary.shade700,
                                  fontWeight: FontWeight.w500),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: (currentPage.value * pageSize.value) <
                                  (state.model?.data?.totalRecords ?? 0)
                              ? () {
                                  currentPage.value++;
                                  context
                                      .read<TicketClassificationTabBloc>()
                                      .add(
                                        TicketClassificationDataCallEvent(
                                          startDate: state.startDate,
                                          endDate: state.endDate,
                                          page: currentPage.value,
                                          pageSize: pageSize.value,
                                        ),
                                      );
                                }
                              : null,
                          icon: const Icon(Icons.arrow_forward_ios, size: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        if (state is TicketClassificationFailureState) {
          return const Center(child: Text('Failed to load data.'));
        }
        if (state is TicketClassificationEmptyState) {
          return const Center(child: Text('No data1 Found.'));
        }
        return const Center(child: Text('No data Found.'));
      },
    );
  }
}
