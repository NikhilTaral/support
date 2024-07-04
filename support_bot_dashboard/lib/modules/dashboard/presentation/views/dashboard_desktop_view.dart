import 'package:flutter/material.dart';

class DashboardDesktopView extends StatelessWidget {
  const DashboardDesktopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
            flex: 7,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 11,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                  ),
                ),
                Expanded(flex: 7, child: Container())
              ],
            )),
        Expanded(flex: 3, child: Container())
      ],
    ));
  }
}
