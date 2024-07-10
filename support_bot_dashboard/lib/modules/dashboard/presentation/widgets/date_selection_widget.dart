import 'package:flutter/material.dart';

class DateSelectionWidget extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;
  final String label;
  final bool isInteractive;

  const DateSelectionWidget({
    Key? key,
    required this.selectedDate,
    required this.onChanged,
    required this.label,
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
            margin: const EdgeInsets.only(top: 20, left: 25, right: 1),
            height: MediaQuery.of(context).size.height / 18,
            width: MediaQuery.of(context).size.width / 7,
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
                        onChanged(picked);
                      }
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      selectedDate != DateTime.now()
                          ? selectedDate.toIso8601String().substring(0, 10)
                          : 'Select date',
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
          top: 10,
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
