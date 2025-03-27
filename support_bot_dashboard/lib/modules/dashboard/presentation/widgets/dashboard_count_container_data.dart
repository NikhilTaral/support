import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_data_model.dart';
import 'package:support_bot_dashboard/utils/theme/icons.dart';
import 'package:support_bot_dashboard/utils/theme/iconsax.dart';

class CountContainerData {
  final String text;
  final IconData icon;
  final num? count;

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
      icon: SupportBotIcons.pentool,
      count: model?.pieChartData?.data?.counts?.acknowledgementRequired,
    ),
    CountContainerData(
      text: S.of(context).ticketNotClassified,
      icon: SupportBotIcons.star1,
      count: model?.pieChartData?.data?.counts?.unableToClassify,
    ),
    CountContainerData(
      text: S.of(context).awaitingToClassifyText,
      icon: Iconsax.hierarchy_2,
      count: model?.pieChartData?.data?.counts?.awaitingToClassify,
    ),
    CountContainerData(
      text: S.of(context).totalText,
      icon: SupportBotIcons.tickcircle4,
      count: model?.pieChartData?.data?.counts?.total,
    ),
  ];
}