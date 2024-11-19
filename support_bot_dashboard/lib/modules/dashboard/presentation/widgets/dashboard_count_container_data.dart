import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';

class CountContainerData {
  final String text;
  final String iconPath;
  final String count;

  CountContainerData({
    required this.text,
    required this.iconPath,
    required this.count,
  });
}

List<CountContainerData> getCountContainerData(BuildContext context,
    {DashboardDataSuccess? state, num totalCount = 0}) {
  return [
    CountContainerData(
      text: S.of(context).spam,
      iconPath: 'assets/icons/Spam.svg',
      count:
          state?.pieChartData?.data?.counts?.spamMarketing?.toString() ?? '0',
    ),
    CountContainerData(
      text: S.of(context).noActionRequired,
      iconPath: 'assets/icons/NotSpam.svg',
      count: state?.pieChartData?.data?.counts?.noActionRequired?.toString() ??
          '0',
    ),
    CountContainerData(
      text: S.of(context).genuineQuery,
      iconPath: 'assets/icons/genuine.svg',
      count: state?.pieChartData?.data?.counts?.genuineQuery?.toString() ?? '0',
    ),
    CountContainerData(
      text: S.of(context).acknowledgementRequired,
      iconPath: 'assets/icons/acknowledgement.svg',
      count: state?.pieChartData?.data?.counts?.acknowledgementRequired
              ?.toString() ??
          '0',
    ),
    CountContainerData(
      text: S.of(context).total,
      iconPath: 'assets/icons/TotalTicket.svg',
      count: state != null ? totalCount.toString() : '0',
    ),
  ];
}
