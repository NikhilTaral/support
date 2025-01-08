import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/user_validation_bloc/user_validation_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/line_chart_graph_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class UserValidationWidget extends StatelessWidget {
  const UserValidationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserValidationBloc()..add(UserValidationsEvent()),
      child: BlocBuilder<UserValidationBloc, UservalidationState>(
        builder: (context, state) {
          if (state is UserValidationSucssesState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "User Validation",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                UIHelpers.verticalSpaceSmall,
                SizedBox(
                    height: UIHelpers.screenHeight(context) * 0.4,
                    child: LineChartGraphWidget(
                      dashboardDataModel: state.dashboardDataModel,
                    )),
              ],
            );
          } else if (state is UserValidationLoadingState) {
            return Container(
                child: LoadingWidget(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    width: double.infinity,
                    height: UIHelpers.screenHeight(context)));
          } else if (state is UserValidationFailureSate) {
            return const Text('Failed to load user validation data');
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
