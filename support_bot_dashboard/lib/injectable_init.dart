import 'package:get_it/get_it.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_chart_data_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_table_data_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_chart_data_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_table_data_Repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_chartdata_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_table_data_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/login_v3/data/repositories/v3_login_repositories_impl.dart';
import 'package:support_bot_dashboard/modules/login_v3/domain/repositories/v3_login_repositories.dart';
import 'package:support_bot_dashboard/modules/login_v3/domain/usecases/v3_login_usecases.dart';
import 'package:support_bot_dashboard/modules/login_v3/presentation/bloc/v3_login_bloc.dart';
import 'package:support_bot_dashboard/utils/service/auth/auth_service.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/secure_storage.dart';

final serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  /// V3 Login
  serviceLocator.registerLazySingleton<ApiProvider>(() => ApiProvider());
  serviceLocator.registerFactory(() => SecureStorage());

  serviceLocator.registerLazySingleton<AuthService>(() => AuthService());

  // serviceLocator.registerFactory<V3LoginSaveJoiningBotEmail>(
  //     () => V3LoginSaveJoiningBotEmail());
  serviceLocator.registerFactory<V3LoginSaveOnboardingEmailAndName>(
      () => V3LoginSaveOnboardingEmailAndName());
  serviceLocator
      .registerFactory<V3LoginRepositories>(() => V3LoginRepositoryImpl());
  serviceLocator.registerFactory<V3LoginBloc>(() => V3LoginBloc());

  //Local Storage
  serviceLocator.registerFactory<LocalStorage>(() => LocalStorage());

  // Dashboard
  serviceLocator.registerLazySingleton<DashboardTableDataRepository>(
      () => DashboardTableDataRepoImpl());
  serviceLocator.registerLazySingleton<DashboardChartDataRepository>(
      () => DashboardChartDataRepoImpl());
  serviceLocator.registerLazySingleton<DashboardTableDatausecase>(
      () => DashboardTableDatausecase());
  serviceLocator.registerLazySingleton<DashboardChartdataUsecase>(
      () => DashboardChartdataUsecase());
  serviceLocator.registerFactory<DashboardBloc>(() => DashboardBloc());
}
