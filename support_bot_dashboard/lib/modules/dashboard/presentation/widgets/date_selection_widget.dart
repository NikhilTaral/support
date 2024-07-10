import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class DateSelectionWidget extends StatelessWidget {
  final String selectedValue;
  final ValueChanged<String?> onChanged;
  final String label;
  final DateTime selectedDate;
  final bool isInteractive;

  const DateSelectionWidget({
    Key? key,
    required this.selectedValue,
    required this.onChanged,
    required this.label,
    required this.selectedDate,
    required this.isInteractive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          SizedBox(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 5),
              margin: const EdgeInsets.only(top: 30, left: 25, right: 1),
              height: UIHelpers.screenHeight(context) / 18,
              width: UIHelpers.screenWidth(context)/7.5,
              child: GestureDetector(
                onTap: isInteractive
                    ? () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          onChanged(picked.toString()); // Assuming you want to pass the selected date as a string
                        }
                      }
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        selectedValue,
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    const Icon(Icons.calendar_month, color: Color.fromARGB(255, 6, 67, 117)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 35,
            top: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: Colors.white,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ], 
    );
  }
}
