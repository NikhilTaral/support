// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:support_bot_dashboard/generated/l10n.dart';
// import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_model.dart';
// import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_chart_attribute_model.dart';
// import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_chart_attribute_model.dart';
// import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_get_validation_count_attribute_model.dart';
// import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_user_settings_attribute_model.dart';
// import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_validation_by_count_attribute_model.dart';
// import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
// import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
// import 'package:support_bot_dashboard/utils/theme/colors.dart';
// import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
// import 'package:support_bot_dashboard/utils/ui_helpers.dart';

// class PieChartWidget extends StatefulWidget {
//   Object? data;
//   ValidationCountAttributeModel? validationCount;
//   GetValidationByCountAttributeModel? validationByCount;
//   GetUserSettingsAttributeModel? userSettingsData;
//   final bool isAIQuery;
//   DateTime? selectedDate;
//   String? pipeline;

//   PieChartWidget(
//       {super.key,
//       this.data,
//       this.isAIQuery = false,
//       this.validationCount,
//       this.userSettingsData,
//       this.validationByCount,
//       this.selectedDate,
//       this.pipeline});

//   @override
//   State<PieChartWidget> createState() => PieChartWidgetState();
// }

// class PieChartWidgetState extends State<PieChartWidget> {
//   int? touchedIndex;
//   int currentChartIndex = 0;

//   PieChartWidgetState();

//   @override
//   Widget build(BuildContext context) {
//     List<Color> blueShades = [
//       const Color.fromARGB(255, 153, 172, 187),
//       const Color.fromARGB(255, 61, 121, 170),
//       const Color.fromARGB(255, 28, 88, 136),
//       const Color.fromARGB(255, 17, 58, 98),
//     ];
//     double radius = UIHelpers.screenWidth(context) * 0.08;

//     List<ChartData> chartData = _getChartData();
//     final nonZeroChartData = chartData
//         .where((data) => data.value != null && data.value! > 0)
//         .toList();

