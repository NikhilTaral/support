import 'package:equatable/equatable.dart';

class DashboardChartAttributeModel extends Equatable{
  final num? genuineQuery;
  final num? noActionRequired;
    final int? spamMarketing;

  const DashboardChartAttributeModel({required this.genuineQuery, required this.noActionRequired, required this.spamMarketing});

   @override
  List<Object?> get props => [
        genuineQuery,
        noActionRequired,
        spamMarketing
      ];
}