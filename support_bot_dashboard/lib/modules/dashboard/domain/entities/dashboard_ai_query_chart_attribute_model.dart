import 'package:equatable/equatable.dart';

class DashboardAiQueryChartAttributeModel extends Equatable {
   final num? aiQueryAnswer;
  final num? aiQueryNotAnswer;

  const DashboardAiQueryChartAttributeModel(
      {required this.aiQueryAnswer,
      required this.aiQueryNotAnswer,});

  @override
  List<Object?> get props =>
      [aiQueryAnswer, aiQueryNotAnswer];
}
