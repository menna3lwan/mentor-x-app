import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'bloc/rewards_history_page_bloc.dart';
import 'rewards_history_page_page.dart';

class RewardsHistoryPageWrapper extends StatelessWidget {
  const RewardsHistoryPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RewardsHistoryPageBloc(
        rewardsRepository: context.read<RewardsRepository>(),
      )..add(const RewardsHistoryPageStartedEvent()),
      child: const RewardsHistoryPage(),
    );
  }
}
