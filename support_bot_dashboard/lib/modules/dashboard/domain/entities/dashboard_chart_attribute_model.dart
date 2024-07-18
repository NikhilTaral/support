import 'package:equatable/equatable.dart';

class DashboardChartAttributeModel extends Equatable{
  final num? genuineQuery;
  final num? noActionRequired;
  final num? spamMarketing;
  final num? acknowledgement;

  const DashboardChartAttributeModel({this.genuineQuery, this.noActionRequired, this.spamMarketing, this.acknowledgement});

   @override
  List<Object?> get props => [
        genuineQuery,
        noActionRequired,
        spamMarketing,
        acknowledgement
      ];
}