import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_action_bloc/ticket_classification_action_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/model/ticket_classification_response_model.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class TicketClassificationActionRenderer extends StatefulWidget {
  final List<Map<String, dynamic>> rowsData;
  final String classification;
  final String id;
  final bool isUpdatedToHubspot;
  final Function(String?)? onDelete;
  final int index;
  final List<Item> allRows;

  const TicketClassificationActionRenderer({
    super.key,
    required this.rowsData,
    required this.classification,
    required this.id,
    required this.isUpdatedToHubspot,
    this.onDelete,
    required this.index,
    required this.allRows,
  });

  @override
  _TicketClassificationActionRendererState createState() =>
      _TicketClassificationActionRendererState();
}

class _TicketClassificationActionRendererState
    extends State<TicketClassificationActionRenderer> {
  @override
  Widget build(BuildContext context) {
    final s = serviceLocator<S>();
    return BlocProvider(
      create: (context) => TicketClassificationActionBloc(),
      child: BlocConsumer<TicketClassificationActionBloc,
          TicketClassificationActionState>(
        listener: (context, state) {
          if (state is UpdateClassificationSuccessState &&
              widget.id ==
                  BlocProvider.of<TicketClassificationActionBloc>(context)
                      .uId) {
            final bloc = BlocProvider.of<TicketClassificationTabBloc>(context);
            BlocProvider.of<TicketClassificationTabBloc>(context)
                .add(TicketClassificationDataCallEvent(
              startDate: bloc.startDate,
              fieldValue: bloc.selectedPipelineId,
              endDate: bloc.endDate,
              page: 1,
              pageSize: 10,
            ));
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
                      s.updateSuccessfullyText,
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
          } else if (state is UpdateClassificationFailureState &&
              widget.id ==
                  BlocProvider.of<TicketClassificationActionBloc>(context)
                      .uId) {
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
                      s.updateFailureText,
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
          }
          if (state is RevertClassificationSuccessState &&
              widget.id ==
                  BlocProvider.of<TicketClassificationActionBloc>(context).id) {
            final bloc = BlocProvider.of<TicketClassificationTabBloc>(context);
            BlocProvider.of<TicketClassificationTabBloc>(context).add(
              TicketClassificationDataCallEvent(
                startDate: bloc.startDate,
                fieldValue: bloc.selectedPipelineId,
                endDate: bloc.endDate,
                page: 1,
                pageSize: 10,
              ),
            );
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
                      s.revertedSuccessfullyText,
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
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     backgroundColor: SupportBotColors.bluePrimary,
            //     content: Text(
            //       s.revertedSuccessfullyText,
            //       style: SupportBotTextstyle.hint
            //           .copyWith(color: SupportBotColors.white),
            //     ),
            //     duration: const Duration(seconds: 2),
            //   ),
            // );
          }
          if (state is RevertClassificationFailureState &&
              widget.id ==
                  BlocProvider.of<TicketClassificationActionBloc>(context).id) {
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
                      s.revertedFailureText,
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
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     backgroundColor: SupportBotColors.danger,
            //     content: Text(
            //       s.revertedFailureText,
            //       style: SupportBotTextstyle.hint
            //           .copyWith(color: SupportBotColors.white),
            //     ),
            //     duration: const Duration(seconds: 2),
            //   ),
            // );
          }
        },
        builder: (context, state) {
          return Align(
            alignment: Alignment.topLeft,
            child: PopupMenuTheme(
              data: const PopupMenuThemeData(
                color: Colors.white,
              ),
              child: PopupMenuButton<String>(
                tooltip: "",
                icon: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: const Icon(
                    Icons.more_vert_rounded,
                  ),
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: s.view,
                    onTap: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ViewDialogBox(
                              allRows: widget.allRows,
                              index: widget.index,
                            );
                          },
                        );
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.visibility),
                        const SizedBox(width: 8),
                        Text(
                          s.view,
                          style: SupportBotTextstyle.hint.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  if (widget.isUpdatedToHubspot == true)
                    PopupMenuItem<String>(
                      value: S.of(context).revert,
                      child: InkWell(
                        onTap: () {
                          final bloc =
                              BlocProvider.of<TicketClassificationActionBloc>(
                                  context);
                          if (widget.isUpdatedToHubspot) {
                            bloc.add(RevertClassificationEvent(
                              ticketId: widget.id,
                            ));
                            Navigator.of(context).pop();
                            // _showRevertToHubspotPopup(
                            //     context, S.of(context).revertSuccess);
                          } else {
                            // _showRevertToHubspotPopup(
                            //     context, S.of(context).noRevert);
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.loop_rounded),
                            UIHelpers.horizontalSpaceTiny,
                            Text(S.of(context).revert),
                          ],
                        ),
                      ),
                    ),
                  if (widget.isUpdatedToHubspot == false)
                    PopupMenuItem<String>(
                      value: s.updateText,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return BlocProvider.value(
                              value: BlocProvider.of<
                                  TicketClassificationActionBloc>(context),
                              child: AlertDialog(
                                backgroundColor: SupportBotColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  side: const BorderSide(
                                      color: Colors.transparent, width: 1.0),
                                ),
                                title: Text(
                                  s.updateTicketText,
                                  style: SupportBotTextstyle.subheadingH4
                                      .copyWith(),
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        s.requestMsgText(widget.classification),
                                        style: SupportBotTextstyle.small
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: SupportBotColors.black),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              SupportBotColors.bluePrimary,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14.0, horizontal: 24.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                        ),
                                        child: Text(
                                          s.noText,
                                          style: SupportBotTextstyle.mediumHint
                                              .copyWith(
                                            color: SupportBotColors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      UIHelpers.horizontalSpaceSmallRegular,
                                      TextButton(
                                        onPressed: () {
                                          final classification =
                                              widget.classification;
                                          final ticketId = widget.id;

                                          context
                                              .read<
                                                  TicketClassificationActionBloc>()
                                              .add(
                                                UpdateClassificationEvent(
                                                    classification:
                                                        classification,
                                                    ticketId: ticketId,
                                                    pipelineId: BlocProvider.of<
                                                                TicketClassificationTabBloc>(
                                                            context)
                                                        .selectedPipelineId),
                                              );
                                          Navigator.of(context).pop();
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              SupportBotColors.bluePrimary,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14.0, horizontal: 24.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                        ),
                                        child: Text(
                                          s.yesText,
                                          style: SupportBotTextstyle.mediumHint
                                              .copyWith(
                                            color: SupportBotColors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.update,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            s.updateText,
                            style: SupportBotTextstyle.hint.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ViewDialogBox extends StatefulWidget {
  final int index;
  final List<Item> allRows;
  const ViewDialogBox({super.key, required this.index, required this.allRows});

  @override
  State<ViewDialogBox> createState() => _ViewDialogBoxState();
}

final s = serviceLocator<S>();

class _ViewDialogBoxState extends State<ViewDialogBox> {
  late int currentIndex;
  late Item currentRowData;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    currentRowData = widget.allRows[currentIndex];
  }

  void _showPreviousData() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        currentRowData = widget.allRows[currentIndex];
      }
    });
  }

  void _showNextData() {
    setState(() {
      if (currentIndex < widget.allRows.length - 1) {
        currentIndex++;
        currentRowData = widget.allRows[currentIndex];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.white,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: currentIndex > 0 ? _showPreviousData : null,
                    icon: const Icon(Icons.arrow_circle_left_outlined),
                  ),
                  Text(
                    s.ticketDetailsText,
                    style: SupportBotTextstyle.small.copyWith(
                        fontWeight: FontWeight.w500,
                        color: SupportBotColors.black),
                  ),
                  IconButton(
                    onPressed: currentIndex < widget.allRows.length - 1
                        ? _showNextData
                        : null,
                    icon: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                ],
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText.rich(
                    TextSpan(
                      text: "${s.id} : \n",
                      style: SupportBotTextstyle.small.copyWith(
                          fontWeight: FontWeight.w600,
                          color: SupportBotColors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${currentRowData.id}',
                          style: SupportBotTextstyle.small.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SelectableText.rich(
                    TextSpan(
                      text: "${s.descriptionText} : \n",
                      style: SupportBotTextstyle.small.copyWith(
                          fontWeight: FontWeight.w600,
                          color: SupportBotColors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${currentRowData.ticketDescription}',
                          style: SupportBotTextstyle.small.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SelectableText.rich(
                    TextSpan(
                      text: "${s.aIClassification} : \n",
                      style: SupportBotTextstyle.small.copyWith(
                          fontWeight: FontWeight.w600,
                          color: SupportBotColors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '${currentRowData.aiclassification == "" ? "N/A" : currentRowData.aiclassification}',
                          style: SupportBotTextstyle.small.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SelectableText.rich(
                    TextSpan(
                      text: "${s.reasoningText} : \n",
                      style: SupportBotTextstyle.small.copyWith(
                          fontWeight: FontWeight.w600,
                          color: SupportBotColors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '${currentRowData.reasoning == "" ? "N/A" : currentRowData.reasoning}',
                          style: SupportBotTextstyle.small.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SelectableText.rich(
                    TextSpan(
                      text: "${s.bobStateText} : \n",
                      style: SupportBotTextstyle.small.copyWith(
                          fontWeight: FontWeight.w600,
                          color: SupportBotColors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '${currentRowData.bopsState == "null" ? "N/A" : currentRowData.bopsState}',
                          style: SupportBotTextstyle.small.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SelectableText.rich(
                    TextSpan(
                      text: "${s.validatedByText}: \n",
                      style: SupportBotTextstyle.small.copyWith(
                          fontWeight: FontWeight.w600,
                          color: SupportBotColors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '${currentRowData.classificationValidatedBy == "" ? "N/A" : currentRowData.classificationValidatedBy}',
                          style: SupportBotTextstyle.small.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SelectableText.rich(
                    TextSpan(
                      text: "${s.classificationValidationReasonText}: \n",
                      style: SupportBotTextstyle.small.copyWith(
                          fontWeight: FontWeight.w600,
                          color: SupportBotColors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '${currentRowData.classificationValidationReason == "" ? "N/A" : currentRowData.classificationValidationReason}',
                          style: SupportBotTextstyle.small.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SelectableText.rich(
                    TextSpan(
                      text: '${s.validatedClassificationText} : \n',
                      style: SupportBotTextstyle.small.copyWith(
                          fontWeight: FontWeight.w600,
                          color: SupportBotColors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '${currentRowData.validatedClassification == "" ? "N/A" : currentRowData.validatedClassification}',
                          style: SupportBotTextstyle.small.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SelectableText.rich(
                    TextSpan(
                      text: '${s.status} : \n',
                      style: SupportBotTextstyle.small.copyWith(
                          fontWeight: FontWeight.w600,
                          color: SupportBotColors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: currentRowData.isUpdatedToHubspot == true
                              ? 'Updated'
                              : 'Not Updated',
                          style: SupportBotTextstyle.small.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.cancel,
                      color: SupportBotColors.bluePrimary,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: SupportBotColors.bluePrimary),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    label: Text(
                      s.closeText,
                      style: SupportBotTextstyle.small
                          .copyWith(color: SupportBotColors.bluePrimary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
