import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_tile_bloc/pipeline_tile_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ai_query_answer_tile.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ai_query_edited_tile.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_pipeline_tile.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/validation_status_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ticket_classification_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/user_validation_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class Charts extends StatelessWidget {
  Charts({super.key});
  final s = serviceLocator<S>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = UIHelpers.screenHeight(context);
    return SizedBox(
      child: Column(
        children: [
          _buildPipelineTile(),
          UIHelpers.verticalSpaceRegular,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TicketClassificationWidget(),
                    UIHelpers.verticalSpace(16),
                    _buildValidationStatusCard(screenHeight, context),
                  ],
                ),
              ),
              UIHelpers.horizontalSpaceSmall,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserValidationCard(),
                    UIHelpers.verticalSpaceRegular,
                    _buildAiQueryEditedAnswerCard(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineTile() {
    return BlocBuilder<PipelineTileBloc, PipelineTileState>(
      builder: (context, state) {
        if (state is PipelineTileSuccessState) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: SupportBotColors.gray),
              borderRadius: BorderRadius.circular(8),
              color: SupportBotColors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildHeader(context),
                  DashboardPipelineChart(),
                ],
              ),
            ),
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

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          s.piplineText,
          style: SupportBotTextstyle.normal.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: SupportBotColors.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<PipelineTileBloc>().add(
                TogglePipelineChartVisibilityEvent(
                    isVisible:
                        BlocProvider.of<PipelineTileBloc>(context).isVisible ??
                            false));
          },
          child: Icon(
            BlocProvider.of<PipelineTileBloc>(context).isVisible == true
                ? SupportBotIcons.eye
                : SupportBotIcons.visibilityOff,
            color: SupportBotColors.bluePrimary.shade400,
          ),
        ),
      ],
    );
  }

  Widget _buildValidationStatusCard(double screenHeight, BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.47,
      child: ValidationStatusWidget(),
    );
  }

  Widget _buildUserValidationCard() {
    return Container(
      width: 800,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
            color: SupportBotColors.blueSecondary.shade100, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            s.userValidationText,
            style: SupportBotTextstyle.normal.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: SupportBotColors.black),
          ),
          const UserValidationWidget(),
        ],
      ),
    );
  }

  Widget _buildAiQueryEditedAnswerCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        AiQueryAnswerTile(),
        AiQueryEditedTile(),
      ],
    );
  }
}
