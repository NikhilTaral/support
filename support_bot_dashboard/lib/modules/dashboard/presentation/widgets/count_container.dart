import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountContainer extends StatelessWidget {
  const CountContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width / 7,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              'Count',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('12'),
          ],
        ),
      ),
    );
  }
}
