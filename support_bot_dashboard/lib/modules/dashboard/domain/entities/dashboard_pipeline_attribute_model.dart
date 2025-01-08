class DashboardPipelineAttributeModel {
  final List<PipelineAttribute> data;

  DashboardPipelineAttributeModel({required this.data});

  DashboardPipelineAttributeModel copyWith({List<PipelineAttribute>? data}) {
    return DashboardPipelineAttributeModel(
      data: data ?? this.data,
    );
  }
}

class PipelineAttribute {
  final String? pipelineId;
  final String? pipelineName;
  final bool? hubspotUpdatepPerm;
  final bool? aiAnswerPerm;
  final String? hubspotUpdateEnv;

  PipelineAttribute(
      {this.pipelineId,
      this.pipelineName,
      this.aiAnswerPerm,
      this.hubspotUpdateEnv,
      this.hubspotUpdatepPerm});
}
