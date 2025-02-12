import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/domain/entities/ai_query_answer_attribute_model.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/bloc/ai_query_bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/custom_pagination_dropdown.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/failure_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/loading_widget.dart';
import 'package:support_bot_dashboard/utils/common_widgets/pluto_table_widget.dart';
import 'package:support_bot_dashboard/utils/report_utils.dart';
import 'package:support_bot_dashboard/utils/service/instance_sharing_service.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class AIQueryEditedDesktopView extends StatelessWidget {
  AIQueryEditedDesktopView({super.key});
  final ValueNotifier<num> currentPage = ValueNotifier<num>(1);
  final AiQueryAttributeModel aiQueryAttributeModel = AiQueryAttributeModel();
  final s = serviceLocator<S>();
  @override
  Widget build(BuildContext context) {
    final aiQueryBloc = BlocProvider.of<AiQueryBloc>(context);
    return BlocBuilder<AiQueryBloc, AiQueryState>(
      builder: (context, state) {
        currentPage.value = BlocProvider.of<AiQueryBloc>(context).page;
        if (state is AIQuerySuccessState) {
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
                          s.itemsPerPageText,
                          style: SupportBotTextstyle.hint.copyWith(
                            color: SupportBotColors.disablePrimary.shade400,
                          ),
                        ),
                        ValueListenableBuilder<num>(
                          valueListenable:
                              ValueNotifier<num>(aiQueryBloc.pageSize),
                          builder: (context, value, child) {
                            return CustomPaginationDropdown(
                              selectedValue: value,
                              items: const [10, 25, 50, 100, 250],
                              onChanged: (value) {
                                if (value != null) {
                                  BlocProvider.of<AiQueryBloc>(context)
                                      .pageSize = value;
                                  currentPage.value = 1;
                                  if (state.selectedPipelineValue?.isNotEmpty ==
                                          true ||
                                      state.selectedPipelineValue != null) {
                                    return BlocProvider.of<AiQueryBloc>(context)
                                        .add(
                                      AIQueryInitialEvent(
                                        startDate: state.endDate,
                                        endDate: state.startDate,
                                        selectedPipelineValueList:
                                            state.selectedPipelineValue ?? "",
                                        classificationFilterValue: aiQueryBloc
                                            .classificationFilterValue,
                                        page: currentPage.value,
                                        pageSize: aiQueryBloc.pageSize,
                                      ),
                                    );
                                  } else {
                                    BlocProvider.of<AiQueryBloc>(context).add(
                                      AIQueryInitialEvent(
                                        startDate: state.endDate,
                                        endDate: state.startDate,
                                        selectedPipelineValueList:
                                            state.selectedPipelineValue ?? "",
                                        classificationFilterValue: aiQueryBloc
                                            .classificationFilterValue,
                                        page: currentPage.value,
                                        pageSize: aiQueryBloc.pageSize,
                                      ),
                                    );
                                  }
                                }
                              },
                              width: 70,
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
                          "${(currentPage.value - 1) * aiQueryBloc.pageSize + 1} - "
                          "${(currentPage.value * aiQueryBloc.pageSize > (state.dashboardDataModel?.data?.totalRecords ?? 0)) ? state.dashboardDataModel?.data?.totalRecords ?? 0 : currentPage.value * aiQueryBloc.pageSize} of "
                          "${state.dashboardDataModel?.data?.totalRecords ?? 0}",
                          style: SupportBotTextstyle.hint.copyWith(
                            color: SupportBotColors.disablePrimary.shade500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: currentPage.value > 1
                              ? () {
                                  currentPage.value--;
                                  BlocProvider.of<AiQueryBloc>(context).add(
                                    AIQueryInitialEvent(
                                      startDate: state.endDate,
                                      endDate: state.startDate,
                                      selectedPipelineValueList:
                                          state.selectedPipelineValue,
                                      classificationFilterValue:
                                          aiQueryBloc.classificationFilterValue,
                                      page: currentPage.value,
                                      pageSize: aiQueryBloc.pageSize,
                                    ),
                                  );
                                }
                              : null,
                          icon: const Icon(Icons.arrow_back_ios_new, size: 15),
                        ),
                        ValueListenableBuilder<num>(
                          valueListenable: currentPage,
                          builder: (context, page, _) {
                            return Text(
                              '${s.pageText} ${currentPage.value}',
                              style: SupportBotTextstyle.hint.copyWith(
                                color: SupportBotColors.disablePrimary.shade400,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: (currentPage.value *
                                      aiQueryBloc.pageSize) <
                                  (state.dashboardDataModel?.data
                                          ?.totalRecords ??
                                      0)
                              ? () {
                                  currentPage.value++;
                                  BlocProvider.of<AiQueryBloc>(context).add(
                                    AIQueryInitialEvent(
                                      startDate: state.endDate,
                                      endDate: state.startDate,
                                      selectedPipelineValueList:
                                          state.selectedPipelineValue,
                                      classificationFilterValue:
                                          aiQueryBloc.classificationFilterValue,
                                      page: currentPage.value,
                                      pageSize: aiQueryBloc.pageSize,
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
