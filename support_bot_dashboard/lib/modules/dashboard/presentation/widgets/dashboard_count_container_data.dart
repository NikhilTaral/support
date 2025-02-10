import 'dart:math';

import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';

class CountContainerData {
  final String text;
  final IconData icon;
  final double? count;

  CountContainerData({
    required this.text,
    required this.icon,
    required this.count,
  });
}

List<CountContainerData> getCountContainerData(BuildContext context,
    {DashboardDataModel? model, double totalCount = 0}) {
  return [
    CountContainerData(
      text: S.of(context).spam,
      icon: SupportBotIcons.infoCircle,
      count: model?.pieChartData?.data?.counts?.spamMarketing,
    ),
    CountContainerData(
      text: S.of(context).noActionRequired,
      icon: SupportBotIcons.tickcircle,
      count: model?.pieChartData?.data?.counts?.noActionRequired,
    ),
    CountContainerData(
      text: S.of(context).genuineQuery,
      icon: SupportBotIcons.list,
      count: model?.pieChartData?.data?.counts?.genuineQuery,
    ),
    CountContainerData(
      text: S.of(context).acknowledgementRequired,
      icon: SupportBotIcons.list,
      count: model?.pieChartData?.data?.counts?.acknowledgementRequired,
    ),
        CountContainerData(
      text: S.of(context).notClassified,
      icon: SupportBotIcons.star1,
      count: model?.pieChartData?.data?.counts?.notClassified,
    ),
    CountContainerData(
      text: S.of(context).total,
      icon: SupportBotIcons.tickcircle4,
      count: (model?.pieChartData?.data?.counts?.spamMarketing ?? 0) +
          (model?.pieChartData?.data?.counts?.noActionRequired ?? 0) +
          (model?.pieChartData?.data?.counts?.genuineQuery ?? 0) +
          (model?.pieChartData?.data?.counts?.acknowledgementRequired ?? 0) +
          (model?.pieChartData?.data?.counts?.notClassified ?? 0),
    ),
  ];
}
