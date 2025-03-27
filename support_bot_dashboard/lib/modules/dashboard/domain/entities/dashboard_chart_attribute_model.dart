class DashboardChartAttributeModel {
    final ChartAttributeData? data;
    final bool? success;
    final num? failCode;
    final String? message;

    DashboardChartAttributeModel({
        this.data,
        this.success,
        this.failCode,
        this.message,
    });

    DashboardChartAttributeModel copyWith({
        ChartAttributeData? data,
        bool? success,
        num? failCode,
        String? message,
    }) => 
        DashboardChartAttributeModel(
            data: data ?? this.data,
            success: success ?? this.success,
            failCode: failCode ?? this.failCode,
            message: message ?? this.message,
        );
}

class ChartAttributeData {
    final ChartAttributeCounts? counts;
    final ChartAttributeCounts? percentages;

    ChartAttributeData({
        this.counts,
        this.percentages,
    });

    ChartAttributeData copyWith({
        ChartAttributeCounts? counts,
        ChartAttributeCounts? percentages,
    }) => 
        ChartAttributeData(
            counts: counts ?? this.counts,
            percentages: percentages ?? this.percentages,
        );
}

class ChartAttributeCounts {
    final double? genuineQuery;
    final double? noActionRequired;
    final double? spamMarketing;
    final double? acknowledgementRequired;
    final num? unableToClassify;
    final double? awaitingToClassify;
    final num? total;

    ChartAttributeCounts({
        this.genuineQuery,
        this.noActionRequired,
        this.spamMarketing,
        this.acknowledgementRequired,
        this.unableToClassify,
        this.awaitingToClassify,
        this.total,
    });

    ChartAttributeCounts copyWith({
        double? genuineQuery,
        double? noActionRequired,
        double? spamMarketing,
        double? acknowledgementRequired,
        num? unableToClassify,
        double? awaitingToClassify,
        num? total,
    }) => 
        ChartAttributeCounts(
            genuineQuery: genuineQuery ?? this.genuineQuery,
            noActionRequired: noActionRequired ?? this.noActionRequired,
            spamMarketing: spamMarketing ?? this.spamMarketing,
            acknowledgementRequired: acknowledgementRequired ?? this.acknowledgementRequired,
            unableToClassify: unableToClassify ?? this.unableToClassify,
            awaitingToClassify: awaitingToClassify ?? this.awaitingToClassify,
            total: total ?? this.total,
        );
}
