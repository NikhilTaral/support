import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/export_bloc/export_bloc.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

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
    final s = serviceLocator<S>();

    return BlocProvider(
      create: (context) => ExportBloc(),
      child: BlocConsumer<ExportBloc, ExportState>(
        listener: (context, state) {
          if (state is ExportFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                width: UIHelpers.screenWidth(context) * 0.6,
                backgroundColor: SupportBotColors.danger.shade100,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: SupportBotColors.danger),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                content: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: SupportBotColors.danger,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: const Icon(Icons.close_rounded,
                          color: SupportBotColors.white),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      s.exportFailureText,
                      style: const TextStyle(
                        color: SupportBotColors.danger,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: "X",
                  textColor: SupportBotColors.danger,
                  onPressed: () {},
                ),
              ),
            );
          } else if (state is ExportSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                width: UIHelpers.screenWidth(context) * 0.6,
                backgroundColor: SupportBotColors.successPrimary.shade100,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  side:
                      const BorderSide(color: SupportBotColors.successPrimary),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                content: Row(
                  children: [
                    const Icon(Icons.check_circle,
                        color: SupportBotColors.successPrimary),
                    const SizedBox(width: 8),
                    Text(
                      s.exportSuccessfullyText,
                      style: const TextStyle(
                        color: SupportBotColors.successPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: "X",
                  textColor: SupportBotColors.successPrimary,
                  onPressed: () {},
                ),
              ),
            );
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
