import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/custom_pagination_dropdown.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/ticket_classification_entitie_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/widgets/ticket_classification_pluto_gride_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class TicketClassificationPlutoTable extends StatelessWidget {
  TicketClassificationPlutoTable({super.key});

  final ValueNotifier<num> currentPage = ValueNotifier<int>(1);
  final ValueNotifier<num> pageSize = ValueNotifier<int>(10);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketClassificationTabBloc, TicketClassificationState>(
      builder: (context, state) {
        currentPage.value =
            BlocProvider.of<TicketClassificationTabBloc>(context).page;
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
                  ticketClassificationEntitieModel:
                      state.model ?? TicketClassificationEntitieModel(),
                  piplineId: state.pipelineId,
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
                          style: SupportBotTextstyle.hint.copyWith(
                            color: SupportBotColors.disablePrimary.shade400,
                          ),
                        ),
                        ValueListenableBuilder<num>(
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
                          style: SupportBotTextstyle.hint.copyWith(
                            color: SupportBotColors.disablePrimary.shade500,
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
                        ValueListenableBuilder<num>(
                          valueListenable: currentPage,
                          builder: (context, page, _) {
                            return Text(
                              'Page ${currentPage.value}',
                              style: SupportBotTextstyle.hint.copyWith(
                                color: SupportBotColors.disablePrimary.shade400,
                              ),
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
        } else if (state is TicketClassificationFailureState) {
          return const FailureWidget();
        } else if (state is TicketClassificationEmptyState) {
          return const Center(child: EmptyWidget());
        }
        return const SizedBox.shrink();
      },
    );
  }
}
