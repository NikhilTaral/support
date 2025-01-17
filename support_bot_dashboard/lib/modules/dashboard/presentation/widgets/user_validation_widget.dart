import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/user_validation_bloc/user_validation_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/line_chart_graph_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class UserValidationWidget extends StatelessWidget {
  const UserValidationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserValidationBloc, UservalidationState>(
      builder: (context, state) {
        if (state is UserValidationSucssesState) {
          return SizedBox(
              height: UIHelpers.screenHeight(context) * 0.4,
              child: LineChartGraphWidget(
                dashboardDataModel: state.dashboardDataModel,
              ));
        } else if (state is UserValidationLoadingState) {
          return const LoadingWidget(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              width: double.infinity,
              height: 310);
        } else if (state is UserValidationFailureSate) {
          return FailureWidget(
            onTap: () {
              BlocProvider.of<UserValidationBloc>(context)
                  .add(UserValidationsEvent());
            },
          );
        } else if (state is UserValidationEmptyState) {
          return const EmptyWidget();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
