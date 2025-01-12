import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/modules/dashboard/common/validation_status_report_utils.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/validation_status_bloc/validation_status_bloc.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/pluto_configruration.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class ValidationStatusWidget extends StatelessWidget {
  ValidationStatusWidget({super.key, required list});
  final List<PlutoColumnGroup> columnGroups = [
    PlutoColumnGroup(
      title: 'Actual Classification',
      fields: ['genuine_query', 'ack_required', 'no_action_required', 'spam'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationStatusBloc, ValidationStatusState>(
      builder: (context, state) {
        if (state is ValidationStatusSucssesState) {
          final attributeModel = state.attributeModel;
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                  color: SupportBotColors.blueSecondary.shade100, width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Validation Status",
                  style: SupportBotTextstyle.normal.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: SupportBotColors.black),
                ),
                UIHelpers.verticalSpaceSmall,
                Expanded(
                  child: PlutoGrid(
                      columns:
                          ValidationStatusReportUtils.validationStatusColumns(),
                      columnGroups: columnGroups,
                      rows: ValidationStatusReportUtils.validationStatusRow(
                          attributeModel: attributeModel),
                      configuration:
                          PlutoGridConfigurations.plutoGridConfigurations()),
                ),
              ],
            ),
          );
        } else if (state is ValidationStatusLodingState) {
          return const LoadingWidget(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              width: double.infinity,
              height: 200);
        } else if (state is VsalidationStatusFailureState) {
          return const Center(child: Text('Failed to load data'));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
