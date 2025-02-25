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
              _buildPlutoGridWidget(state),
              _buildFooter(
                  context, state, ticketClassificationTabBloc, currentPage)
            ],
          );
        } else if (state is TicketClassificationFailureState) {
          return const FailureWidget();
        } else if (state is TicketClassificationEmptyState) {
          return Center(
              child: EmptyWidget(
            message: state.message,
          ));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPlutoGridWidget(TicketClassificationSuccessState state) {
    return Expanded(
      child: TicketClassificationPlutoGrideWidget(
        ticketClassificationAttributeModel:
            state.ticketClassificationAttributeModel ??
                TicketClassificationAttributeModel(),
        piplineId: state.pipelineId,
      ),
    );
  }

  Widget _buildFooter(
    BuildContext context,
    TicketClassificationSuccessState state,
    TicketClassificationTabBloc ticketClassificationTabBloc,
    ValueNotifier<num> currentPage,
  ) {
    final totalRecords =
        state.ticketClassificationAttributeModel?.data?.totalRecords ?? 0;
    final pageSize = ticketClassificationTabBloc.pageSize;
    final startRange = ((currentPage.value - 1) * pageSize) + 1;
    final endRange = (currentPage.value * pageSize > totalRecords)
        ? totalRecords
        : currentPage.value * pageSize;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildItemsPerPageDropdown(context, ticketClassificationTabBloc,
              currentPage, state, pageSize),
          UIHelpers.horizontalSpaceRegular,
          _buildPaginationControls(context, ticketClassificationTabBloc,
              currentPage, state, startRange, endRange, totalRecords, pageSize),
        ],
      ),
    );
  }

  Widget _buildItemsPerPageDropdown(
    BuildContext context,
    TicketClassificationTabBloc ticketClassificationTabBloc,
    ValueNotifier<num> currentPage,
    TicketClassificationSuccessState state,
    num pageSize,
  ) {
    return Row(
      children: [
        Text(
          s.itemsPerPageText,
          style: SupportBotTextstyle.hint.copyWith(
            color: SupportBotColors.disablePrimary.shade400,
          ),
        ),
        ValueListenableBuilder<num>(
          valueListenable: ValueNotifier<num>(pageSize),
          builder: (context, value, child) {
            return CustomPaginationDropdown(
              selectedValue: value,
              items: const [10, 25, 50, 100, 250],
              onChanged: (newValue) {
                if (newValue != null) {
                  pageSize = newValue;
                  currentPage.value = 1;
                  context.read<TicketClassificationTabBloc>().add(
                        TicketClassificationDataCallEvent(
                          startDate: ticketClassificationTabBloc.startDate,
                          endDate: ticketClassificationTabBloc.endDate,
                          fieldValue:
                              ticketClassificationTabBloc.selectedPipelineId,
                          page: currentPage.value,
                          pageSize: newValue,
                        ),
                      );
                }
              },
              width: 70,
              height: 40,
            );
          },
        ),
      ],
    );
  }

  Widget _buildPaginationControls(
    BuildContext context,
    TicketClassificationTabBloc ticketClassificationTabBloc,
    ValueNotifier<num> currentPage,
    TicketClassificationSuccessState state,
    num startRange,
    num endRange,
    num totalRecords,
    num pageSize,
  ) {
    return Row(
      children: [
        Text(
          "$startRange - $endRange of $totalRecords",
          style: SupportBotTextstyle.hint.copyWith(
            color: SupportBotColors.disablePrimary.shade500,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: currentPage.value > 1
              ? () => _onPreviousPagePressed(
                  context, currentPage, ticketClassificationTabBloc, pageSize)
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
          onPressed: (currentPage.value * pageSize) < totalRecords
              ? () => _onNextPagePressed(context, currentPage,
                  ticketClassificationTabBloc, totalRecords, pageSize)
              : null,
          icon: const Icon(Icons.arrow_forward_ios, size: 15),
        ),
      ],
    );
  }

  void _onPreviousPagePressed(
    BuildContext context,
    ValueNotifier<num> currentPage,
    TicketClassificationTabBloc ticketClassificationTabBloc,
    num pageSize,
  ) {
    currentPage.value--;
    context.read<TicketClassificationTabBloc>().add(
          TicketClassificationDataCallEvent(
            fieldValue: ticketClassificationTabBloc.selectedPipelineId,
            startDate: ticketClassificationTabBloc.startDate,
            endDate: ticketClassificationTabBloc.endDate,
            page: currentPage.value,
            pageSize: pageSize,
          ),
        );
  }

  void _onNextPagePressed(
    BuildContext context,
    ValueNotifier<num> currentPage,
    TicketClassificationTabBloc ticketClassificationTabBloc,
    num totalRecords,
    num pageSize,
  ) {
    currentPage.value++;
    context.read<TicketClassificationTabBloc>().add(
          TicketClassificationDataCallEvent(
            fieldValue: ticketClassificationTabBloc.selectedPipelineId,
            startDate: ticketClassificationTabBloc.startDate,
            endDate: ticketClassificationTabBloc.endDate,
            page: currentPage.value,
            pageSize: pageSize,
          ),
        );
  }
}
