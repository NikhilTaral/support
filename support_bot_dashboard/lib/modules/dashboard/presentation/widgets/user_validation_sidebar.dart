import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/generated/l10n.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class UserValidationSidebar extends StatelessWidget {
  final Map<String, double>? validationData;
  final s = serviceLocator<S>();
   UserValidationSidebar({
    Key? key,
    required this.validationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedEntries = validationData?.entries.toList()
      ?..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      s.userValidationCountText,
                      style: SupportBotTextstyle.normal.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.grey),
            Expanded(
              child: ListView.builder(
                itemCount: sortedEntries?.length,
                itemBuilder: (context, index) {
                  final entry = sortedEntries?[index];
                  final name = _formatName(entry?.key ?? "");

                  return ListTile(
                    title: Text(
                      name,
                      style: SupportBotTextstyle.pierchartLabel,
                    ),
                    trailing: Text(
                      entry?.value.toString() ?? "",
                      style: SupportBotTextstyle.pierchartLabel,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatName(String email) {
    if (email.isEmpty) return 'Unknown';

    return email.contains('@')
        ? email.split('@').first.replaceAll('.', ' ').capitalize()
        : email.capitalize();
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return '';

    return split(' ')
        .map((word) =>
            word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');
  }
}
