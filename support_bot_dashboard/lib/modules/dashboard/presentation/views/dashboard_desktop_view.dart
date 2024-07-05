import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/pluto_table_widget.dart';
=======
import 'package:support_bot_dashboard/modules/dashboard/presentation/widgets/count_container.dart';
>>>>>>> Stashed changes

String ? count;
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
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 11,
                      child:const Row(                        
                        children:  [
                          CountContainer(text: 'Spam', icon:'assets/icons/Spam.svg' , count: '8',),
                          CountContainer(text: 'No Action Required', icon:'assets/icons/NotSpam.svg' , count: '8',),
                          CountContainer(text: 'Genuine Query', icon:'assets/icons/genuine.svg' , count: '8',),
                          CountContainer(text: 'Total', icon: 'assets/icons/TotalTicket.svg' , count: '8',)
                        ],
                      ),
                    ),
                  ),
<<<<<<< Updated upstream
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
=======
                Expanded(flex: 7, child: Container())
>>>>>>> Stashed changes
              ],
            )),
        Expanded(flex: 3, child: Container())
      ],
    ));
  }
}
