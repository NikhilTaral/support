import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;
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
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 5),
          margin: const EdgeInsets.only(top: 40, bottom: 10, left: 15, right: 1),
          height: MediaQuery.of(context).size.height / 18,
          width: MediaQuery.of(context).size.width / 7.5,
          child: Theme(
            data: Theme.of(context).copyWith(
              hoverColor: Colors.white, // Set the hover color to white
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                elevation: 0,
                value: selectedValue,
                onChanged: onChanged,
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,overflow: TextOverflow.clip,),
                  );
                }).toList(),
                icon: const Icon(Icons.arrow_drop_down), // Custom dropdown icon
                iconSize: 30, // Set the size of the dropdown icon
                isExpanded: true,
                dropdownColor: Colors.white,
                focusColor: Colors.white, 
                autofocus: false,// Set the focus color to white
              ),
            ),
          ),
        ),
        Positioned(
          left: 25,
          top: 30,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: Colors.white, // Background color of the text label
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey, // Text color of the label
                fontSize: 12, // Font size of the label
              ),
            ),
          ),
        ),
      ],
    );
  }
}
