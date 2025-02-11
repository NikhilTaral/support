class PipelineTileAttributeModel {
  final AttributeData? data;
  final bool? success;
  final num? failCode;
  final String? message;

  PipelineTileAttributeModel({
    this.data,
    this.success,
    this.failCode,
    this.message,
  });

  PipelineTileAttributeModel copyWith({
    AttributeData? data,
    bool? success,
    num? failCode,
    String? message,
  }) =>
      PipelineTileAttributeModel(
        data: data ?? this.data,
        success: success ?? this.success,
        failCode: failCode ?? this.failCode,
        message: message ?? this.message,
      );
}

class AttributeData {
  final num? totalRecords;
  final List<AttributeItem>? items;

  AttributeData({
    this.totalRecords,
    this.items,
  });

  AttributeData copyWith({
    num? totalRecords,
    List<AttributeItem>? items,
  }) =>
      AttributeData(
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
