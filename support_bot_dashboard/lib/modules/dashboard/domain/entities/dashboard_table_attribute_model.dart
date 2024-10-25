import 'package:equatable/equatable.dart';

class DashboardTableAttributeModel extends Equatable {
  final num? totalRecords;
  final List<TableItem> items;
  final num? pageSize;
  final num? currentPage;

  DashboardTableAttributeModel(
      {required this.totalRecords,
      required this.items,
      required this.pageSize,
      required this.currentPage});

  @override
  List<Object?> get props => [totalRecords, items, pageSize, currentPage];
}

class TableItem extends Equatable {
  final String? id;
  final String? classification;
  final String? hsPipelineStage;
  final String? reasoning;
  final String? createdAt;
  final String? ticketDescription;
  final String? classificationValidation;
  final String? classificationValidationReason;
  final bool? isUpdatedToHubspot;
  final String? validatedClassification;
  final String? classificationValidatedBy;

  const TableItem(
      {this.id,
      this.classification,
      this.hsPipelineStage,
      this.reasoning,
      this.createdAt,
      this.ticketDescription,
      this.classificationValidation,
      this.classificationValidationReason,
      this.isUpdatedToHubspot,
      this.validatedClassification,
      this.classificationValidatedBy});

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
        validatedClassification,
        classificationValidatedBy
      ];
}
