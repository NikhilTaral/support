class PipelineTileAttributeModel {
  final AttributeData? data;
  final bool? success;
  final int? failCode;
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
    int? failCode,
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
  final int? totalRecords;
  final List<AttributeItem>? items;

  AttributeData({
    this.totalRecords,
    this.items,
  });

  AttributeData copyWith({
    int? totalRecords,
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
  final int? totalTickets;
  final int? correctTickets;
  final int? incorrectTickets;
  final int? validatedTickets;

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
    int? totalTickets,
    int? correctTickets,
    int? incorrectTickets,
    int? validatedTickets,
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
