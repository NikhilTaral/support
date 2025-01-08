class DashboardAiQueryChartAttributeModel {
  final AiQueryData? data;

  DashboardAiQueryChartAttributeModel({
    this.data,
  });

  DashboardAiQueryChartAttributeModel copyWith({
    AiQueryData? data,
  }) {
    return DashboardAiQueryChartAttributeModel(
      data: data ?? this.data,
    );
  }
}

class AiQueryData {
  final AiQueryDataCounts? counts;
  final AiQueryDataCounts? percentages;

  AiQueryData({
    this.counts,
    this.percentages,
  });
  AiQueryData copyWith({
    AiQueryDataCounts? counts,
    AiQueryDataCounts? percentages,
  }) {
    return AiQueryData(
      counts: counts ?? this.counts,
      percentages: percentages ?? this.percentages,
    );
  }
}

class AiQueryDataCounts {
  final double? answered;
  final double? notAnswered;

  AiQueryDataCounts({
    this.answered,
    this.notAnswered,
  });
  AiQueryDataCounts copyWith({
    double? answered,
    double? notAnswered,
  }) {
    return AiQueryDataCounts(
      answered: answered ?? this.answered,
      notAnswered: notAnswered ?? this.notAnswered,
    );
  }
}

// class DashboardAiQueryChartAttributeModel {
//   final DataModel? data;
//   final bool? success;
//   final num? failCode;
//   final Map<String, dynamic>? params;
//   final String? message;

//   DashboardAiQueryChartAttributeModel({
//     this.data,
//     this.success,
//     this.failCode,
//     this.params,
//     this.message,
//   });

//   // Factory constructor for creating a new instance from JSON
//   factory DashboardAiQueryChartAttributeModel.fromJson(
//       Map<String, dynamic> json) {
//     return DashboardAiQueryChartAttributeModel(
//       data: DataModel.fromJson(json['data']),
//       success: json['success'],
//       failCode: json['failCode'],
//       params: json['params'] ?? {},
//       message: json['message'],
//     );
//   }

//   // Method to convert instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'data': data?.toJson(),
//       'success': success,
//       'failCode': failCode,
//       'params': params,
//       'message': message,
//     };
//   }

//   // CopyWith method
//   DashboardAiQueryChartAttributeModel copyWith({
//     DataModel? data,
//     bool? success,
//     int? failCode,
//     Map<String, dynamic>? params,
//     String? message,
//   }) {
//     return DashboardAiQueryChartAttributeModel(
//       data: data ?? this.data,
//       success: success ?? this.success,
//       failCode: failCode ?? this.failCode,
//       params: params ?? this.params,
//       message: message ?? this.message,
//     );
//   }
// }

// class DataModel {
//   final CountsModel? counts;
//   final PercentagesModel? percentages;

//   DataModel({
//     this.counts,
//     this.percentages,
//   });
//   DataModel copyWith(
//     CountsModel? counts,
//     PercentagesModel? percentages,
//   ) {
//     return DataModel(
//       counts: counts ?? this.counts,
//       percentages: percentages ?? this.percentages,
//     );
//   }

//   // Factory constructor for creating a new instance from JSON
//   factory DataModel.fromJson(Map<String, dynamic> json) {
//     return DataModel(
//       counts: CountsModel.fromJson(json['counts']),
//       percentages: PercentagesModel.fromJson(json['percentages']),
//     );
//   }

//   // Method to convert instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'counts': counts?.toJson(),
//       'percentages': percentages?.toJson(),
//     };
//   }
// }

// class CountsModel {
//   final num? answered;
//   final num? notAnswered;

//   CountsModel({
//     this.answered,
//     this.notAnswered,
//   });
//   CountsModel copyWith({
//     num? answered,
//     num? notAnswered,
//   }) {
//     return CountsModel(
//       answered: answered ?? this.answered,
//       notAnswered: notAnswered ?? this.notAnswered,
//     );
//   }

//   // Factory constructor for creating a new instance from JSON
//   factory CountsModel.fromJson(Map<String, dynamic> json) {
//     return CountsModel(
//       answered: json['answered'],
//       notAnswered: json['notAnswered'],
//     );
//   }

//   // Method to convert instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'answered': answered,
//       'notAnswered': notAnswered,
//     };
//   }
// }

// class PercentagesModel {
//   final double answered;
//   final double notAnswered;

//   PercentagesModel({
//     required this.answered,
//     required this.notAnswered,
//   });

//   // Factory constructor for creating a new instance from JSON
//   factory PercentagesModel.fromJson(Map<String, dynamic> json) {
//     return PercentagesModel(
//       answered: (json['answered'] as num).toDouble(),
//       notAnswered: (json['notAnswered'] as num).toDouble(),
//     );
//   }

//   // Method to convert instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'answered': answered,
//       'notAnswered': notAnswered,
//     };
//   }
// }
