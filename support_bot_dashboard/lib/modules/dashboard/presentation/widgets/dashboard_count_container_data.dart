import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';

class CountContainerData {
  final String text;
  final String iconPath;
  final double? count;

  CountContainerData({
    required this.text,
    required this.iconPath,
    required this.count,
  });
}

List<CountContainerData> getCountContainerData(BuildContext context,
    {DashboardDataModel? model, double totalCount = 0}) {
  return [
    CountContainerData(
      text: S.of(context).spam,
      iconPath: 'assets/icons/Spam.svg',
      count: model?.pieChartData?.data?.counts?.spamMarketing,
    ),
    CountContainerData(
      text: S.of(context).noActionRequired,
      iconPath: 'assets/icons/NotSpam.svg',
      count: model?.pieChartData?.data?.counts?.noActionRequired,
    ),
    CountContainerData(
      text: S.of(context).genuineQuery,
      iconPath: 'assets/icons/genuine.svg',
      count: model?.pieChartData?.data?.counts?.genuineQuery,
    ),
    CountContainerData(
      text: S.of(context).acknowledgementRequired,
      iconPath: 'assets/icons/acknowledgement.svg',
      count: model?.pieChartData?.data?.counts?.acknowledgementRequired,
    ),
    CountContainerData(
      text: S.of(context).total,
      iconPath: 'assets/icons/TotalTicket.svg',
      count: (model?.pieChartData?.data?.counts?.spamMarketing ?? 0) +
          (model?.pieChartData?.data?.counts?.noActionRequired ?? 0) +
          (model?.pieChartData?.data?.counts?.genuineQuery ?? 0) +
          (model?.pieChartData?.data?.counts?.acknowledgementRequired ?? 0) +
          (model?.pieChartData?.data?.counts?.notClassified ?? 0),
    ),
  ];
}
