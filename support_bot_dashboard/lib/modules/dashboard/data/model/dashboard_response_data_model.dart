class DashboardResponseDataModel {
  final num? id;
  final String? classification;
  final String? createdAt;
  final num? hsPipelineStage;
  final String? reasoning;
  final String? ticketDescription;

  DashboardResponseDataModel({
    this.id,
    this.classification,
    this.createdAt,
    this.hsPipelineStage,
    this.reasoning,
    this.ticketDescription,
  });

  factory DashboardResponseDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardResponseDataModel(
      id: json['id'],
      classification: json['classification'],
      createdAt: json['createdAt'],
      hsPipelineStage: json['hsPipelineStage'],
      reasoning: json['reasoning'],
      ticketDescription: json['ticketDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classification': classification,
      'createdAt': createdAt,
      'hsPipelineStage': hsPipelineStage,
      'reasoning': reasoning,
      'ticketDescription': ticketDescription,
    };
  }
}
