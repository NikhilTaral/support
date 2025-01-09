import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_all_pipelines_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/get_all_pipeline_bloc/get_all_pipeline_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/multipal_pipeline_Widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';
import 'package:intl/intl.dart';

class HomeFiltersWidget extends StatefulWidget {
  HomeFiltersWidget({super.key});

  @override
  _HomeFiltersWidgetState createState() => _HomeFiltersWidgetState();
}

class _HomeFiltersWidgetState extends State<HomeFiltersWidget> {
  final ValueNotifier<List<DateTime>?> selectedDatesNotifier =
      ValueNotifier<List<DateTime>?>(null);
  List<String> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetAllPipelineBloc()..add(GetAllPiplineInitialEvent()),
      child: BlocBuilder<GetAllPipelineBloc, GetAllPipelineState>(
        builder: (context, state) {
          if (state is GetAllAllPipelineSuccessState) {
            List<Datums> items = state.attributeModel?.data ?? [];
            return Container(
              height: 60,
              width: UIHelpers.screenWidth(context) * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      child: DropdownWithCheckbox(
                        hintText: "Pipelines",
                        items: items,
                        selectedItems: selectedItems,
                        onChanged: (value) {
                          setState(() {
                            selectedItems = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: ValueListenableBuilder<List<DateTime>?>(
                        valueListenable: selectedDatesNotifier,
                        builder: (context, selectedDates, child) {
                          final startDate = selectedDates?.isNotEmpty == true
                              ? selectedDates![0]
                              : null;
                          final endDate = (selectedDates?.length ?? 0) > 1
                              ? selectedDates![1]
                              : null;

                          return OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: SupportBotColors.bluePrimary),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 19),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              final config =
                                  CalendarDatePicker2WithActionButtonsConfig(
                                calendarViewScrollPhysics:
                                    const NeverScrollableScrollPhysics(),
                                dayTextStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                                calendarType: CalendarDatePicker2Type.range,
                                selectedDayHighlightColor:
                                    SupportBotColors.bluePrimary,
                                closeDialogOnCancelTapped: true,
                                firstDayOfWeek: 1,
                                weekdayLabelTextStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                              final pickedDates =
                                  await showCalendarDatePicker2Dialog(
                                context: context,
                                config: config,
                                dialogSize: const Size(325, 370),
                                borderRadius: BorderRadius.circular(15),
                                value: selectedDatesNotifier.value
                                        ?.cast<DateTime?>() ??
                                    [],
                                dialogBackgroundColor: Colors.white,
                              );

                              if (pickedDates != null) {
                                selectedDatesNotifier.value =
                                    pickedDates.cast<DateTime>();
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.calendar_month_outlined,
                                    color: SupportBotColors.bluePrimary),
                                const SizedBox(width: 8),
                                Text(
                                  startDate != null && endDate != null
                                      ? '${DateFormat('MMM dd').format(startDate)} - ${DateFormat('MMM dd yyyy').format(endDate)}'
                                      : '${DateFormat('MMM dd').format(DateTime.now())} - ${DateFormat('MMM dd yyyy').format(DateTime.now())}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: SupportBotColors.bluePrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Apply Filter',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 19),
                        backgroundColor: SupportBotColors.bluePrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is GetAllPipelineLoadingState) {
            return LoadingWidget(width: 60, height: 20);
          } else if (state is GetAllPipelineFailureState) {
            return Text("No data Found");
          }
          return Text("No data Found");
        },
      ),
    );
  }
}
