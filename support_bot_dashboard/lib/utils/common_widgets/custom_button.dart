import 'package:flutter/material.dart';
import 'package:support_bot_dashboard/utils/ui_helpers.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  

  const CustomElevatedButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return SizedBox(
    width: UIHelpers.screenWidth(context)/5.6,
    height: UIHelpers.screenHeight(context) /18,
    child: Container(
        margin:const EdgeInsets.only(left: 20),
        width: MediaQuery.of(context).size.width/4,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
          ),
            child: Text(text),
        ),
      ),
  );
  }
}
