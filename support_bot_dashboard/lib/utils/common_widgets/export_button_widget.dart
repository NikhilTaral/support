import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/export_bloc/export_bloc.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';

class ExportButton extends StatelessWidget {
  final String icon;
  final double iconSize;
  final String selectedButtonText;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? selectedPipeline;
  final String? bopsState;
  final String? selectedClassification;
  final String? selectedClassificationValidation;

  const ExportButton({
    Key? key,
    required this.icon,
    this.iconSize = 30.0,
    required this.selectedButtonText,
    this.startDate,
    this.endDate,
    this.selectedPipeline,
    this.bopsState,
    this.selectedClassification,
    this.selectedClassificationValidation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExportBloc(),
      child: BlocConsumer<ExportBloc, ExportState>(
        listener: (context, state) {
          if (state is ExportFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to download CSV file')));
          } else if (state is ExportSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Successfully downloaded CSV file')));
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
                onPressed: state is ExportLoadingState
                    ? null
                    : () {
                        context.read<ExportBloc>().add(
                              FetchExportDataEvent(
                                startDate: startDate,
                                endDate: endDate,
                                selectedPipeline: selectedPipeline,
                                bopsState: bopsState ?? "",
                                selectedClassification:
                                    selectedClassification ?? "",
                                selectedClassificationValidation:
                                    selectedClassificationValidation ?? "",
                              ),
                            );
                      },
                child: state is ExportLoadingState
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(
                        SupportBotIcons.exportCurve,
                        size: 25,
                        color: SupportBotColors.bluePrimary,
                      )),
          );
        },
      ),
    );
  }
}
