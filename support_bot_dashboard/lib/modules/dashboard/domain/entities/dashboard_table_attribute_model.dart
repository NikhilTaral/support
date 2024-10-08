import 'package:equatable/equatable.dart';

class DashboardTableAttributeModel extends Equatable {
  final num? totalRecords;
  final List<TableItem> items;
   final num? pageSize;
   final num? currentPage;

  DashboardTableAttributeModel({
    required this.totalRecords,
    required this.items,
    required this.pageSize,
    required this.currentPage
  });

  @override
  List<Object?> get props => [totalRecords, items,pageSize,currentPage];
}

class TableItem extends Equatable {
  final String id;
  final String classification;
  final String hsPipelineStage;
  final String reasoning;
  final String createdAt;
  final String ticketDescription;
  final String classificationValidation;
  final String classificationValidationReason;
  final bool? isUpdatedToHubspot;

  const TableItem({
    required this.id,
    required this.classification,
    required this.hsPipelineStage,
    required this.reasoning,
    required this.createdAt,
    required this.ticketDescription,
    required this.classificationValidation,
    required this.classificationValidationReason,
    this.isUpdatedToHubspot, 
  });

  @override
  List<Object?> get props => [
        id,
        classification,
        hsPipelineStage,
        reasoning,
        createdAt,
        ticketDescription,
        classificationValidation,
        classificationValidationReason,
        isUpdatedToHubspot,
      ];
}
