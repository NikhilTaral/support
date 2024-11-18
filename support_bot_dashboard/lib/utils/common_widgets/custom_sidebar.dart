import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_table_attribute_model.dart';
import 'package:support_bot_dashboard/modules/dashboard/domain/entities/dashboard_ticket_classification_gridkey.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class CustomSidebar extends StatelessWidget {
  final PlutoRow rowData;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool isNextEnabled;
  final bool isPreviousEnabled;
  final DashboardTableAttributeModel? tableData;

  const CustomSidebar(
      {Key? key,
      required this.rowData,
      required this.onNext,
      required this.isNextEnabled,
      required this.onPrevious,
      required this.isPreviousEnabled,
      this.tableData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

       final id = rowData.cells[TicketClassificationGridKey.id]?.value ?? 'N/A';
    final description = rowData.cells[TicketClassificationGridKey.ticketDescription]?.value ?? 'N/A';
    final reasoning = rowData.cells[TicketClassificationGridKey.reasoning]?.value ?? 'N/A';
    final validation = rowData.cells[TicketClassificationGridKey.validation]?.value ?? 'N/A';
    final validationReason = rowData.cells[TicketClassificationGridKey.validationReason]?.value ?? 'N/A';
    final status = rowData.cells[TicketClassificationGridKey.isUpdatedToHubspot]?.value == true ? "Updated" : "Not Updated";
    final validatedClassification = rowData.cells['validatedClassification']?.value ?? 'N/A';
    final classificationValidatedBy = rowData.cells['classificationValidatedBy']?.value ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SupportBotColors.white,
        title: const Text(
          'Ticket Details',
          style: SupportBotTextstyle.sidebarTitle,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 14,
          ),
          onPressed: isPreviousEnabled ? onPrevious : null,
          color: isPreviousEnabled ? Colors.black : Colors.grey,
        ),
        actions: [
          IconButton(
              onPressed: isNextEnabled ? onNext : null,
              color: isNextEnabled ? Colors.black : Colors.grey,
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(height: 1, color: Colors.grey[300]),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow('ID:', id ?? ""),
                  _buildRow('Description:', description ?? ""),
                  _buildRow('Reasoning:', reasoning ?? ""),
                  _buildRow(
                      'Validation:', validation.isEmpty ? 'N/A' : validation),
                  _buildRow('Validation Reason:',
                      validationReason.isEmpty ? 'N/A' : validationReason),
                  _buildRow(
                      'Status:', status == true ? "Updated" : "Not Updated"),
                  _buildRow('Validated Classification:',
                      validatedClassification ?? "N/A"),
                  _buildRow('Classification Validated By:',
                      classificationValidatedBy ?? "N/A")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: SupportBotTextstyle.sidebarSubtitle,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SelectableText(
              value,
              style: SupportBotTextstyle.siebarLabel,
            ),
          ),
        ],
      ),
    );
  }
}
