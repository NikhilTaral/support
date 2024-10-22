import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';

abstract class GetUserSettingsRepository {
  Future<Either<Failure, dynamic>> getUserSettings(String? email);
}
