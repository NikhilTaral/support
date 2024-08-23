import 'package:equatable/equatable.dart';

class DashboardAiQueryAttributeModel extends Equatable {
  final List<AiQueryAnswerTableItem> items;

  const DashboardAiQueryAttributeModel({
    required this.items,
  });

  @override
  List<Object?> get props => [items];
}

class AiQueryAnswerTableItem extends Equatable {
 final String? id;
  final String? createdAt;
  final String? ticketDescription;
  final String? aIResponse;
  final bool? isAnswerEdited;
  final bool? answerValidation;
  final String? answerValidationReason;

  const AiQueryAnswerTableItem(
      {required this.id,
      required this.createdAt,
      required this.ticketDescription,
      required this.aIResponse,
      required this.isAnswerEdited,
      required this.answerValidation,
      required this.answerValidationReason});

  @override
  List<Object?> get props => [
        id,
        createdAt,
        ticketDescription,
        aIResponse,
        isAnswerEdited,
        answerValidation,
        answerValidationReason
      ];
}
