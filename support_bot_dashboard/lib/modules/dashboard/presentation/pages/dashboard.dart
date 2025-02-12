import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/bloc/ai_query_bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/bloc/update_ai_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/widgets/ai_query_tab_filter_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_answer_bloc/ai_query_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_edited_bloc/ai_query_edited_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/get_all_pipeline_bloc/get_all_pipeline_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_dropdown_bloc/pipeline_dropdown_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_tile_bloc/pipeline_tile_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/tab_index_bloc/tab_index_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/user_validation_bloc/user_validation_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/validation_status_bloc/validation_status_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/views/dashboard_mobile_view.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/views/dashboard_desktop_view.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/responsive.dart';
import 'package:support_bot_dashboard/utils/service/instance_sharing_service.dart';
import 'package:support_bot_dashboard/utils/service/instance_sharing_service.dart';

class Dashboard extends StatelessWidget {
  final String? pipelineId;
  final String? pipelineName;
  final DateTime? startDate;
  final DateTime? endDate;
  const Dashboard(
      {super.key,
      this.pipelineName,
      this.pipelineId,
      this.endDate,
      this.startDate});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TicketClassificationTabBloc()),
          BlocProvider(
            create: (context) => TabIndexBloc(),
          ),
          BlocProvider(
            create: (context) => AiQueryAnswerBloc()
              ..add(AIQueryAnswerInitialEvent(
                  endDate: endDate,
                  startDate: startDate,
                  selectedPipelineValue: [pipelineId ?? ""])),
          ),
          BlocProvider(
            create: (context) => AiQueryEditedBloc()
              ..add(AIQueryEditedInitialEvent(
                  endDate: endDate,
                  startDate: startDate,
                  selectedPipelineValue: [pipelineId??""])),
          ),
          BlocProvider(
            create: (context) =>
                GetAllPipelineBloc()..add(GetAllPiplineInitialEvent()),
          ),
          BlocProvider(
            create: (context) => PipelineDropdownBloc(),
          ),
          BlocProvider(
            create: (context) => TicketClassificationBloc()
              ..add(TickiteClassificationEvent(
                  endDate: endDate,
                  startDate: startDate,
                  selectedPipelineValue: [pipelineId??""])),
          ),
          BlocProvider(
            create: (context) => ValidationStatusBloc()
              ..add(ValidationStatuseCallEvent(
                  endDate: endDate,
                  startDate: startDate,
                  selectedPipelineValue: [pipelineId??""])),
          ),
          BlocProvider(
            create: (context) => UserValidationBloc()
              ..add(UserValidationsEvent(
                  endDate: endDate,
                  startDate: startDate,
                  selectedPipelineValue: [pipelineId??""])),
          ),
          BlocProvider<AiQueryBloc>(
            create: (context) =>
                serviceLocator<InstanceSharingService>().aiQueryBloc ??
                AiQueryBloc(),
            child: const AIQueryTabFilterWidget(),
          ),
          BlocProvider<UpdateAiAnswerBloc>(
            create: (context) => UpdateAiAnswerBloc(),
            child: const AIQueryTabFilterWidget(),
          ),
          BlocProvider<PipelineTileBloc>(
            create: (context) => PipelineTileBloc()
              ..add(PipelineTileInitialEvent(
                  endDate: endDate, startDate: startDate)),
          ),
        ],
        child: Responsive(
          mobile: const DashboardMobileView(),
          tablet: DashboardDesktopView(
            pipelineName: pipelineName,
            piplineId: pipelineId,
            endDate: endDate,
            startDate: startDate,
          ),
          desktop: DashboardDesktopView(
              pipelineName: pipelineName,
              piplineId: pipelineId,
              endDate: endDate,
              startDate: startDate),
        ),
      ),
    );
  }
}