//     return Padding(
//       padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
//       child: Container(
//         height: UIHelpers.screenHeight(context) * 0.77,
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.grey.shade300,
//             width: 1.0,
//           ),
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Column(
//           children: [
//             UIHelpers.verticalSpaceRegular,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (widget.isAIQuery == false)
//                   IconButton(
//                     onPressed: currentChartIndex > 0
//                         ? () {
//                             setState(() {
//                               print('before index: $currentChartIndex');
//                               currentChartIndex--;
//                             });
//                           }
//                         : null,
//                     icon: const Icon(
//                       Icons.arrow_back_ios,
//                       size: 15,
//                     ),
//                   ),
//                 Expanded(
//                   child: Text(
//                     currentChartIndex == 0
//                         ? widget.isAIQuery
//                             ? S.of(context).aiQueryAnswer
//                             : S.of(context).ticketClassification
//                         : currentChartIndex == 1
//                             ? S.of(context).validationStatus
//                             : S.of(context).userValidation,
//                     style: SupportBotTextstyle.pierchartHeading,
//                     textAlign: TextAlign.center,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 if (widget.isAIQuery == false)
//                   IconButton(
//                     onPressed: currentChartIndex < 2
//                         ? () {
//                             setState(() {
//                               print(
//                                   'before increment: $currentChartIndex'); // Check index before increment
//                               currentChartIndex++;
//                               print(
//                                   'after increment: $currentChartIndex'); // Check index after increment
//                             }); // Call outside of setState
//                           }
//                         : null,
//                     icon: const Icon(
//                       Icons.arrow_forward_ios,
//                       size: 15,
//                     ),
//                   ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 10, left: 10),
//               child: Divider(color: SupportBotColors.blueSecondary.shade200),
//             ),
//             if (nonZeroChartData.isEmpty)
//               SizedBox(
//                   width: UIHelpers.screenWidth(context) * 0.19,
//                   height: UIHelpers.screenHeight(context) * 0.6,
//                   child: const Center(child: EmptyWidget())),
//             if (nonZeroChartData.isNotEmpty)
//               SizedBox(
//                 height: UIHelpers.screenHeight(context) * 0.5,
//                 child: PieChart(
//                   PieChartData(
//                     pieTouchData: PieTouchData(
//                       touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                         setState(() {
//                           if (!event.isInterestedForInteractions ||
//                               pieTouchResponse == null ||
//                               pieTouchResponse.touchedSection == null) {
//                             touchedIndex = -1;
//                             return;
//                           }
//                           touchedIndex = pieTouchResponse
//                                   .touchedSection?.touchedSectionIndex ??
//                               0;
//                         });
//                       },
//                     ),
//                     centerSpaceRadius: 1,
//                     sectionsSpace: 1,
//                     sections: List.generate(
//                       nonZeroChartData.length,
//                       (index) {
//                         final isTouched = index == touchedIndex;
//                         final double fontSize = isTouched ? 12 : 14;
//                         return PieChartSectionData(
//                           value: nonZeroChartData[index].value?.toDouble() ??
//                               0.0,
//                           title: isTouched
//                               ? '${nonZeroChartData[index].label}\n${nonZeroChartData[index].value}'
//                               : null,
//                           color: blueShades[index % blueShades.length],
//                           radius: radius,
//                           titleStyle:
//                               SupportBotTextstyle.pierchartNormal.copyWith(
//                             fontSize: fontSize,
//                           ),
//                           showTitle: true,
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             UIHelpers.verticalSpaceTinySmall,
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: List.generate(
//                     nonZeroChartData.length,
//                     (index) => Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0),
//                       child: _piechartDetails(
//                         color: blueShades[index % blueShades.length],
//                         label: nonZeroChartData[index].label ?? '',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _piechartDetails({required Color color, required String label}) {
//     return Row(
//       children: [
//         Container(
//           width: UIHelpers.screenWidth(context) * 0.01,
//           height: UIHelpers.screenHeight(context) * 0.02,
//           color: color,
//         ),
//         UIHelpers.horizontalSpaceTiny,
//         Text(
//           label,
//           style: SupportBotTextstyle.pierchartLabel,
//           softWrap: true,
//           overflow: TextOverflow.visible,
//         ),
//       ],
//     );
//   }

//   List<ChartData> _getChartData() {
//     if (currentChartIndex == 0) {
//       if (widget.isAIQuery &&
//           widget.data is DashboardAiQueryChartAttributeModel) {
//         final aiData = widget.data as DashboardAiQueryChartAttributeModel;
//         return [
//           ChartData(label: 'AI Query Answer', value: aiData.aiQueryAnswer ?? 0),
//           ChartData(
//               label: 'AI Query Not Answer',
//               value: aiData.aiQueryNotAnswer ?? 0),
//         ];
//       } else if (widget.data is DashboardChartAttributeModel) {
//         final dashboardData = widget.data as DashboardChartAttributeModel;
//         return [
//           ChartData(
//               label: S.of(context).genuineQuery,
//               value: dashboardData.genuineQuery ?? 0),
//           ChartData(
//               label: S.of(context).noActionRequired,
//               value: dashboardData.noActionRequired ?? 0),
//           ChartData(
//               label: S.of(context).spam,
//               value: dashboardData.spamMarketing ?? 0),
//           ChartData(
//               label: S.of(context).acknowledgementRequired,
//               value: dashboardData.acknowledgement ?? 0)
//         ];
//       }
//     } else if (currentChartIndex == 1) {
//       return [
//         ChartData(
//             label: 'Correct', value: widget.validationCount?.correct ?? 0),
//         ChartData(
//             label: 'Incorrect', value: widget.validationCount?.incorrect ?? 0),
//         ChartData(
//             label: 'Not Validated',
//             value: widget.validationCount?.notValidated ?? 0)
//       ];
//     } else if (currentChartIndex == 2) {
//       if (widget.validationByCount?.data != null) {
//         return widget.validationByCount!.data!.entries.map((entry) {
//           final email = entry.key;
//           final name = email.split('@').first.replaceAll('.', ' ').capitalize();
//           return ChartData(label: name, value: entry.value);
//         }).toList();
//       }
//     }
//     return [];
//   }
// }

// extension StringExtension on String {
//   String capitalize() {
//     return split(' ')
//         .map((word) => word[0].toUpperCase() + word.substring(1))
//         .join(' ');
//   }
// }

/************************************************************************************************************* */

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:support_bot_dashboard/generated/l10n.dart';
// import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_model.dart';
// import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_chart_attribute_model.dart';
// import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_chart_attribute_model.dart';
// import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_get_validation_count_attribute_model.dart';
// import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_user_settings_attribute_model.dart';
// import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_validation_by_count_attribute_model.dart';
// import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/uservaidation_barchart.dart';
// import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
// import 'package:support_bot_dashboard/utils/theme/colors.dart';
// import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
// import 'package:support_bot_dashboard/utils/ui_helpers.dart';

// class PieChartWidget extends StatefulWidget {
//   final Object? data;
//   final ValidationCountAttributeModel? validationCount;
//   final GetValidationByCountAttributeModel? validationByCount;
//   final GetUserSettingsAttributeModel? userSettingsData;
//   final bool isAIQuery;

//   const PieChartWidget(
//       {super.key,
//       this.data,
//       this.isAIQuery = false,
//       this.validationCount,
//       this.userSettingsData,
//       this.validationByCount});

//   @override
//   State<PieChartWidget> createState() => PieChartWidgetState();
// }

// class PieChartWidgetState extends State<PieChartWidget> {
//   int? touchedIndex;
//   int currentChartIndex = 0;

//   PieChartWidgetState();

//   @override
//   Widget build(BuildContext context) {
//     List<Color> blueShades = [
//       const Color.fromARGB(255, 153, 172, 187),
//       const Color.fromARGB(255, 61, 121, 170),
//       const Color.fromARGB(255, 28, 88, 136),
//       const Color.fromARGB(255, 17, 58, 98),
//     ];
//     double radius = UIHelpers.screenWidth(context) * 0.08;

//     List<ChartData> chartData = _getChartData();
//     final nonZeroChartData = chartData
//         .where((data) => data.value != null && data.value! > 0)
//         .toList();

//     return Padding(
//       padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
//       child: Container(
//         height: UIHelpers.screenHeight(context) * 0.77,
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.grey.shade300,
//             width: 1.0,
//           ),
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Column(
//           children: [
//             UIHelpers.verticalSpaceRegular,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (widget.isAIQuery == false)
//                   IconButton(
//                     onPressed: currentChartIndex > 0
//                         ? () {
//                             setState(() {
//                               currentChartIndex--;
//                             });
//                           }
//                         : null,
//                     icon: const Icon(
//                       Icons.arrow_back_ios,
//                       size: 15,
//                     ),
//                   ),
//                 Expanded(
//                   child: Text(
//                     currentChartIndex == 0
//                         ? widget.isAIQuery
//                             ? S.of(context).aiQueryAnswer
//                             : S.of(context).ticketClassification
//                         : currentChartIndex == 1
//                             ? S.of(context).validationStatus
//                             : S.of(context).userValidation,
//                     style: SupportBotTextstyle.pierchartHeading,
//                     textAlign: TextAlign.center,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 if (widget.isAIQuery == false)
//                   IconButton(
//                     onPressed: currentChartIndex < 2
//                         ? () {
//                             setState(() {
//                               currentChartIndex++;
//                             });
//                           }
//                         : null,
//                     icon: const Icon(
//                       Icons.arrow_forward_ios,
//                       size: 15,
//                     ),
//                   ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 10, left: 10),
//               child: Divider(color: SupportBotColors.blueSecondary.shade200),
//             ),
//             if (currentChartIndex == 2 &&
//                 widget.validationByCount?.data != null)
//               Expanded(child: UserValidationBarChart(data: widget.validationByCount?.data)),
//             if (nonZeroChartData.isEmpty)
//               SizedBox(
//                   width: UIHelpers.screenWidth(context) * 0.19,
//                   height: UIHelpers.screenHeight(context) * 0.6,
//                   child: const Center(child: EmptyWidget())),
//             if(currentChartIndex == 0 || currentChartIndex ==1)
//             if (nonZeroChartData.isNotEmpty)
//               SizedBox(
//                 height: UIHelpers.screenHeight(context) * 0.5,
//                 child: PieChart(
//                   PieChartData(
//                     pieTouchData: PieTouchData(
//                       touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                         setState(() {
//                           if (!event.isInterestedForInteractions ||
//                               pieTouchResponse == null ||
//                               pieTouchResponse.touchedSection == null) {
//                             touchedIndex = -1;
//                             return;
//                           }
//                           touchedIndex = pieTouchResponse
//                                   .touchedSection?.touchedSectionIndex ??
//                               0;
//                         });
//                       },
//                     ),
//                     centerSpaceRadius: 1,
//                     sectionsSpace: 1,
//                     sections: List.generate(
//                       nonZeroChartData.length,
//                       (index) {
//                         final isTouched = index == touchedIndex;
//                         final double fontSize = isTouched ? 12 : 14;
//                         return PieChartSectionData(
//                           value:
//                               nonZeroChartData[index].value?.toDouble() ?? 0.0,
//                           title: isTouched
//                               ? '${nonZeroChartData[index].label}\n${nonZeroChartData[index].value}'
//                               : null,
//                           color: blueShades[index % blueShades.length],
//                           radius: radius,
//                           titleStyle:
//                               SupportBotTextstyle.pierchartNormal.copyWith(
//                             fontSize: fontSize,
//                           ),
//                           showTitle: true,
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             UIHelpers.verticalSpaceTinySmall,
//             if (currentChartIndex != 2)
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: List.generate(
//                       nonZeroChartData.length,
//                       (index) => Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 4.0),
//                         child: _piechartDetails(
//                           color: blueShades[index % blueShades.length],
//                           label: nonZeroChartData[index].label ?? '',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _piechartDetails({required Color color, required String label}) {
//     return Row(
//       children: [
//         Container(
//           width: UIHelpers.screenWidth(context) * 0.01,
//           height: UIHelpers.screenHeight(context) * 0.02,
//           color: color,
//         ),
//         UIHelpers.horizontalSpaceTiny,
//         Text(
//           label,
//           style: SupportBotTextstyle.pierchartLabel,
//           softWrap: true,
//           overflow: TextOverflow.visible,
//         ),
//       ],
//     );
//   }

//   List<ChartData> _getChartData() {
//     if (currentChartIndex == 0) {
//       if (widget.isAIQuery &&
//           widget.data is DashboardAiQueryChartAttributeModel) {
//         final aiData = widget.data as DashboardAiQueryChartAttributeModel;
//         return [
//           ChartData(label: 'AI Query Answer', value: aiData.aiQueryAnswer ?? 0),
//           ChartData(
//               label: 'AI Query Not Answer',
//               value: aiData.aiQueryNotAnswer ?? 0),
//         ];
//       } else if (widget.data is DashboardChartAttributeModel) {
//         final dashboardData = widget.data as DashboardChartAttributeModel;
//         return [
//           ChartData(
//               label: S.of(context).genuineQuery,
//               value: dashboardData.genuineQuery ?? 0),
//           ChartData(
//               label: S.of(context).noActionRequired,
//               value: dashboardData.noActionRequired ?? 0),
//           ChartData(
//               label: S.of(context).spam,
//               value: dashboardData.spamMarketing ?? 0),
//           ChartData(
//               label: S.of(context).acknowledgementRequired,
//               value: dashboardData.acknowledgement ?? 0)
//         ];
//       }
//     } else if (currentChartIndex == 1) {
//       return [
//         ChartData(
//             label: 'Correct', value: widget.validationCount?.correct ?? 0),
//         ChartData(
//             label: 'Incorrect', value: widget.validationCount?.incorrect ?? 0),
//         ChartData(
//             label: 'Not Validated',
//             value: widget.validationCount?.notValidated ?? 0)
//       ];
//     } else if (currentChartIndex == 2) {
//       if (widget.validationByCount?.data != null) {
//         return widget.validationByCount!.data!.entries.map((entry) {
//           final email = entry.key;
//           final name = email.split('@').first.replaceAll('.', ' ').capitalize();
//           return ChartData(label: name, value: entry.value);
//         }).toList();
//       }
//     }
//     return [];
//   }
// }

// // extension StringExtension on String {
// //   String capitalize() {
// //     return split(' ')
// //         .map((word) => word[0].toUpperCase() + word.substring(1))
// //         .join(' ');
// //   }
// // }

/*************************************************************************************************************** */

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_chart_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_chart_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_get_validation_count_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_user_settings_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_validation_by_count_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/user_validation_sidebar.dart';
import 'package:support_bot_dashboard/utils/common_widgets/empty_widget.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class PieChartWidget extends StatefulWidget {
  final Object? data;
  final ValidationCountAttributeModel? validationCount;
  final GetValidationByCountAttributeModel? validationByCount;
  final GetUserSettingsAttributeModel? userSettingsData;
  final bool isAIQuery;
  final DateTime? selectedDate;
  final String? pipeline;

  const PieChartWidget({
    super.key,
    this.data,
    this.isAIQuery = false,
    this.validationCount,
    this.userSettingsData,
    this.validationByCount,
    this.selectedDate,
    this.pipeline,
  });

  @override
  State<PieChartWidget> createState() => PieChartWidgetState();
}

class PieChartWidgetState extends State<PieChartWidget> {
  int? touchedIndex;
  int currentChartIndex = 0;
  bool showSidebar = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildMainChart(context),
        ),
      ],
    );
  }

  Widget _buildMainChart(BuildContext context) {
    List<Color> blueShades = [
      const Color.fromARGB(255, 153, 172, 187),
      const Color.fromARGB(255, 61, 121, 170),
      const Color.fromARGB(255, 28, 88, 136),
      const Color.fromARGB(255, 17, 58, 98),
    ];
    double radius = UIHelpers.screenWidth(context) * 0.08;

    List<ChartData> chartData = _getChartData();
    final nonZeroChartData = chartData
        .where((data) => data.value != null && data.value! > 0)
        .toList();

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
      child: Container(
        height: UIHelpers.screenHeight(context) * 0.77,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            UIHelpers.verticalSpaceRegular,
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Divider(color: SupportBotColors.blueSecondary.shade200),
            ),
            if (nonZeroChartData.isEmpty) _buildEmptyState(context),
            if (nonZeroChartData.isNotEmpty)
              _buildPieChart(nonZeroChartData, blueShades, radius),
            UIHelpers.verticalSpaceTinySmall,
            _buildLegend(nonZeroChartData, blueShades),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.isAIQuery == false)
          IconButton(
            onPressed: currentChartIndex > 0
                ? () {
                    setState(() {
                      currentChartIndex--;
                      showSidebar = false;
                    });
                  }
                : null,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 15,
            ),
          ),
        Expanded(
          child: Text(
            _getChartTitle(),
            style: SupportBotTextstyle.pierchartHeading,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (widget.isAIQuery == false && currentChartIndex != 2)
          IconButton(
            onPressed: currentChartIndex < 2
                ? () {
                    setState(() {
                      currentChartIndex++;
                    });
                  }
                : null,
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
        if (currentChartIndex == 2) _buildViewAllButton(),
      ],
    );
  }

  void _showSidebarDialog(BuildContext context) {
    final validationData = widget.validationByCount?.data ?? {};

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.only(
              left: UIHelpers.screenWidth(context) * 0.8, right: 0),
          child: SizedBox(
            width: UIHelpers.screenWidth(context) * 0.2,
            child: UserValidationSidebar(
              validationData: validationData,
            ),
          ),
        );
      },
    );
  }

  Widget _buildViewAllButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Tooltip(
        message: 'View All',
        child: SizedBox(
          width: 35,
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _showSidebarDialog(context);
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: SupportBotColors.bluePrimary.shade500,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8)
            ),
          
            child: const Icon(
              Icons.remove_red_eye,
              color: SupportBotColors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SizedBox(
      width: UIHelpers.screenWidth(context) * 0.19,
      height: UIHelpers.screenHeight(context) * 0.6,
      child: const Center(child: EmptyWidget()),
    );
  }

  Widget _buildPieChart(
      List<ChartData> nonZeroChartData, List<Color> blueShades, double radius) {
    return SizedBox(
      height: UIHelpers.screenHeight(context) * 0.5,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection?.touchedSectionIndex ?? 0;
              });
            },
          ),
          centerSpaceRadius: 1,
          sectionsSpace: 1,
          sections: List.generate(
            nonZeroChartData.length,
            (index) {
              final isTouched = index == touchedIndex;
              final double fontSize = isTouched ? 12 : 14;
              return PieChartSectionData(
                value: nonZeroChartData[index].value?.toDouble() ?? 0.0,
                title: isTouched
                    ? '${nonZeroChartData[index].label}\n${nonZeroChartData[index].value}'
                    : null,
                color: blueShades[index % blueShades.length],
                radius: radius,
                titleStyle: SupportBotTextstyle.pierchartNormal.copyWith(
                  fontSize: fontSize,
                ),
                showTitle: true,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(
      List<ChartData> nonZeroChartData, List<Color> blueShades) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            nonZeroChartData.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: _piechartDetails(
                color: blueShades[index % blueShades.length],
                label: nonZeroChartData[index].label ?? '',
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getChartTitle() {
    if (currentChartIndex == 0) {
      return widget.isAIQuery
          ? S.of(context).aiQueryAnswer
          : S.of(context).ticketClassification;
    } else if (currentChartIndex == 1) {
      return S.of(context).validationStatus;
    } else {
      return S.of(context).userValidation;
    }
  }

  Widget _piechartDetails({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: UIHelpers.screenWidth(context) * 0.01,
          height: UIHelpers.screenHeight(context) * 0.02,
          color: color,
        ),
        UIHelpers.horizontalSpaceTiny,
        Text(
          label,
          style: SupportBotTextstyle.pierchartLabel,
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }

  // Existing helper methods remain unchanged
  List<ChartData> _getAllValidationData() {
    if (widget.validationByCount?.data != null) {
      final List<MapEntry<String, int>> sortedEntries =
          widget.validationByCount?.data?.entries.toList() ?? []
            ..sort((a, b) => b.value.compareTo(a.value));

      return sortedEntries.map((entry) {
        final email = entry.key;
        final name =
            email.split('@').first.replaceAll('.', ' ').capitalizeLetter();
        return ChartData(label: name, value: entry.value);
      }).toList();
    }
    return [];
  }

  List<ChartData> _getChartData() {
    if (currentChartIndex == 0) {
      if (widget.isAIQuery &&
          widget.data is DashboardAiQueryChartAttributeModel) {
        final aiData = widget.data as DashboardAiQueryChartAttributeModel;
        return [
          ChartData(label: 'AI Query Answer', value: aiData.aiQueryAnswer ?? 0),
          ChartData(
              label: 'AI Query Not Answer',
              value: aiData.aiQueryNotAnswer ?? 0),
        ];
      } else if (widget.data is DashboardChartAttributeModel) {
        final dashboardData = widget.data as DashboardChartAttributeModel;
        return [
          ChartData(
              label: S.of(context).genuineQuery,
              value: dashboardData.genuineQuery ?? 0),
          ChartData(
              label: S.of(context).noActionRequired,
              value: dashboardData.noActionRequired ?? 0),
          ChartData(
              label: S.of(context).spam,
              value: dashboardData.spamMarketing ?? 0),
          ChartData(
              label: S.of(context).acknowledgementRequired,
              value: dashboardData.acknowledgement ?? 0)
        ];
      }
    } else if (currentChartIndex == 1) {
      return [
        ChartData(
            label: 'Correct', value: widget.validationCount?.correct ?? 0),
        ChartData(
            label: 'Incorrect', value: widget.validationCount?.incorrect ?? 0),
        ChartData(
            label: 'Not Validated',
            value: widget.validationCount?.notValidated ?? 0)
      ];
    } else if (currentChartIndex == 2) {
      // if (widget.validationByCount?.data != null) {
      //   final List<MapEntry<String, int>> sortedEntries =
      //       widget.validationByCount?.data?.entries.toList() ?? []
      //         ..sort((a, b) => b.value.compareTo(a.value));

      //   final topEntries = sortedEntries.take(5).toList();

      //   return topEntries.map((entry) {
      //     final email = entry.key;
      //     final name =
      //         email.split('@').first.replaceAll('.', ' ').capitalizeLetter();
      //     return ChartData(label: name, value: entry.value);
      //   }).toList();
      // }
        if (widget.validationByCount?.data != null && 
        widget.validationByCount!.data!.isNotEmpty) {
      final List<MapEntry<String, int>> sortedEntries =
          widget.validationByCount!.data!.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));

      final topEntries = sortedEntries.take(5).toList();

      return topEntries.map((entry) {
        final email = entry.key;
        final name =
            email.split('@').first.replaceAll('.', ' ').capitalizeLetter();
        return ChartData(label: name, value: entry.value);
      }).toList();
    } else {
      // Return an empty list or a default placeholder if no data
      return [
        ChartData(label: 'No Data', value: 0)
      ];
    }
    }
    return [];
  }
}

extension StringExtension on String {
  String capitalizeLetter() {
    return split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
