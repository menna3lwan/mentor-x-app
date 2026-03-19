import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_core/student_core.dart';
import '../rewards_catalog_page/bloc/rewards_page_bloc.dart';
import 'rewards_history_page_page.dart';

class RewardsHistoryPageWrapper extends StatelessWidget {
  const RewardsHistoryPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RewardsPageBloc(
        rewardsRepository: context.read<RewardsRepository>(),
        walletRepository: context.read<WalletRepository>(),
      )..add(const RewardsPageStartedEvent()),
      child: const RewardsHistoryPage(),
    );
  }
}
