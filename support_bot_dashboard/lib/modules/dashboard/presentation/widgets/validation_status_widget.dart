import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/common/validation_status_report_utils.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/validation_status_bloc/validation_status_bloc.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/pluto_configruration.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class ValidationStatusWidget extends StatelessWidget {
  ValidationStatusWidget({super.key});
  final s = serviceLocator<S>();
  final List<PlutoColumnGroup> columnGroups = [
    PlutoColumnGroup(
      title: serviceLocator<S>().actualClassification,
      fields: ['genuine_query', 'ack_required', 'no_action_required', 'spam'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 800,
      decoration: BoxDecoration(
        border: Border.all(
            color: SupportBotColors.blueSecondary.shade100, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            s.validationStatusText,
            style: SupportBotTextstyle.normal.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: SupportBotColors.black),
          ),
          Expanded(
            child: BlocBuilder<ValidationStatusBloc, ValidationStatusState>(
              builder: (context, state) {
                if (state is ValidationStatusSucssesState) {
                  final attributeModel = state.attributeModel;
                  return PlutoGrid(
                      columns:
                          ValidationStatusReportUtils.validationStatusColumns(),
                      columnGroups: columnGroups,
                      rows: ValidationStatusReportUtils.validationStatusRow(
                          attributeModel: attributeModel),
                      configuration:
                          PlutoGridConfigurations.plutoGridConfigurations());
                } else if (state is ValidationStatusLoadingState) {
                  return const LoadingWidget(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      width: double.infinity,
                      height: 200);
                } else if (state is ValidationStatusEmptyState) {
                  return const EmptyWidget();
                } else if (state is ValidationStatusFailureState) {
                  return FailureWidget(
                    onTap: () {
                      BlocProvider.of<ValidationStatusBloc>(context)
                          .add(ValidationStatuseCallEvent());
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
