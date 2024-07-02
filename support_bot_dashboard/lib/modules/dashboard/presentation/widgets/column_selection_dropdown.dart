import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class ColumnSelectionDropdown extends StatelessWidget {
  final List<String> initialSelectedColumns;
  final List<String> columnNames;
  final List<String> selectedColumns;
  final Function(List<String>) onSelectionChanged;
  final Function() onApply;

  const ColumnSelectionDropdown({
    Key? key,
    required this.initialSelectedColumns,
    required this.columnNames,
    required this.selectedColumns,
    required this.onSelectionChanged,
    required this.onApply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 200,
          child: DropDownMultiSelect(
            onChanged: (List<String> selected) {
              onSelectionChanged(selected);
            },
            options: columnNames,
            decoration: const InputDecoration(
              labelStyle: TextStyle(fontSize: 16),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            selectedValues: selectedColumns,
            whenEmpty: 'Select Columns',
          ),
        ),
        const SizedBox(width: 10),
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            onPressed: onApply,
            child: const Text('Apply Columns'),
          ),
        ),
      ],
    );
  }
}
