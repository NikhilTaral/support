import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/bloc/ai_query_bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/get_validation_details_bloc/get_validation_details_bloc.dart';
import 'package:support_bot_dashboard/modules/ticket_classification/presentation/bloc/update_classification_validation_bloc/update_classification_validation_bloc.dart';

class InstanceSharingService {
  AiQueryBloc? aiQueryBloc;
  List<String>? selectedPipelineValueList;
  String? classificationFilterValue;
  String? selectedPipelineValue;

  TicketClassificationBloc? ticketClassificationBloc;
}
