import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_tile_bloc/pipeline_tile_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/charts.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_count_container.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_count_container_data.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_pipeline_tile.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Row(
      children: [
        Flexible(
            child: Column(
          children: [
            BlocBuilder<TicketClassificationBloc, TicketClassificationState>(
              builder: (context, state) {
                if (state is TicketClassificationSucssesState) {
                  final List<CountContainerData> countContainers =
                      getCountContainerData(context,
                          model: state.dashboardDataModel);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 20,
                    children: List.generate(countContainers.length, (index) {
                      final data = countContainers[index];
                      return CountContainer(
                        text: data.text,
                        icon: data.icon,
                        count: data.count,
                      );
                    }),
                  );
                } else if (state is TicketClassificationLoadingState) {
                  return const LoadingWidget(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      width: double.infinity,
                      height: 100);
                } else if (state is TicketClassificationFailureState) {
                  return FailureWidget(
                    onTap: () {
                      BlocProvider.of<TicketClassificationBloc>(context)
                          .add(TickiteClassificationEvent());
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            UIHelpers.verticalSpaceRegular,
            _buildPipelineTile(),
            UIHelpers.verticalSpaceRegular,
            Charts(),
          ],
        )),
      ],
    ));
  }
}

Widget _buildPipelineTile() {
  return BlocBuilder<PipelineTileBloc, PipelineTileState>(
    builder: (context, state) {
      double containerHeight = 0;
      if (state is PipelineTileSuccessState) {
        final a = BlocProvider.of<PipelineTileBloc>(context).isVisible ?? false;
        containerHeight = a ? 400 : 65;
        return Container(
          height: containerHeight,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: SupportBotColors.gray),
            borderRadius: BorderRadius.circular(8),
            color: SupportBotColors.white,
          ),
          child: DashboardPipelineChart(),
        );
      } else if (state is PipelineTileLoadingState) {
        return LoadingWidget(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            width: UIHelpers.screenWidth(context),
            height: 65);
      } else if (state is PipelineTileFailureState) {
        return FailureWidget(
          onTap: () {
            context.read<PipelineTileBloc>().add(PipelineTileInitialEvent());
          },
        );
      } else if (state is PipelineTileEmptyState) {
        return const EmptyWidget();
      }
      return const SizedBox.shrink();
    },
  );
}
