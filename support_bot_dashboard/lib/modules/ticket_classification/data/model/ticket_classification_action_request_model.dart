import 'package:meta/meta.dart';
import 'dart:convert';

class TicketClassificationActionRequestModel {
    final String ticketId;
    final String classification;
    final String pipelineId;

    TicketClassificationActionRequestModel({
        required this.ticketId,
        required this.classification,
        required this.pipelineId,
    });

    TicketClassificationActionRequestModel copyWith({
        String? ticketId,
        String? classification,
        String? pipelineId,
    }) => 
        TicketClassificationActionRequestModel(
            ticketId: ticketId ?? this.ticketId,
            classification: classification ?? this.classification,
            pipelineId: pipelineId ?? this.pipelineId,
        );

    factory TicketClassificationActionRequestModel.fromRawJson(String str) => TicketClassificationActionRequestModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TicketClassificationActionRequestModel.fromJson(Map<String, dynamic> json) => TicketClassificationActionRequestModel(
        ticketId: json["ticketId"],
        classification: json["classification"],
        pipelineId: json["pipelineId"],
    );

    Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "classification": classification,
        "pipelineId": pipelineId,
    };
}
