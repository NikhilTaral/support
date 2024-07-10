import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_chart_data_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class DashboardChartdataUsecase implements UseCaseTwoInput {
  @override
  Future<Either<Failure, dynamic>> invoke(date,month) async {
    return await locator<DashboardChartDataRepository>().getDashboardChartData(date, month);
  }

}
