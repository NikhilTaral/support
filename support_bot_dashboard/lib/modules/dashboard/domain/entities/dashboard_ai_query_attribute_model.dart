import 'package:equatable/equatable.dart';

class DashboardAiQueryAttributeModel extends Equatable {
  final List<AiQueryAnswerTableItem> items;
  final num? totalRecords;
     final num? pageSize;
   final num? currentPage;

  const DashboardAiQueryAttributeModel({
    required this.items,
     required this.pageSize,
    required this.currentPage,
    required this.totalRecords,
  });

  @override
  List<Object?> get props => [items, totalRecords,currentPage,pageSize];
}

class AiQueryAnswerTableItem extends Equatable {
 final String? id;
  final String? createdAt;
  final String? ticketDescription;
  final String? aIResponse;
  final bool? answeredStatus;
  final bool? isAnswerEdited;
  final bool? answerValidation;
  final String? answerValidationReason;

  const AiQueryAnswerTableItem( 
      {required this.id,
      required this.createdAt,
      required this.ticketDescription,
      required this.aIResponse,
      required this.answeredStatus,
      required this.isAnswerEdited,
      required this.answerValidation,
      required this.answerValidationReason});

  @override
  List<Object?> get props => [
        id,
        createdAt,
        ticketDescription,
        aIResponse,
        answeredStatus,
        isAnswerEdited,
        answerValidation,
        answerValidationReason
      ];
}
