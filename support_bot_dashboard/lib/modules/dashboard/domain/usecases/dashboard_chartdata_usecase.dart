import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_chart_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_data_repository.dart';

class DashboardChartdatausecase {
  final DashboardDataRepository _dataRepository =
      locator<DashboardDataRepository>();

  Future<List<ChartData>> call(DateTime selectedDate) async {
    return await _dataRepository.piechartData(selectedDate: selectedDate);
  }
}
