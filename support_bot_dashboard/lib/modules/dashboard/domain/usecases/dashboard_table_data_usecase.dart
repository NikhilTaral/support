import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_table_data_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

class DashboardTableDatausecase {
  Future<Either<Failure, dynamic>> invoke(DateTime? date,DateTime? month) async {
    return await serviceLocator<DashboardTableDataRepository>().getDashboardTableData(date, month);
  }
}

