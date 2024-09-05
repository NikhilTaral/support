class DashboardPipelineAttributeModel {
  final List<PipelineAttribute> data;

  DashboardPipelineAttributeModel({
    required this.data,
  });
}

class PipelineAttribute {
  final String pipelineId;
  final String pipelineName;

  PipelineAttribute({
    required this.pipelineId,
    required this.pipelineName,
  });
}