import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/model/dashboard_response_data_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_table_data_Repository.dart';

class DashboardDatausecase {
  final DashboardTableDataRepository _dataRepository =
      serviceLocator<DashboardTableDataRepository>();

  Future<List<DashboardResponseDataModel>> call() async {
    return await _dataRepository.fetchTableData();
  }
}
