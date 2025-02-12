import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/pipeline_tile_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pipeline_tile_bloc/pipeline_tile_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/custom_pipeline_chart.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class DashboardPipelineChart extends StatelessWidget {
  final s = serviceLocator<S>();
  DashboardPipelineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PipelineTileBloc, PipelineTileState>(
      builder: (context, state) {
        if (state is PipelineTileSuccessState) {
          final data = state.pipelineTileAttributeModel?.items;
          return (BlocProvider.of<PipelineTileBloc>(context).isVisible == true)
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UIHelpers.verticalSpaceSmall,
                    _buildChart(context, data),
                    _buildIndicator()
                  ],
                )
              : const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 680,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    color: SupportBotColors.bluePrimary.shade200,
                    borderRadius: BorderRadius.circular(5)),
              ),
              UIHelpers.horizontalSpaceSmall,
              Text(s.totalTicketsText,
                  style: SupportBotTextstyle.normal.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  )),
              UIHelpers.horizontalSpaceMedium,
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    color: SupportBotColors.bluePrimary.shade400,
                    borderRadius: BorderRadius.circular(5)),
              ),
              UIHelpers.horizontalSpaceSmall,
              Text(s.validatedTicketsText,
                  style: SupportBotTextstyle.normal.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChart(BuildContext context, List<AttributeItem>? data) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.only(right: 25),
        width: (data?.length ?? 0) * 252,
        height: (data ?? []).length * 30,
        child: CustomPipelineChart(
          pipelineData: data,
        ),
      ),
    );
  }
}
