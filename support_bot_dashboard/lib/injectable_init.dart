import 'package:get_it/get_it.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_data_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_data_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_data_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<DashboardDataRepository>(
      () => DashboardDataRepoImpl());
  locator.registerLazySingleton<DashboardDatausecase>(
      () => DashboardDatausecase());
  locator.registerFactory<DashboardBloc>(() => DashboardBloc());
}
