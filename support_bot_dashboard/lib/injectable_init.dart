import 'package:get_it/get_it.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_ai_query_chart_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_ai_query_filter_classification_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_ai_query_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_chart_data_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_filter_classification_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_pipeline_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_table_data_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_update_ai_query_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_validation_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/revert_classification_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_ai_query_chart_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_ai_query_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_chart_data_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_pipeline_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_table_data_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_update_ai_query_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_validation_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/revert_classification_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_ai_query_chart_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_ai_query_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_chartdata_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_filter_classification_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_pipeline_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_table_data_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_update_ai_query_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_validation_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/revert_classification_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_answer/ai_query_answer_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_query_chart_bloc/ai_query_chart_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/custom_button_bloc/custombutton_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_pipeline/dashboard_pipeline_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/pluto_table_bloc/plutotable_bloc.dart';
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

  // Dashboard repositories
  serviceLocator.registerLazySingleton<DashboardTableDataRepository>(
      () => DashboardTableDataRepoImpl());
  serviceLocator.registerLazySingleton<DashboardChartDataRepository>(
      () => DashboardChartDataRepoImpl());
  serviceLocator.registerLazySingleton<DashboardValidationRepository>(
      () => DashboardValidationRepoImpl());
  serviceLocator.registerLazySingleton<DashboardFilterClassificationDataRepository>(()=> DashboardFIlterClassificationRepoImpl());
  serviceLocator.registerLazySingleton<DashboardAiQueryRepository>(()=> DashboardAiQueryRepoImpl());
  serviceLocator.registerLazySingleton<DashboardAiQueryChartDataRepository>(()=> DashboardAiQueryChartRepoImpl());
  serviceLocator.registerLazySingleton<FilterAiQueryAnswerRepository>(()=> DashboardAiQueryFilterClassificationRepoImpl());

  // Dashboard usecase
  serviceLocator.registerLazySingleton<DashboardTableDatausecase>(
      () => DashboardTableDatausecase());
  serviceLocator.registerLazySingleton<DashboardChartdataUsecase>(
      () => DashboardChartdataUsecase());
  serviceLocator.registerLazySingleton<DashboardValidationUsecase>(
      () => DashboardValidationUsecase());
  serviceLocator.registerLazySingleton<DashboardFilterClassificationDatausecase>(
      () => DashboardFilterClassificationDatausecase());
  serviceLocator.registerLazySingleton<DashboardFilterClassificationValidationDatausecase>(()=> DashboardFilterClassificationValidationDatausecase());
  serviceLocator.registerLazySingleton<DashboardAiQueryUsecase>(()=> DashboardAiQueryUsecase());
  serviceLocator.registerLazySingleton<DashboardAiQueryChartUsecase>(()=>DashboardAiQueryChartUsecase());
  serviceLocator.registerLazySingleton<DashboardFilterAiQueryUsecase>(()=>DashboardFilterAiQueryUsecase());

  // Dashboard bloc
  serviceLocator.registerFactory<DashboardBloc>(() => DashboardBloc());
  serviceLocator.registerFactory<PlutotableBloc>(() => PlutotableBloc());
  serviceLocator.registerFactory<CustombuttonBloc>(() => CustombuttonBloc());
  serviceLocator.registerFactory<AiQueryAnswerBloc>(() => AiQueryAnswerBloc());
  serviceLocator.registerFactory<AiQueryChartBloc>(() => AiQueryChartBloc());

  //Revert Classification Bloc
  serviceLocator.registerLazySingleton<RevertClassificationUsecase>(
      () => RevertClassificationUsecase());
  serviceLocator.registerLazySingleton<RevertClassificationRepository>(
      () => RevertClassificationRepoImpl());

  serviceLocator.registerLazySingleton<UpdateAiAnswerUsecase>(
      () => UpdateAiAnswerUsecase());
  serviceLocator.registerLazySingleton<UpdateAiAnswerRepository>(
      () => UpdateAiAnswerRepoImpl());

  //Dashboard Pipeline
  serviceLocator.registerFactory<DashboardPipelineBloc>(()=> DashboardPipelineBloc());
  serviceLocator.registerLazySingleton<DashboardPipelineRepository>(()=> DashboardPipelineRepoImpl());
  serviceLocator.registerLazySingleton<DashboardPipelineUsecase>(()=> DashboardPipelineUsecase());
}
