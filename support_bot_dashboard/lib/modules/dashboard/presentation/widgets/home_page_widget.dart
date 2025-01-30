import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/charts.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_count_container.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_count_container_data.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
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
            const Charts(),
          ],
        )),
      ],
    ));
  }
}
