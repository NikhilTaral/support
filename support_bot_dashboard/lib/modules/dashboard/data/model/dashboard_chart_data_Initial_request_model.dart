// Define the RequestModel class
class DashboardAnswerDataInitialRequestModel {
  final String? startDate;
  final String? endDate;
  final List<Filter>? filter;
  final num? page;
  final num? pageSize;

  DashboardAnswerDataInitialRequestModel(
      {this.startDate, this.endDate, this.filter, this.page, this.pageSize});

  // From JSON
  factory DashboardAnswerDataInitialRequestModel.fromJson(
      Map<String, dynamic> json) {
    return DashboardAnswerDataInitialRequestModel(
      startDate: json['startDate'],
      endDate: json['endDate'],
      filter: (json['filter'] as List).map((i) => Filter.fromJson(i)).toList(),
      page: json['page'],
      pageSize: json['pageSize'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'filter': filter?.map((f) => f.toJson()).toList() ?? [],
      'page': page,
      'pageSize': pageSize
    };
  }
}

class Filter {
  final String? fieldName;
  final List<String>? fieldValue;

  Filter({this.fieldName, this.fieldValue});

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      fieldName: json['fieldName'],
      fieldValue: List<String>.from(json['fieldValue']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fieldName': fieldName,
      'fieldValue': fieldValue,
    };
  }
}
