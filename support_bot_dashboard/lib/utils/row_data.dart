// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:support_bot_dashboard/utils/theme/text_styles.dart';
// import 'package:support_bot_dashboard/utils/ui_helpers.dart';

// class MyPopupWidget extends StatefulWidget {
//   final List<Map<String, dynamic>> rowData; // Assuming rowData is a List of maps

//   const MyPopupWidget({required this.rowData});

//   @override
//   _MyPopupWidgetState createState() => _MyPopupWidgetState();
// }

// class _MyPopupWidgetState extends State<MyPopupWidget> {
//   int currentIndex = 0; // Track the current row index

//   @override
//   Widget build(BuildContext context) {
//     Map<String, dynamic> currentRow = widget.rowData[currentIndex];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Header with arrow buttons
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               onPressed: currentIndex > 0
//                   ? () {
//                       setState(() {
//                         currentIndex--;
//                       });
//                     }
//                   : null, // Disable button if at the first row
//               icon: const Icon(Icons.arrow_circle_left_outlined),
//             ),
//             Text(
//               "Ticket details",
//               style: SupportBotTextstyle.columnHeading.copyWith(fontSize: 20),
//             ),
//             IconButton(
//               onPressed: currentIndex < widget.rowData.length - 1
//                   ? () {
//                       setState(() {
//                         currentIndex++;
//                       });
//                     }
//                   : null, // Disable button if at the last row
//               icon: const Icon(Icons.arrow_circle_right_outlined),
//             ),
//           ],
//         ),
//         // Displaying the current row's data
//         ...currentRow.entries.map((entry) {
//           if (entry.key.toLowerCase() == "action") {
//             return const SizedBox.shrink();
//           }

//           String capitalizedKey = entry.key
//               .split('_')
//               .join(' ')
//               .split(' ')
//               .map((word) => word.isNotEmpty
//                   ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
//                   : '')
//               .join(' ');

//           bool isEmpty = (entry.value?.toString() ?? '').isEmpty;
//           String value = isEmpty ? 'N/A' : entry.value.toString();

//           if (entry.key.toLowerCase() == 'status') {
//             bool statusValue = entry.value == true;
//             value = statusValue ? 'Correct' : 'In Correct';
//           }

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "$capitalizedKey: ",
//                 style: SupportBotTextstyle.columnHeading,
//               ),
//               UIHelpers.verticalSpaceTiny,
//               SelectableText(
//                 value,
//                 style: isEmpty
//                     ? SupportBotTextstyle.cellHeading.copyWith(
//                         color: Colors.black54, fontStyle: FontStyle.italic)
//                     : SupportBotTextstyle.cellHeading,
//               ),
//               UIHelpers.verticalSpaceRegular,
//             ],
//           );
//         }).toList(),
//       ],
//     );
//   }
// }
