import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pluto_table_widget.dart';

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
                Expanded(
                    flex: 7,
                    child: Container(
                      child: BlocProvider(
                        create: (context) =>
                            DashboardBloc()..add(FetchTableDataEvent()),
                        child: const PlutoTableWidget(),
                      ),
                    ))
              ],
            )),
        Expanded(flex: 3, child: Container())
      ],
    ));
  }
}
