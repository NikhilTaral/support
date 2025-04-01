import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_accuracy_and_validation_trends_bloc.dart/ai_accuracy_and_validation_trends_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ai_accuracy_and_validation_trends_line_graph.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class AiAccuracyAndValidationTrendsStates extends StatelessWidget {
  const AiAccuracyAndValidationTrendsStates(
      {super.key, this.endDate, this.piplineId, this.startDate});
  final List<String>? piplineId;
  final DateTime? startDate;
  final DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiAccuracyAndValidationTrendsBloc,
        AiAccuracyAndValidationTrendsState>(
      builder: (context, state) {
        if (state is AiAccuracyAndValidationTrendsSucssesState) {
          return SizedBox(
              height: UIHelpers.screenHeight(context) * 0.4,
              child: AiAccuracyAndValidationTrendsLineGraph(
                dashboardDataModel: state.dashboardDataModel,
              ));
        } else if (state is AiAccuracyAndValidationTrendsLoadingState) {
          return const LoadingWidget(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              width: double.infinity,
              height: 310);
        } else if (state is AiAccuracyAndValidationTrendsFailureState) {
          return FailureWidget(
            onTap: () {},
          );
        } else if (state is AiAccuracyAndValidationTrendsEmptyState) {
          return const EmptyWidget();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
