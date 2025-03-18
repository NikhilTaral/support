import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/bloc/ai_query_bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/views/ai_query_edited_dekstop_view.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/views/ai_query_edited_mobile_view.dart';
import 'package:support_bot_dashboard/responsive.dart';

class AIQueryEditedScreen extends StatelessWidget {
  const AIQueryEditedScreen(
      {super.key,
      this.endDate,
      this.pipelineName,
      this.piplineId,
      this.startDate});
  final String? pipelineName;
  final String? piplineId;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    context.read<AiQueryBloc>().add(
          AIQueryInitialEvent(
              endDate: endDate,
              startDate: startDate,
              selectedPipelineValueList: piplineId,
              page: 1,
              pageSize: BlocProvider.of<AiQueryBloc>(context).pageSize),
        );
    return Scaffold(
      body: Responsive(
        mobile: const AIQueryEditedMobileView(),
        tablet: AIQueryEditedDesktopView(),
        desktop: AIQueryEditedDesktopView(),
      ),
    );
  }
}
