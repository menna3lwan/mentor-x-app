import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/rewards_catalog_bloc.dart';
import 'rewards_catalog_page.dart';

class RewardsCatalogPageWrapper extends StatelessWidget {
  const RewardsCatalogPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RewardsCatalogBloc(
        rewardsRepository: context.read<RewardsRepository>(),
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const RewardsPageStartedEvent()),
      child:
          BlocPresentationListener<
            RewardsCatalogBloc,
            RewardsCatalogPresentationEvent
          >(
            listener: (context, event) {
              if (event is RewardsCatalogClaimSuccessPresentationEvent) {
                MentorXUI.showToast(
                  message: 'Successfully claimed: ${event.rewardTitle}',
                );
              } else if (event is RewardsCatalogFailurePresentationEvent) {
                MentorXUI.showToast(message: event.message);
              }
            },
            child: const RewardsCatalogPage(),
          ),
    );
  }
}
