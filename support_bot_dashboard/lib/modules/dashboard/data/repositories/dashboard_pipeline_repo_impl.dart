import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/config/environment/env_config.dart';
import 'package:support_bot_dashboard/core/prerequisites/api_prerequisites.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/dashboard_pipeline_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:http/http.dart' as http;

class DashboardPipelineRepoImpl extends DashboardPipelineRepository{
  @override
  Future<Either<Failure, dynamic>> getPipelineData() async{
    try{
       final uri =
          Uri.parse('${EnvConfig.EXP_API_URL}/dashboard/getAllPipelines');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': "${await getToken()}",
      };
      final response = await http.get(
        uri,
        headers: headers,
        
      );
      if (response.statusCode == 200) {
        return Right(response.body);
      } else {
        return Left(ServerFailure());
      }
    }
    catch(e){
      return Left(ServerFailure());
    }
  }

}