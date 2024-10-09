import 'package:equatable/equatable.dart';

class DashboardChartAttributeModel extends Equatable {
  final num? genuineQuery;
  final num? noActionRequired;
  final num? spamMarketing;
  final num? acknowledgement;
  final num? notClassified;

  const DashboardChartAttributeModel(
      {required this.genuineQuery,
      required this.noActionRequired,
      required this.spamMarketing,
      required this.acknowledgement,
      required this.notClassified
      });

  @override
  List<Object?> get props =>
      [genuineQuery, noActionRequired, spamMarketing, acknowledgement,notClassified];
}
