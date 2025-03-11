import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/header/nav_bar.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/landing_page/presentation/landing_page_bloc/landing_page_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/widgets/ticket_classification_pipeline_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class LandingPageDesktopView extends StatelessWidget {
  LandingPageDesktopView({super.key});
  final s = serviceLocator<S>();
  final ValueNotifier<List<DateTime>?> selectedDatesNotifier =
      ValueNotifier<List<DateTime>?>(null);
  final ValueNotifier<String> selectedPipelineNotifier = ValueNotifier("");
  final GetAllPipelinesAttributeModel getAllPipelinesAttributeModel =
      GetAllPipelinesAttributeModel();
  List<String>? pipelineIds = [];
  List<DateTime?> selectedate = [];
  String? selectedPipelineName = "";
  List<String> selectedItems = [];
  String? pipelineId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        NavBar(
          showPopArrow: false,
          navigateTo: () {},
          text: "",
        ),
        UIHelpers.verticalSpaceRegular,
        Container(
            alignment: Alignment.center,
             child: _filter(context)),
      ],
    );
  }

  Widget _filter(BuildContext context) {
    return Container(
      width: 698,
      height: UIHelpers.screenHeight(context) * 0.85,
      constraints: const BoxConstraints(),
      decoration: BoxDecoration(
          border: Border.all(color: SupportBotColors.gray),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImg(),
          _buildHeaderText(),
          UIHelpers.verticalSpace(32),
          _buildTitle(),
          UIHelpers.verticalSpaceRegular,
          _buildPipelineDropdown(context),
          UIHelpers.verticalSpace(28),
          _buildDateRangeSelector(context),
          UIHelpers.verticalSpace(54),
          _buildApplyFilterButton(context),
        ],
      ),
    );
  }

  Widget _buildImg() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Image.asset('assets/images/group.jpg'),
    );
  }

  Widget _buildHeaderText() {
    return Text(
      "Welcome Aboard!",
      style: SupportBotTextstyle.subheadingH3.copyWith(
        fontWeight: FontWeight.w500,
        color: SupportBotColors.black,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "Select Pipeline/Pipelines to view dashboard",
      style: SupportBotTextstyle.sidebarTitle.copyWith(
        color: SupportBotColors.black,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildPipelineDropdown(BuildContext context) {
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
            List<GetAllPipelineData> items =
                state.getAllPipelinesAttributeModel?.data ?? [];

            return ValueListenableBuilder<String>(
              valueListenable: selectedPipelineNotifier,
              builder: (context, selectedPipeline, child) {
                return Container(
                  height: 40,
                  width: UIHelpers.screenHeight(context) * 0.5,
                  child: TicketClassificationPipelineWidget(
                    hintText: selectedPipeline.isEmpty
                        ? "Pipeline"
                        : selectedPipeline,
                    items: items,
                    selectedItem: selectedPipeline,
                    onChanged: (selectedName) async {
                      selectedPipelineNotifier.value = selectedName;
                      BlocProvider.of<LandingPageBloc>(context).selectedName =
                          selectedName;
                      pipelineId = BlocProvider.of<LandingPageBloc>(context)
                          .selectedPipelineId;
                      _onPipelineSelectionChanged([selectedName], items);
                      selectedPipelineName =
                          BlocProvider.of<LandingPageBloc>(context)
                                  .selectedName ??
                              "";
                    },
                  ),
                );
              },
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
      List<String> selectedNames, List<GetAllPipelineData> items) async {
    pipelineIds = [];
    for (var selectedName in selectedNames) {
      final matchingItem = items.firstWhere(
        (item) => item.pipelineName == selectedName,
        orElse: () => GetAllPipelineData(pipelineName: '', pipelineId: ''),
      );
      if (matchingItem.pipelineId?.isNotEmpty == true) {
        pipelineIds?.add(matchingItem.pipelineId ?? "");
      }
    }

    selectedPipelineNotifier.value = selectedNames.join(", ");
  }

  Widget _buildDateRangeSelector(BuildContext context) {
    if (selectedate.isEmpty) {
      selectedate = [
        DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0),
        DateTime.now()
            .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999)
      ];
    }

    return Center(
      child: ValueListenableBuilder<List<DateTime>?>(
        valueListenable: selectedDatesNotifier,
        builder: (context, selectedDates, child) {
          DateTime startDate = DateTime.now()
              .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);

          DateTime endDate = DateTime.now()
              .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
          ;

          if (selectedDates != null && selectedDates.isNotEmpty) {
            startDate = selectedDates.first;
            endDate = selectedDates.length > 1 ? selectedDates[1] : startDate;
          }

          return Container(
            height: 40,
            width: UIHelpers.screenHeight(context) * 0.5,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: SupportBotColors.bluePrimary),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => _pickDateRange(context),
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

  Future<void> _pickDateRange(BuildContext context) async {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
      dayTextStyle: SupportBotTextstyle.hint
          .copyWith(color: SupportBotColors.black, fontWeight: FontWeight.bold),
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: SupportBotColors.bluePrimary,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: SupportBotTextstyle.hint
          .copyWith(color: SupportBotColors.black, fontWeight: FontWeight.bold),
      selectableDayPredicate: (date) => date.isBefore(DateTime.now()),
    );

    final pickedDates = await showCalendarDatePicker2Dialog(
      context: context,
      config: config,
      dialogSize: const Size(400, 400),
      borderRadius: BorderRadius.circular(15),
      value: selectedDatesNotifier.value?.cast<DateTime?>() ?? [],
      dialogBackgroundColor: SupportBotColors.white,
    );

    if (pickedDates != null) {
      selectedDatesNotifier.value = pickedDates.cast<DateTime>();
      selectedate = pickedDates;
    }
  }

  Widget _buildApplyFilterButton(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedPipelineNotifier,
      builder: (context, selectedPipeline, child) {
        bool isPipelineSelected = pipelineIds?.isNotEmpty ?? false;

        return SizedBox(
          height: 40,
          child: ElevatedButton.icon(
            onPressed: isPipelineSelected ? () => _addEvents(context) : null,
            iconAlignment: IconAlignment.end,
            label: Text(s.getStartedText,
                style: SupportBotTextstyle.dateText
                    .copyWith(color: SupportBotColors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: isPipelineSelected
                  ? SupportBotColors.bluePrimary
                  : SupportBotColors.gray,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            icon:
                const Icon(Icons.arrow_forward, color: SupportBotColors.white),
          ),
        );
      },
    );
  }

  void _addEvents(BuildContext context) async {
    String cleanedId = pipelineIds != null && pipelineIds!.isNotEmpty
        ? pipelineIds![0].replaceAll("[]", "")
        : "";
    await GoRouter.of(context).push(
      '/dashboard?pipelineName=$selectedPipelineName&pipelineId=$cleanedId&startDate=${selectedate.firstOrNull}&endDate=${selectedate.lastOrNull}',
    );
  }
}
