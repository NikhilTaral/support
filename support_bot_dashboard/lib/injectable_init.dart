import 'package:get_it/get_it.dart';
import 'package:support_bot_dashboard/core/network/api_provider.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/data/repositories/ai_query_answer_repo_impl.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/domain/repositories/ai_query_answer_repo.dart';
import 'package:support_bot_dashboard/modules/ai_query_answer_tab/domain/usecases/ai_query_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/ai_accuracy_and_validation_trends_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_ai_query_chart_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_chart_data_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_get_ai_edited_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_get_validation_by_count_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/dashboard_get_validation_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/get_all_pipelines_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/pipeline_tile_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/data/repositories/validation_status_repo_impl.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/ai_accuracy_and_validation_trends_respository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_ai_query_answer_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_chart_data_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_ai_edited_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_validation_by_count_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_get_validation_count_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/get_all_pipelines_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/pipeline_tile_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/validation_status_repository.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/ai_accuracy_and_validation_trends_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_ai_query_answer.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_ai_query_edited.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_chartdata_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/dashboard_get_validation_by_count_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/get_all_pipelines_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/pipeline_tile_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/usecases/validation_status_usecase.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ai_accuracy_and_validation_trends_bloc.dart/ai_accuracy_and_validation_trends_bloc.dart';
import 'package:support_bot_dashboard/modules/login_v3/data/repositories/v3_login_repositories_impl.dart';
import 'package:support_bot_dashboard/modules/login_v3/domain/repositories/v3_login_repositories.dart';
import 'package:support_bot_dashboard/modules/login_v3/domain/usecases/v3_login_usecases.dart';
import 'package:support_bot_dashboard/modules/login_v3/presentation/bloc/v3_login_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/data/repositories/common_repo_impl.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/repositories/common_ticket_classification_repository.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/domain/usecases/common_ticket_classification_usecases.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/bops_states_bloc/bops_states_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/export_bloc/export_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/get_all_pipelines_bloc/get_all_pipelines_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/get_all_validatod_user_bloc/get_all_validation_user_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_action_bloc/ticket_classification_action_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/update_classification_validation_bloc/update_classification_validation_bloc.dart';
import 'package:support_bot_dashboard/utils/service/auth/auth_service.dart';
import 'package:support_bot_dashboard/utils/service/instance_sharing_service.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/local_storage.dart';
import 'package:support_bot_dashboard/utils/shared_preferences/secure_storage.dart';

final serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  serviceLocator.registerSingleton<S>(S());

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
  serviceLocator.registerLazySingleton<ValidationStatusRepository>(
      () => ValidationStatusRepoImpl());
  serviceLocator.registerLazySingleton<GetAllPipelinesRepository>(
      () => GetAllPipelinesRepoImpl());
  serviceLocator.registerLazySingleton<DashboardGetAiEditedRepository>(
      () => DashboardGetAiEditedRepoImpl());
  serviceLocator.registerLazySingleton<DashboardChartDataRepository>(
      () => DashboardChartDataRepoImpl());
  serviceLocator.registerLazySingleton<DashboardAiQueryAnswerDataRepository>(
      () => DashboardAiQueryAnswerRepoImpl());
  serviceLocator.registerLazySingleton<PipelineTileRepository>(
      () => PipelineTileRepoImpl());

  // Dashboard usecase
  serviceLocator.registerLazySingleton<DashboardChartdataUsecase>(
      () => DashboardChartdataUsecase());
  serviceLocator.registerLazySingleton<ValidationStatusUsecase>(
      () => ValidationStatusUsecase());
  serviceLocator.registerLazySingleton<DashboardAiQueryAnswerUsecase>(
      () => DashboardAiQueryAnswerUsecase());
  serviceLocator.registerLazySingleton<DashboardAiQueryEditedUsecase>(
      () => DashboardAiQueryEditedUsecase());
  serviceLocator
      .registerLazySingleton<PipelineTileUsecase>(() => PipelineTileUsecase());

  // get validation count
  serviceLocator.registerLazySingleton<GetValidationCountRepository>(
      () => DashboardGetValidationRepoImpl());

  //get validation by count
  serviceLocator.registerLazySingleton<DashboardGetValidationByCountUsecase>(
      () => DashboardGetValidationByCountUsecase());
  serviceLocator.registerLazySingleton<GetValidationByCountRepository>(
      () => DashboardGetValidationByCountRepoImpl());

  serviceLocator.registerLazySingleton<GetAllPipelinesUsecase>(
      () => GetAllPipelinesUsecase());

  // Ticket Classification
  serviceLocator.registerLazySingleton<ActionUsecase>(() => ActionUsecase());
  serviceLocator
      .registerLazySingleton<ActionRepository>(() => ActionRepoImpl());
  serviceLocator.registerFactory<TicketClassificationActionBloc>(
      () => TicketClassificationActionBloc());

  serviceLocator.registerLazySingleton<TicketClassificationUsecses>(
      () => TicketClassificationUsecses());
  serviceLocator.registerLazySingleton<TicketClassifiacationRepository>(
      () => TicketClassificationRepoImpl());
  serviceLocator.registerFactory<TicketClassificationTabBloc>(
      () => TicketClassificationTabBloc());

  serviceLocator.registerLazySingleton<BopsUsecases>(() => BopsUsecases());
  serviceLocator.registerLazySingleton<BopsRepository>(() => BopsRepoImpl());
  serviceLocator.registerFactory<BopsStatesBloc>(() => BopsStatesBloc());

  serviceLocator
      .registerFactory<GetAllPipelinesBloc>(() => GetAllPipelinesBloc());

  serviceLocator.registerLazySingleton<UpdateAiAnswerUsecase>(
      () => UpdateAiAnswerUsecase());
  serviceLocator.registerLazySingleton<AiQueryDataRepository>(
      () => AiQueryAnswerRepoImpl());
  serviceLocator.registerLazySingleton<AiQueryUsecase>(() => AiQueryUsecase());
  serviceLocator.registerLazySingleton<AddAnswerValidationUsecase>(
      () => AddAnswerValidationUsecase());

  serviceLocator.registerLazySingleton<InstanceSharingService>(
      () => InstanceSharingService());
  serviceLocator.registerLazySingleton<GetValidationDetailsUsecase>(
      () => GetValidationDetailsUsecase());
  serviceLocator.registerLazySingleton<GetValidationDetailsRepository>(
      () => GetValidationDetailsImpl());

  serviceLocator.registerLazySingleton<UpdateClassificationValidationUsecase>(
      () => UpdateClassificationValidationUsecase());
  serviceLocator
      .registerLazySingleton<UpdateClassificationValidationRepository>(
          () => UpdateClassificationValidationImpl());
  serviceLocator.registerFactory<UpdateClassificationValidationBloc>(
      () => UpdateClassificationValidationBloc());

  serviceLocator.registerLazySingleton<RevertClassificationUsecase>(
      () => RevertClassificationUsecase());
  serviceLocator.registerLazySingleton<RevertClassificationRepository>(
      () => RevertClassificationImpl());

  //export
  serviceLocator.registerLazySingleton<DashboardExportusecase>(
      () => DashboardExportusecase());
  serviceLocator.registerLazySingleton<DashboardExportRepository>(
      () => DashboardExportImpl());
  serviceLocator.registerFactory<ExportBloc>(() => ExportBloc());

  //getAllVAlidater User

  serviceLocator.registerLazySingleton<GetAllValidationUserUsecase>(
      () => GetAllValidationUserUsecase());
  serviceLocator.registerLazySingleton<GetAllValidationUserRepository>(
      () => GetAllValidationUserImpl());
  serviceLocator.registerFactory<GetAllValidationUsersBloc>(
      () => GetAllValidationUsersBloc());

  serviceLocator.registerLazySingleton<AiAccuracyAndValidationTrendsUsecase>(
      () => AiAccuracyAndValidationTrendsUsecase());
  serviceLocator
      .registerLazySingleton<AiAccuracyAndValidationTrendsRespository>(
          () => AiAccuracyAndValidationTrendsRepoImpl());
  serviceLocator.registerFactory<AiAccuracyAndValidationTrendsBloc>(
      () => AiAccuracyAndValidationTrendsBloc());
}
