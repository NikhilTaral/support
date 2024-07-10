import 'package:get_it/get_it.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_chart_data_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_table_data_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_chart_data_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_table_data_Repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_chartdata_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_table_data_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<DashboardTableDataRepository>(
      () => DashboardTableDataRepoImpl());
       locator.registerLazySingleton<DashboardChartDataRepository>(
      () => DashboardChartDataRepoImpl());
  locator.registerLazySingleton<DashboardDatausecase>(
      () => DashboardDatausecase());
  locator.registerLazySingleton<DashboardChartdataUsecase>(
      () => DashboardChartdataUsecase());
  locator.registerFactory<DashboardBloc>(() => DashboardBloc());
}
