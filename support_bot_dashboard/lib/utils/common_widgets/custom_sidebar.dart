import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class CustomSidebar extends StatelessWidget {
  final PlutoRow rowData;

  const CustomSidebar({Key? key, required this.rowData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = rowData.cells['id']?.value ?? 'N/A';
    final description = rowData.cells['ticketDescription']?.value ?? 'N/A';
    final reasoning = rowData.cells['reasoning']?.value ?? 'N/A';
    final validation = rowData.cells['validation']?.value ?? 'N/A';
    final validationReason = rowData.cells['validation_reason']?.value ?? 'N/A';

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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                    _buildRow('ID:', id),
                    _buildRow('Description:', description),
                    _buildRow('Reasoning:', reasoning),
                    _buildRow('Validation:', validation),
                    _buildRow('Validation Reason:', validationReason),
                  ],
                ),
              ),
           
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    print(value);
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
            child: Text(
              value,
              style: SupportBotTextstyle.siebarLabel,
            ),
          ),
        ],
      ),
    );
  }
}
