import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/bloc/ai_query_bloc/ai_query_bloc.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/views/ai_query_edited_dekstop_view.dart';
import 'package:support_bot_dashboard/modules/ai_query_edited/presentation/views/ai_query_edited_mobile_view.dart';
import 'package:support_bot_dashboard/responsive.dart';

class AIQueryEditedScreen extends StatelessWidget {
  const AIQueryEditedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AiQueryBloc>().add(
          AIQueryInitialEvent(),
        );
    return Scaffold(
      body: Responsive(
        mobile: const AIQueryEditedMobileView(),
        tablet: AIQueryEditedDesktopView(),
        desktop: AIQueryEditedDesktopView(),
      ),
    );
  }
}
