import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ai_query_chart_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_chart_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_get_validation_count_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_pipeline_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/get_validation_by_count_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/validation_status_attribute_model.dart';

class DashboardDataModel {
  final DashboardTableAttributeModel? tableData;
  final DashboardChartAttributeModel? pieChartData;
  final ValidationStatusAttributeModel? validationStatusAttributeModel;
  
  final DashboardAiQueryChartAttributeModel?
      dashboardAiQueryChartAttributeModel;
  final GetValidationByCountAttributeModel? getValidationByCountAttributeModel;
  final DashboardPipelineAttributeModel? dashboardPipelineAttributeModel;
  final GetValidationCountAttributeModel? getValidationCountAttributeModel;
  final String? selectedPipelineValue;
  final DateTime? selectedDate;
  final DateTime? selectedMonth;
  final String? updateValidation;
  final num? index;
  bool? isDropdownEnabled = true;
  DashboardDataModel({
    this.tableData,
    this.pieChartData,
    this.validationStatusAttributeModel,
    this.dashboardAiQueryChartAttributeModel,
    this.getValidationCountAttributeModel,
    this.getValidationByCountAttributeModel,
    this.dashboardPipelineAttributeModel,
    this.index,
    this.isDropdownEnabled,
    this.selectedDate,
    this.selectedMonth,
    this.selectedPipelineValue,
    this.updateValidation,
  });
  DashboardDataModel copyWith({
    DashboardTableAttributeModel? tableData,
    DashboardChartAttributeModel? pieChartData,
    ValidationStatusAttributeModel? validationStatusAttributeModel,
    DashboardAiQueryChartAttributeModel? dashboardAiQueryChartAttributeModel,
    DashboardPipelineAttributeModel? dashboardPipelineAttributeModel,
    GetValidationCountAttributeModel? getValidationCountAttributeModel,
    GetValidationByCountAttributeModel? getValidationByCountAttributeModel,
    String? selectedPipelineValue,
    DateTime? selectedDate,
    DateTime? selectedMonth,
    String? updateValidation,
    num? index,
    bool? isDropdownEnabled,
  }) {
    return DashboardDataModel(
      tableData: tableData ?? this.tableData,
      pieChartData: pieChartData ?? this.pieChartData,
      validationStatusAttributeModel:
          validationStatusAttributeModel ?? this.validationStatusAttributeModel,
      dashboardAiQueryChartAttributeModel:
          dashboardAiQueryChartAttributeModel ??
              this.dashboardAiQueryChartAttributeModel,
      dashboardPipelineAttributeModel: dashboardPipelineAttributeModel ??
          this.dashboardPipelineAttributeModel,
      getValidationCountAttributeModel: getValidationCountAttributeModel ??
          this.getValidationCountAttributeModel,
      getValidationByCountAttributeModel: getValidationByCountAttributeModel ??
          this.getValidationByCountAttributeModel,
      selectedPipelineValue:
          selectedPipelineValue ?? this.selectedPipelineValue,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      updateValidation: updateValidation ?? this.updateValidation,
      index: index ?? this.index,
      isDropdownEnabled: isDropdownEnabled ?? this.isDropdownEnabled,
    );
  }
}
