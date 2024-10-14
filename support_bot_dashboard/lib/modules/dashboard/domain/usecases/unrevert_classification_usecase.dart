import 'package:either_dart/either.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/repositories/unrevert_classification_repository.dart';
import 'package:support_bot_dashboard/utils/service/failure.dart';
import 'package:support_bot_dashboard/utils/service/usecase.dart';

class UnRevertClassificationUsecase implements UseCaseTwoInput<String, String, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(ticketId, selectedClassification) async {
    return await serviceLocator<UnRevertClassificationRepository>()
        .unRevertClassification(ticketId: ticketId, classification: selectedClassification);
  }
}
