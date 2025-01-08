import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/modules/dashboard/common/validation_status_report_utils.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/validation_status_bloc/validation_status_bloc.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/pluto_configruration.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
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
    return BlocProvider(
      create: (context) =>
          ValidationStatusBloc()..add(ValidationStatuseCallEvent()),
      child: BlocBuilder<ValidationStatusBloc, ValidationStatusState>(
        builder: (context, state) {
          if (state is ValidationStatusSucssesState) {
            final attributeModel = state.attributeModel;
            return Container(
              padding: const EdgeInsets.all(16),
              child: PlutoGrid(
                  columns:
                      ValidationStatusReportUtils.validationStatusColumns(),
                  columnGroups: columnGroups,
                  rows: ValidationStatusReportUtils.validationStatusRow(
                      attributeModel: attributeModel),
                  configuration:
                      PlutoGridConfigurations.plutoGridConfigurations()),
            );
          } else if (state is ValidationStatusLodingState) {
            return Container(
                child: LoadingWidget(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    width: double.infinity,
                    height: UIHelpers.screenHeight(context)));
          } else if (state is VsalidationStatusFailureState) {
            return const Center(child: Text('Failed to load data'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
