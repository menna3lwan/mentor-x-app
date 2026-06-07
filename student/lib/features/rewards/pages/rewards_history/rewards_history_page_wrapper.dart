import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/rewards_history_bloc.dart';
import 'rewards_history_page.dart';

class RewardsHistoryPageWrapper extends StatelessWidget {
  const RewardsHistoryPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RewardsHistoryBloc(
        rewardsRepository: context.read<RewardsRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const RewardsHistoryStartedEvent()),
      child: const RewardsHistoryPage(),
    );
  }
}
