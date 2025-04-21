import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_accuracy_and_validation_trends_bloc.dart/ai_accuracy_and_validation_trends_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_tile_bloc/pipeline_tile_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/user_validation_bloc/user_validation_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ai_accuracy_and_validation_trends_states.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ai_query_answer_tile.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ai_query_edited_tile.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/dashboard_pipeline_tile.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/validation_status_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/ticket_classification_widget.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/user_validation_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_month_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/tool_tip.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class Charts extends StatelessWidget {
  Charts({super.key, this.endDate, this.piplineId, this.startDate});
  final s = serviceLocator<S>();
  final List<String>? piplineId;
  final DateTime? startDate;
  final DateTime? endDate;
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
                    _buildUserValidationCard(context),
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
                  UIHelpers.verticalSpace(10),
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
        Row(
          children: [
            Text(
              s.pipelineText,
              style: SupportBotTextstyle.normal.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: SupportBotColors.black,
              ),
            ),
            UIHelpers.horizontalSpaceTiny,
            CustomToolTip(
              minMargin: 40,
              width: 300,
              isMobile: false,
              message: s.piplineInfoToolTipText,
              child: const Icon(
                size: 18,
                SupportBotIcons.infoCircle,
              ),
            ),
          ],
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

  Widget _buildUserValidationCard(BuildContext context) {
    return BlocSelector<AiAccuracyAndValidationTrendsBloc,
        AiAccuracyAndValidationTrendsState, String>(
      selector: (state) {
        if (state is AiAccuracyAndValidationTrendsSucssesState) {
          return state.isVisible ?? "";
        }
        return "";
      },
      builder: (context, state) {
        state = state.isEmpty ? "AI Accuracy" : state;
        return Container(
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
              Row(
                children: [
                  CustomDropdown(
                    iconColor: SupportBotColors.black,
                    style: SupportBotTextstyle.normal.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: SupportBotColors.black),
                    border: Border.all(color: WidgetStateColor.transparent),
                    width: UIHelpers.screenWidth(context) * 0.09,
                    label: state,
                    selectedValue: state.isEmpty ? "AI Accuracy" : state,
                    onChanged: (newValue) async {
                      BlocProvider.of<AiAccuracyAndValidationTrendsBloc>(
                              context)
                          .add(
                        GraphToggalEvent(
                          isVisible: newValue?.toLowerCase() == "ai accuracy"
                              ? "AI Accuracy"
                              : "User Validation",
                        ),
                      );
                      final bloc =
                          BlocProvider.of<AiAccuracyAndValidationTrendsBloc>(
                              context);
                      if (newValue?.toLowerCase() == "ai accuracy") {
                        BlocProvider.of<AiAccuracyAndValidationTrendsBloc>(
                                context)
                            .add(AiAccuracyAndValidationTrendsIntialEvent(
                          startDate:
                              bloc.startDate ?? startDate?.toIso8601String(),
                          endDate: bloc.endDate ?? endDate?.toIso8601String(),
                          piplineId: bloc.piplineId ?? piplineId,
                        ));
                      }
                    },
                    items: const ["AI Accuracy", "User Validation"],
                  ),
                ],
              ),
              state == "AI Accuracy"
                  ? AiAccuracyAndValidationTrendsStates(
                      endDate: endDate,
                      startDate: startDate,
                      piplineId: piplineId,
                    )
                  : const UserValidationWidget()
            ],
          ),
        );
      },
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
