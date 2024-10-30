import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/theme/colors.dart';
import 'package:support_bot_dashboard/utils/theme/text_styles.dart';

class UserValidationSidebar extends StatelessWidget {
  final Map<String, int> validationData;

  const UserValidationSidebar({
    Key? key,
    required this.validationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new,size: 10,),onPressed: (){Navigator.pop(context);},),
        backgroundColor: SupportBotColors.white,
        title: const Text(
          'User Validation Details',
          style: SupportBotTextstyle.sidebarTitle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(height: 1, color: Colors.grey[300]),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: validationData.entries.map((entry) {
                  final name = entry.key.split('@').first.replaceAll('.', ' ').capitalize();
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name, style: SupportBotTextstyle.pierchartLabel),
                        Text(entry.value.toString(), style: SupportBotTextstyle.pierchartLabel),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
extension StringExtension on String {
  String capitalize() {
    return split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
