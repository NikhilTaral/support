class PipelineTileAttributeModel {
  final num? totalRecords;
  final List<AttributeItem>? items;

  PipelineTileAttributeModel({
    this.totalRecords,
    this.items,
  });

  PipelineTileAttributeModel copyWith({
    num? totalRecords,
    List<AttributeItem>? items,
  }) =>
      PipelineTileAttributeModel(
        totalRecords: totalRecords ?? this.totalRecords,
        items: items ?? this.items,
      );
}

class AttributeItem {
  final String? pipelineId;
  final String? pipelineName;
  final num? totalTickets;
  final num? correctTickets;
  final num? incorrectTickets;
  final num? validatedTickets;

  AttributeItem({
    this.pipelineId,
    this.pipelineName,
    this.totalTickets,
    this.correctTickets,
    this.incorrectTickets,
    this.validatedTickets,
  });

  AttributeItem copyWith({
    String? pipelineId,
    String? pipelineName,
    num? totalTickets,
    num? correctTickets,
    num? incorrectTickets,
    num? validatedTickets,
  }) =>
      AttributeItem(
        pipelineId: pipelineId ?? this.pipelineId,
        pipelineName: pipelineName ?? this.pipelineName,
        totalTickets: totalTickets ?? this.totalTickets,
        correctTickets: correctTickets ?? this.correctTickets,
        incorrectTickets: incorrectTickets ?? this.incorrectTickets,
        validatedTickets: validatedTickets ?? this.validatedTickets,
      );
}
