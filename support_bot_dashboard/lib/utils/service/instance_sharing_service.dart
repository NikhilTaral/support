import 'package:support_bot_dashboard/modules/ai_query_answer_tab/presentation/bloc/ai_query_bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/ticket_classification_bloc/ticket_classification_bloc.dart';

class InstanceSharingService {
  AiQueryBloc? aiQueryBloc;
  String? selectedPipelineValueList;
  String? classificationFilterValue;
  String? selectedPipelineValue;
  DateTime? endDate;
  DateTime? startDate;

  TicketClassificationBloc? ticketClassificationBloc;
}
