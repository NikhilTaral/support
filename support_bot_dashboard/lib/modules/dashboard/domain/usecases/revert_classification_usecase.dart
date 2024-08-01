import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/revert_classification_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class RevertClassificationUsecase implements UseCaseOneInput<String, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(id) async {
    return await serviceLocator<RevertClassificationRepository>()
        .revertClassification(id: id);
  }
}
