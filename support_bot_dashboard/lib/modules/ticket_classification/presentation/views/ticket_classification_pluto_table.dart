import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/custom_pagination_dropdown.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/entities/ticket_classification_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/widgets/ticket_classification_pluto_gride_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class TicketClassificationPlutoTable extends StatelessWidget {
  TicketClassificationPlutoTable(
      {super.key,
      this.endDate,
      this.pipelineName,
      this.piplineId,
      this.startDate});
  final String? pipelineName;
  final String? piplineId;
  final DateTime? startDate;
  final DateTime? endDate;
  final ValueNotifier<num> currentPage = ValueNotifier<num>(1);
  final s = serviceLocator<S>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketClassificationTabBloc, TicketClassificationState>(
      builder: (context, state) {
        final ticketClassificationTabBloc =
            BlocProvider.of<TicketClassificationTabBloc>(context);
        currentPage.value = ticketClassificationTabBloc.page;

        if (state is TicketClassificationLoadingState) {
          return Center(
              child: LoadingWidget(
            height: UIHelpers.screenHeight(context),
            width: UIHelpers.screenWidth(context),
          ));
        }
        if (state is TicketClassificationSuccessState) {
          return Column(
            children: [
              Expanded(
                child: TicketClassificationPlutoGrideWidget(
                  ticketClassificationAttributeModel:
                      state.ticketClassificationAttributeModel ??
                          TicketClassificationAttributeModel(),
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
                          s.itemsPerPageText,
                          style: SupportBotTextstyle.hint.copyWith(
                            color: SupportBotColors.disablePrimary.shade400,
                          ),
                        ),
                        ValueListenableBuilder<num>(
                          valueListenable: ValueNotifier<num>(
                              ticketClassificationTabBloc.pageSize),
                          builder: (context, value, child) {
                            return CustomPaginationDropdown(
                              selectedValue: value,
                              items: const [10, 25, 50, 100, 250],
                              onChanged: (value) {
                                if (value != null) {
                                  BlocProvider.of<TicketClassificationTabBloc>(
                                          context)
                                      .pageSize = value;
                                  currentPage.value = 1;

                                  context
                                      .read<TicketClassificationTabBloc>()
                                      .add(
                                        TicketClassificationDataCallEvent(
                                            startDate: state.startDate,
                                            endDate: state.endDate,
                                            fieldValue:
                                                ticketClassificationTabBloc
                                                    .selectedPipelineId,
                                            page: currentPage.value,
                                            pageSize:
                                                ticketClassificationTabBloc
                                                    .pageSize),
                                      );
                                }
                              },
                              width: 70,
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
                          "${(currentPage.value - 1) * ticketClassificationTabBloc.pageSize + 1} - "
                          "${(currentPage.value * ticketClassificationTabBloc.pageSize > (state.ticketClassificationAttributeModel?.data?.totalRecords ?? 0)) ? state.ticketClassificationAttributeModel?.data?.totalRecords ?? 0 : currentPage.value * ticketClassificationTabBloc.pageSize} of "
                          "${state.ticketClassificationAttributeModel?.data?.totalRecords ?? 0}",
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
                                            fieldValue:
                                                ticketClassificationTabBloc
                                                    .selectedPipelineId,
                                            startDate:
                                                ticketClassificationTabBloc
                                                    .startDate,
                                            endDate: ticketClassificationTabBloc
                                                .endDate,
                                            page: currentPage.value,
                                            pageSize:
                                                ticketClassificationTabBloc
                                                    .pageSize),
                                      );
                                }
                              : null,
                          icon: const Icon(Icons.arrow_back_ios_new, size: 15),
                        ),
                        ValueListenableBuilder<num>(
                          valueListenable: currentPage,
                          builder: (context, page, _) {
                            return Text(
                              '${s.pageText} ${currentPage.value}',
                              style: SupportBotTextstyle.hint.copyWith(
                                color: SupportBotColors.disablePrimary.shade400,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: (currentPage.value *
                                      ticketClassificationTabBloc.pageSize) <
                                  (state.ticketClassificationAttributeModel
                                          ?.data?.totalRecords ??
                                      0)
                              ? () {
                                  currentPage.value++;
                                  context
                                      .read<TicketClassificationTabBloc>()
                                      .add(
                                        TicketClassificationDataCallEvent(
                                          fieldValue:
                                              ticketClassificationTabBloc
                                                  .selectedPipelineId,
                                          startDate: ticketClassificationTabBloc
                                              .startDate,
                                          endDate: ticketClassificationTabBloc
                                              .endDate,
                                          page: currentPage.value,
                                          pageSize: ticketClassificationTabBloc
                                              .pageSize,
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
          return  Center(child: EmptyWidget(message: state.message,));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
