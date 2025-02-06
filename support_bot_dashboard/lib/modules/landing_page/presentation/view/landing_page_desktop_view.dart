import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:support_bot_dashboard/header/nav_bar.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/landing_page/presentation/landing_page_bloc/landing_page_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/widgets/ticket_classification_pipeline_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class LandingPageDesktopView extends StatefulWidget {
  LandingPageDesktopView({super.key});

  @override
  _LandingPageDesktopViewState createState() => _LandingPageDesktopViewState();
}

class _LandingPageDesktopViewState extends State<LandingPageDesktopView> {
  final ValueNotifier<List<DateTime>?> selectedDatesNotifier =
      ValueNotifier<List<DateTime>?>(null);
  final GetAllPipelinesAttributeModel getAllPipelinesAttributeModel =
      GetAllPipelinesAttributeModel();
  String selectedPipeline = "";
  List<String> selectedItems = [];
  List<String>? pipelineIds;
  List<DateTime?> selectedate = [];

  @override
  Widget build(BuildContext context) {
    List<Datums> items = getAllPipelinesAttributeModel.data ?? [];
    return BlocProvider(
      create: (context) => LandingPageBloc()..add(LandingPageInitialEvent()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          NavBar(
            showPopArrow: false,
            navigateTo: () {},
            text: "",
          ),
          UIHelpers.verticalSpaceRegular,
          Container(alignment: Alignment.center, child: _filter()),
        ],
      ),
    );
  }

  Widget _filter() {
    return Container(
      width: 698,
      constraints: const BoxConstraints(
        maxHeight: 600,
        minHeight: 500,
      ),
      decoration: BoxDecoration(
          border: Border.all(color: SupportBotColors.gray),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImg(),
          _buildHederText(),
          UIHelpers.verticalSpace(32),
          _buildTitle(),
          UIHelpers.verticalSpaceRegular,
          _buildPipelineDropdown(),
          UIHelpers.verticalSpace(28),
          _buildDateRangeSelector(),
          UIHelpers.verticalSpace(54),
          _buildApplyFilterButton(),
        ],
      ),
    );
  }

  Widget _buildImg() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Image.asset(
        'assets/images/group.jpg',
      ),
    );
  }

  Widget _buildHederText() {
    return Container(
      child: Text(
        "Welcome Aboard!",
        style: SupportBotTextstyle.subheadingH3.copyWith(
          fontWeight: FontWeight.w500,
          color: SupportBotColors.black,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text("Select Pipline/Piplines to view dashboard",
        style: SupportBotTextstyle.sidebarTitle.copyWith(
          color: SupportBotColors.black,
          fontWeight: FontWeight.w400,
        ));
  }

  Widget _buildPipelineDropdown() {
    return BlocProvider(
      create: (context) => LandingPageBloc()..add(LandingPageInitialEvent()),
      child: BlocBuilder<LandingPageBloc, LandingPageState>(
        builder: (context, state) {
          if (state is LandingPageFailureState) {
            return SizedBox(
              height: 60,
              width: UIHelpers.screenHeight(context) * 0.7,
              child: FailureWidget(
                onTap: () {
                  BlocProvider.of<LandingPageBloc>(context)
                      .add(LandingPageInitialEvent());
                },
              ),
            );
          }
          if (state is LandingPageSuccessState) {
            List<Datums> items =
                state.getAllPipelinesAttributeModel?.data ?? [];
            return Container(
              height: 40,
              width: UIHelpers.screenHeight(context) * 0.5,
              child: TicketClassificationPipelineWidget(
                hintText: selectedPipeline.isEmpty
                    ? "Pipline Type"
                    : selectedPipeline,
                items: items,
                selectedItem: selectedPipeline,
                onChanged: (selectedName) async {
                  setState(() {
                    selectedPipeline = selectedName;
                  });

                  _onPipelineSelectionChanged([selectedName], items);
                },
              ),
            );
          }
          return LoadingWidget(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            height: 40,
            width: UIHelpers.screenHeight(context) * 0.5,
          );
        },
      ),
    );
  }

  void _onPipelineSelectionChanged(
      List<String> selectedNames, List<Datums> items) async {
    pipelineIds = [];
    ;
    for (var selectedName in selectedNames) {
      final matchingItem = items.firstWhere(
        (item) => item.pipelineName == selectedName,
        orElse: () => Datums(pipelineName: '', pipelineId: ''),
      );
      if (matchingItem.pipelineId?.isNotEmpty == true) {
        pipelineIds?.add(matchingItem.pipelineId ?? "");
      }
    }
  }

  Widget _buildDateRangeSelector() {
    if (selectedate.isNotEmpty) {
      final endDate = selectedate.lastOrNull;
      final startDate = selectedate.firstOrNull;
      selectedate = [startDate, endDate];
    }

    return Center(
      child: ValueListenableBuilder<List<DateTime>?>(
        valueListenable: selectedDatesNotifier,
        builder: (context, selectedDates, child) {
          final DateTime endDate;
          final DateTime startDate;

          if (selectedDates?.isNotEmpty == true) {
            startDate = selectedDates![0];
            endDate = selectedDates.length > 1 ? selectedDates[1] : startDate;
          } else {
            endDate = DateTime.now();
            startDate = endDate.subtract(const Duration(days: 0));
          }

          return Container(
            height: 40,
            width: UIHelpers.screenHeight(context) * 0.5,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: SupportBotColors.bluePrimary),
                padding: const EdgeInsets.only(
                  right: 6,
                  left: 6,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => _pickDateRange(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(width: 8),
                  Text(
                    '${DateFormat('MMM dd').format(startDate)} - ${DateFormat('MMM dd yyyy').format(endDate)}',
                    style: SupportBotTextstyle.normal.copyWith(
                      fontSize: 14,
                      color: SupportBotColors.bluePrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  Spacer(),
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: SupportBotColors.bluePrimary,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickDateRange() async {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
      dayTextStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: SupportBotColors.bluePrimary,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle:
          const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      selectableDayPredicate: (date) => date.isBefore(DateTime.now()),
    );

    final pickedDates = await showCalendarDatePicker2Dialog(
      context: context,
      config: config,
      dialogSize: const Size(400, 400),
      borderRadius: BorderRadius.circular(15),
      value: selectedDatesNotifier.value?.cast<DateTime?>() ?? [],
      dialogBackgroundColor: Colors.white,
    );

    if (pickedDates != null) {
      selectedDatesNotifier.value = pickedDates.cast<DateTime>();
      selectedate = pickedDates;
    }
  }

  Widget _buildApplyFilterButton() {
    return SizedBox(
      height: 48,
      width: UIHelpers.screenHeight(context) * 0.5,
      child: ElevatedButton.icon(
        onPressed: _addEvents,
        iconAlignment: IconAlignment.end,
        label: const Text(
          'Get Started',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: SupportBotColors.bluePrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        icon: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }

  void _addEvents() {
    String cleanedId = pipelineIds != null && pipelineIds!.isNotEmpty
        ? pipelineIds![0].replaceAll("[]", "")
        : "";
    GoRouter.of(context).push(
      '/dashboard?pipelineName=$selectedPipeline&pipelineId=$cleanedId&startDate=${selectedate.firstOrNull}&endDate=${selectedate.lastOrNull}',
    );
    // final selectedPipelineValue =
    //     pipelineIds.isEmpty ? ["11257490"] : pipelineIds;

    // if (selectedPipelineValue.isEmpty) {
    //   showSnackbar(
    //     context,
    //     'Please select a pipeline to apply filter',
    //   );
    //   return;
    // }

    // if (selectedItems.isNotEmpty) {
    //   BlocProvider.of<ValidationStatusBloc>(context).selectedPipelineId =
    //       selectedPipelineValue;
    //   BlocProvider.of<ValidationStatusBloc>(context)
    //       .add(ValidationStatuseCallEvent(
    //     endDate: selectedate.lastOrNull,
    //     startDate: selectedate.firstOrNull,
    //     selectedPipelineValue: selectedPipelineValue,
    //   ));

    //   BlocProvider.of<AiQueryAnswerBloc>(context).selectedPipelineId =
    //       selectedPipelineValue;
    //   BlocProvider.of<AiQueryAnswerBloc>(context).add(AIQueryAnswerInitialEvent(
    //     endDate: selectedate.lastOrNull,
    //     startDate: selectedate.firstOrNull,
    //     selectedPipelineValue: selectedPipelineValue,
    //   ));

    //   BlocProvider.of<AiQueryEditedBloc>(context).selectedPipelineId =
    //       selectedPipelineValue;
    //   BlocProvider.of<AiQueryEditedBloc>(context).add(AIQueryEditedInitialEvent(
    //     endDate: selectedate.lastOrNull,
    //     startDate: selectedate.firstOrNull,
    //     selectedPipelineValue: selectedPipelineValue,
    //   ));

    //   BlocProvider.of<GetAllPipelineBloc>(context).add(
    //       GetAllPiplineInitialEvent(
    //           selectedPipelineValue: selectedPipelineValue));

    //   BlocProvider.of<TicketClassificationBloc>(context).selectedPipelineId =
    //       selectedPipelineValue;
    //   BlocProvider.of<TicketClassificationBloc>(context)
    //       .add(TickiteClassificationEvent(
    //     endDate: selectedate.lastOrNull,
    //     startDate: selectedate.firstOrNull,
    //     selectedPipelineValue: selectedPipelineValue,
    //   ));

    //   BlocProvider.of<UserValidationBloc>(context).selectedPipelineId =
    //       selectedPipelineValue;
    //   BlocProvider.of<UserValidationBloc>(context).add(UserValidationsEvent(
    //     endDate: selectedate.lastOrNull,
    //     startDate: selectedate.firstOrNull,
    //     selectedPipelineValue: selectedPipelineValue,
    //   ));
    // }
  }

  Future<void> showSnackbar(BuildContext context, String text) async {
    final snackBar = SnackBar(
      backgroundColor: SupportBotColors.blueSecondary.shade100,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_active,
                color: SupportBotColors.bluePrimary.shade400,
              ),
              UIHelpers.horizontalSpaceSmall,
              Text(
                text,
                textAlign: TextAlign.center,
                style: SupportBotTextstyle.small,
              ),
            ],
          ),
          SnackBarAction(
            label: 'X',
            textColor: SupportBotColors.blueSecondary.shade500,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 300, vertical: 20),
      duration: const Duration(seconds: 5),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
