import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/charts.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_count_container.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_count_container_data.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 10,
          child: BlocProvider(
            create: (context) =>
                TicketClassificationBloc()..add(TickiteClassificationEvent()),
            child: BlocBuilder<TicketClassificationBloc,
                TicketClassificationState>(
              builder: (context, state) {
                if (state is TicketClassificationSucssesState) {
                  return Column(
                    children: [
                      Builder(
                        builder: (context) {
                          final List<CountContainerData> countContainers =
                              getCountContainerData(context,
                                  model: dashboardDataModel);
                          return Column(
                            children: [
                              Row(
                                children: List.generate(countContainers.length,
                                    (index) {
                                  final data = countContainers[index];
                                  return CountContainer(
                                    text: data.text,
                                    icon: data.icon,
                                    count: data.count,
                                  );
                                }),
                              ),
                              UIHelpers.verticalSpaceRegular,
                              Charts(),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                } else if (state is TicketClassificationLoadingState) {
                  return Container(
                      child: LoadingWidget(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          width: double.infinity,
                          height: UIHelpers.screenHeight(context)));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
