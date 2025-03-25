class AiAccuracyAndValidationTrendsAttributeModel {
    final List<GraphData>? data;
    final bool? success;
    final num? failCode;
    final String? message;

    AiAccuracyAndValidationTrendsAttributeModel({
        this.data,
        this.success,
        this.failCode,
        this.message,
    });

}

class GraphData {
    final String? date;
    final num? aiAccuracy;
    final num? validationPercentage;

    GraphData({
        this.date,
        this.aiAccuracy,
        this.validationPercentage,
    });

}
