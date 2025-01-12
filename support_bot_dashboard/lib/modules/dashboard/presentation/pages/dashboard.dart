import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/header/nav_bar.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_answer_bloc/ai_query_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_edited_bloc/ai_query_edited_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/get_all_pipeline_bloc/get_all_pipeline_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_dropdown_bloc/pipeline_dropdown_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/tab_index_bloc/tab_index_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/user_validation_bloc/user_validation_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/validation_status_bloc/validation_status_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/views/dashboard_mobile_view.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/views/dashboard_desktop_view.dart';
import 'package:support_bot_dashboard/responsive.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  String pipeline = '11257490';
  String selectedPipelineId = '11257490';
  bool isAIAnswer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TabIndexBloc(),
          ),
          BlocProvider(
            create: (context) =>
                AiQueryAnswerBloc()..add(AIQueryAnswerInitialEvent()),
          ),
          BlocProvider(
            create: (context) =>
                AiQueryEditedBloc()..add(AIQueryEditedInitialEvent()),
          ),
          BlocProvider(
            create: (context) => GetAllPipelineBloc(),
          ),
          BlocProvider(
            create: (context) => PipelineDropdownBloc(),
          ),
          BlocProvider(
            create: (context) =>
                TicketClassificationBloc()..add(TickiteClassificationEvent()),
          ),
          BlocProvider(
            create: (context) =>
                ValidationStatusBloc()..add(ValidationStatuseCallEvent()),
          ),
          BlocProvider(
            create: (context) =>
                UserValidationBloc()..add(UserValidationsEvent()),
          ),
        ],
        child: const Responsive(
          mobile: DashboardMobileView(),
          tablet: DashboardDesktopView(),
          desktop: DashboardDesktopView(),
        ),
      ),
    );
  }
}
