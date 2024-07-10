// import 'package:flutter/material.dart';

// class CustomDropdown extends StatelessWidget {
//   final String selectedValue;
//   final List<String> items;
//   final ValueChanged<DateTime?> onChanged;
//   final String label;
//   const CustomDropdown({
//     Key? key,
//     required this.selectedValue,
//     required this.items,
//     required this.onChanged,
//     required this.label,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return 
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             padding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 5),
//             margin: const EdgeInsets.only(top: 30, bottom: 10, left: 15, right: 1),
//             height: MediaQuery.of(context).size.height / 18,
//             width: MediaQuery.of(context).size.width / 7,
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton<String>(
//                 elevation: 0,
//                 value: selectedValue,
//                 onChanged: onChanged,
//                 items: items.map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 icon: const Icon(Icons.arrow_drop_down), 
//                 iconSize: 30, 
//                 isExpanded: true, 
//               ),
//             ),
//           );
//           Positioned(
//             left: 25,
//             top: 20,
//             child: Container(
//               padding:const EdgeInsets.symmetric(horizontal: 5),
//               color: Colors.white, 
//               child: Text(
//                 label, 
//                 style:const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 12, 
//                 ),
//               ),
//             ),
          
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final DateTime selectedValue;
  final List<String> items;
  final ValueChanged<DateTime?> onChanged;
  final String label;
  
  const CustomDropdown({
    Key? key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 5),
      margin: const EdgeInsets.only(top: 30, bottom: 10, left: 15, right: 1),
      height: MediaQuery.of(context).size.height / 18,
      width: MediaQuery.of(context).size.width / 7,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DateTime>(
          value: selectedValue,
          onChanged: onChanged,
          items: items.map((String value) {
            DateTime dateTimeValue = DateTime(2024, items.indexOf(value) + 1); // Adjust year as needed
            return DropdownMenuItem<DateTime>(
              value: dateTimeValue,
              child: Text(value),
            );
          }).toList(),
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 30,
          isExpanded: true,
        ),
      ),
    );
  }
}