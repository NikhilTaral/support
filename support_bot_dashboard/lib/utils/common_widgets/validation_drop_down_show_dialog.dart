import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/get_all_validatod_user_bloc/get_all_validation_user_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/update_classification_validation_bloc/update_classification_validation_bloc.dart';
import 'package:support_bot_dashboard/utils/common_widgets/common_elevated_button.dart';
import 'package:support_bot_dashboard/utils/common_widgets/custom_month_dropdown.dart';
import 'package:support_bot_dashboard/utils/custom_widgets/custom_snackbar.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

void showClassificationDialog({
  required BuildContext context,
  required String id,
  required List<String> pipelineIds,
  required String? newValue,
}) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      String reason = '';
      String selectedClassification = 'Select';

      return AlertDialog(
        title: Text(serviceLocator<S>().emailValidations),
        backgroundColor: SupportBotColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: BlocProvider.value(
          value: BlocProvider.of<TicketClassificationTabBloc>(context),
          child: BlocBuilder<TicketClassificationTabBloc,
              TicketClassificationState>(
            builder: (context, state) {
              return SizedBox(
                width: UIHelpers.screenWidth(dialogContext) * 0.3,
                height: UIHelpers.screenHeight(dialogContext) * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) => reason = value,
                      decoration: InputDecoration(
                        hintText: S.of(dialogContext).comments,
                        contentPadding: const EdgeInsets.all(16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      maxLines: 4,
                    ),
                    UIHelpers.verticalSpaceSmall,
                    Text(
                      S.of(dialogContext).classification,
                      style: SupportBotTextstyle.subheadingH6.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    UIHelpers.verticalSpaceTiny,
                    CustomDropdown(
                      label: "Select",
                      selectedValue: state is TicketClassificationSuccessState
                          ? state.selectedClassification ?? ""
                          : "Select",
                      onChanged: (value) async {
                        BlocProvider.of<TicketClassificationTabBloc>(context)
                            .add(UpdateTheClassificationEvent(
                                classification: value));
                      },
                      items: const [
                        "Spam/Marketing",
                        "No Action Required",
                        "Genuine Query",
                        "Acknowledgement Required",
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        actions: <Widget>[
          CommonElevatedButton(
            text: S.of(dialogContext).cancel,
            backgroundColor: SupportBotColors.danger,
            textColor: SupportBotColors.white,
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          CommonElevatedButton(
            text: S.of(dialogContext).save,
            backgroundColor: SupportBotColors.bluePrimary,
            textColor: SupportBotColors.white,
            onPressed: () async {
              final blocState =
                  BlocProvider.of<TicketClassificationTabBloc>(context).state;
              String latestClassification =
                  (blocState is TicketClassificationSuccessState)
                      ? blocState.selectedClassification ?? 'Select'
                      : 'Select';

              BlocProvider.of<TicketClassificationTabBloc>(context).add(
                SaveChangeValidationEvent(
                  id: id,
                  pipelineIds: pipelineIds,
                  reason: reason,
                  selectedClassification: latestClassification,
                ),
              );

              _saveIncorrect(
                context,
                id,
                pipelineIds,
                reason,
                latestClassification,
                newValue,
              );
            },
          ),
        ],
      );
    },
  );
}

void _saveIncorrect(
  BuildContext context,
  String? id,
  List<String> pipelineIds,
  String reason,
  String selectedClassification,
  String? newValue,
) {
 if (reason.isNotEmpty && selectedClassification != 'Select') {
    final s = serviceLocator<S>();
    final bloc = BlocProvider.of<UpdateClassificationValidationBloc>(context);
    bloc.add(
      UpdateClassificationValidationstateEvent(
        id: id,
        pipeline: pipelineIds.join(','),
        reason: reason,
        validatedClassification: selectedClassification,
        validation: newValue?.toLowerCase(),
      ),
    );
    Future.delayed(const Duration(milliseconds: 3000), () {
      final bloc = BlocProvider.of<TicketClassificationTabBloc>(context);
      BlocProvider.of<GetAllValidationUsersBloc>(context)
          .add(GetValidationUsersInitialEvent());
      BlocProvider.of<TicketClassificationTabBloc>(context).add(
        TicketClassificationDataCallEvent(
          startDate: bloc.startDate,
          endDate: bloc.endDate,
          fieldValue: bloc.selectedPipelineId,
          page: bloc.page,
          pageSize: bloc.pageSize,
        ),
      );
      BlocProvider.of<GetAllValidationUsersBloc>(context).add(
        GetValidationUsersInitialEvent(
          startDate: bloc.startDate,
          endDate: bloc.endDate,
          filter: [bloc.selectedPipelineId],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar(
          message: s.ticketUpdatedInCorrectText,
          context: context,
          isSuccess: true,
        ),
      );
    });
    Navigator.of(context).pop();
  } else {
    final s = serviceLocator<S>();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s.reasonAndSelectClassificationText),
      ),
    );
  }
}
