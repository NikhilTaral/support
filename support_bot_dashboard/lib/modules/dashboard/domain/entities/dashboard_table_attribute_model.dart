import 'package:equatable/equatable.dart';

class DashboardTableAttributeModel extends Equatable {
  final int totalRecords;
  final List<TableItem> items;

  DashboardTableAttributeModel({
    required this.totalRecords,
    required this.items,
  });

  @override
  List<Object?> get props => [totalRecords, items];
}

class TableItem extends Equatable {
  final String id;
  final String classification;
  final String hsPipelineStage;
  final String reasoning;
  final String createdAt;

  TableItem({
    required this.id,
    required this.classification,
    required this.hsPipelineStage,
    required this.reasoning,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, classification, hsPipelineStage, reasoning, createdAt];
}
