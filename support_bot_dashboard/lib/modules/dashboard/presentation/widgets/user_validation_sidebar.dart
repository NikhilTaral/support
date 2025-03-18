// import 'package:flutter/material.dart';
// import 'package:support_bot_dashboard/utils/theme/colors.dart';
// import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

// class UserValidationSidebar extends StatelessWidget {
//   final Map<String, int> validationData;

//   const UserValidationSidebar({
//     Key? key,
//     required this.validationData,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(icon: Icon(Icons.arrow_back_ios_new,size: 20,),onPressed: (){Navigator.pop(context);},),
//         backgroundColor: SupportBotColors.white,
//         title:  Text(
//           'User Validation Count',
//           style: SupportBotTextstyle.normal.copyWith(
//             fontWeight: FontWeight.bold
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Divider(height: 1, color: Colors.grey[300]),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: validationData.entries.map((entry) {
//                   final name = entry.key.split('@').first.replaceAll('.', ' ').capitalize();
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(name, style: SupportBotTextstyle.pierchartLabel),
//                         Text(entry.value.toString(), style: SupportBotTextstyle.pierchartLabel),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// extension StringExtension on String {
//   String capitalize() {
//     return split(' ')
//         .map((word) => word[0].toUpperCase() + word.substring(1))
//         .join(' ');
//   }
// }

import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class UserValidationSidebar extends StatelessWidget {
  final Map<String, double>? validationData;

  const UserValidationSidebar({
    Key? key,
    required this.validationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort validation data by value in descending order
    final sortedEntries = validationData?.entries.toList()
      ?..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Custom App Bar
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
                      'User Validation Count',
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

  // Helper method to format name
  String _formatName(String email) {
    if (email.isEmpty) return 'Unknown';

    return email.contains('@')
        ? email.split('@').first.replaceAll('.', ' ').capitalize()
        : email.capitalize();
  }
}

// Extension method for capitalization
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return '';

    return split(' ')
        .map((word) =>
            word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');
  }
}
