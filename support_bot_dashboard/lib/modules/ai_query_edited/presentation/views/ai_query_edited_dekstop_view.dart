import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/domain/entities/ai_query_answer_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/bloc/ai_query_bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/custom_pagination_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/pluto_table_widget.dart';
import 'package:support_bot_dashboard/utils/report_utils.dart';
import 'package:support_bot_dashboard/utils/service/instance_sharing_service.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class AIQueryEditedDesktopView extends StatelessWidget {
  AIQueryEditedDesktopView({super.key});

  final ValueNotifier<int> currentPage = ValueNotifier<int>(1);
  final ValueNotifier<int> pageSize = ValueNotifier<int>(10);
  final AiQueryAttributeModel aiQueryAttributeModel = AiQueryAttributeModel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiQueryBloc, AiQueryState>(
      builder: (context, state) {
        currentPage.value = BlocProvider.of<AiQueryBloc>(context).page;
        if (state is AIQuerySuccessState) {
          debugPrint("currentPage.value :${currentPage.value}");
          serviceLocator<InstanceSharingService>().aiQueryBloc =
              BlocProvider.of<AiQueryBloc>(context);
          final utils = ReportUtils(
              context: context,
              aiQueryAttributeModel: state.dashboardDataModel);

          return Column(
            children: [
              Flexible(
                child: PlutoTableWidget(
                  columns: utils.createAIQueryEditedColumn(context: context),
                  rows: utils.createAIQueryEditedRow(
                      aiQueryAttributeModel:
                          state.dashboardDataModel ?? AiQueryAttributeModel()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Items per page:   ",
                          style: TextStyle(
                              color: SupportBotColors.disablePrimary.shade700,
                              fontWeight: FontWeight.w500),
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: pageSize,
                          builder: (context, value, child) {
                            return CustomPaginationDropdown(
                              selectedValue: value,
                              items: const [10, 25, 50],
                              onChanged: (value) {
                                if (value != null) {
                                  pageSize.value = value;
                                  currentPage.value = 1;

                                  BlocProvider.of<AiQueryBloc>(context).add(
                                    AIQueryInitialEvent(
                                      startDate: state.startDate,
                                      endDate: state.endDate,
                                      selectedPipelineValueList:
                                          state.selectedPipelineValue,
                                      classificationFilterValue:
                                          state.classificationFilterValue,
                                      page: currentPage.value,
                                      pageSize: pageSize.value,
                                    ),
                                  );
                                }
                              },
                              width: 60,
                              height: 40,
                            );
                          },
                        ),
                      ],
                    ),
                    UIHelpers.horizontalSpaceRegular,
                    Row(
                      children: [
                        Text(
                          "${(currentPage.value - 1) * pageSize.value + 1} - "
                          "${(currentPage.value * pageSize.value > (state.dashboardDataModel?.data?.totalRecords ?? 0)) ? state.dashboardDataModel?.data?.totalRecords ?? 0 : currentPage.value * pageSize.value} of "
                          "${state.dashboardDataModel?.data?.totalRecords ?? 0}",
                          style: TextStyle(
                            color: SupportBotColors.disablePrimary.shade500,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: currentPage.value > 1
                              ? () {
                                  currentPage.value--;
                                  BlocProvider.of<AiQueryBloc>(context).add(
                                    AIQueryInitialEvent(
                                      startDate: state.startDate,
                                      endDate: state.endDate,
                                      selectedPipelineValueList:
                                          state.selectedPipelineValue,
                                      classificationFilterValue:
                                          state.classificationFilterValue,
                                      page: currentPage.value,
                                      pageSize: pageSize.value,
                                    ),
                                  );
                                }
                              : null,
                          icon: const Icon(Icons.arrow_back_ios_new, size: 15),
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: currentPage,
                          builder: (context, page, _) {
                            return Text(
                              'Page ${currentPage.value}',
                              style: TextStyle(
                                  color:
                                      SupportBotColors.disablePrimary.shade700,
                                  fontWeight: FontWeight.w500),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: (currentPage.value * pageSize.value) <
                                  (state.dashboardDataModel?.data
                                          ?.totalRecords ??
                                      0)
                              ? () {
                                  currentPage.value++;
                                  BlocProvider.of<AiQueryBloc>(context).add(
                                    AIQueryInitialEvent(
                                      startDate: state.startDate,
                                      endDate: state.endDate,
                                      selectedPipelineValueList:
                                          state.selectedPipelineValue,
                                      classificationFilterValue:
                                          state.classificationFilterValue,
                                      page: currentPage.value,
                                      pageSize: pageSize.value,
                                    ),
                                  );
                                }
                              : null,
                          icon: const Icon(Icons.arrow_forward_ios, size: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is AIQueryLoadingState) {
          return LoadingWidget(
            radius: 8,
            height: UIHelpers.screenHeight(context),
            width: UIHelpers.screenWidth(context),
          );
        } else if (state is AIQueryFailureState) {
          return FailureWidget(
            borderRadius: BorderRadius.circular(8),
            onTap: () {},
          );
        } else if (state is AIQueryEmptyState) {
          return const Align(
              alignment: Alignment.topCenter, child: EmptyWidget());
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
