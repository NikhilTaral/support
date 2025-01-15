import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/domain/entities/ai_query_answer_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/pluto_table_widget.dart';
import 'package:support_bot_dashboard/utils/report_utils.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class AIQueryEditedDesktopView extends StatelessWidget {
  const AIQueryEditedDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiQueryBloc, AiQueryState>(
      builder: (context, state) {
        if (state is AIQuerySucssesState) {
          final utils = ReportUtils(
              context: context,
              aiQueryAttributeModel: state.dashboardDataModel);
          return PlutoTableWidget(
              columns: utils.createAIQueryEditedColumn(context: context),
              rows: utils.createAIQueryEditedRow(
                  aiQueryAttributeModel:
                      state.dashboardDataModel ?? AiQueryAttributeModel()));
        } else if (state is AIQueryLoadingState) {
          return LoadingWidget(
            radius: 8,
            height: UIHelpers.screenHeight(context),
            width: UIHelpers.screenWidth(context),
          );
        } else if (state is AIQueryFailureState) {
          return FailureWidget(
            borderRadius: BorderRadius.circular(8),
            onTap: () {},
          );
        } else if (state is AIQueryEmptyState) {
          return const Align(
              alignment: Alignment.topCenter, child: EmptyWidget());
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
