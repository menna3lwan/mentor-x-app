import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/rewards_catalog_bloc.dart';
import 'rewards_catalog_page.dart';

final class RewardsCatalogPageWrapper extends StatelessWidget {
  const RewardsCatalogPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final rewardsRepo = context.read<RewardsRepository>();
        final walletRepo = context.read<WalletRepository>();
        final analyticsService = context.read<AnalyticsService>();
        return RewardsCatalogBloc(
          rewardsRepository: rewardsRepo,
          walletRepository: walletRepo,
          analyticsService: analyticsService,
        )..add(const RewardsPageStartedEvent());
      },
      child: BlocPresentationListener<
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
        child: Builder(
          builder: (context) {
            final isFirstLoading = context.select(
              (RewardsCatalogBloc bloc) => bloc.state.isFirstLoading,
            );
            final points = context.select(
              (RewardsCatalogBloc bloc) => bloc.state.pointsSection.data ?? 0,
            );
            final items = context.select(
              (RewardsCatalogBloc bloc) => bloc.state.itemsSection.data ?? <RewardItemEntity>[],
            );

            return RewardsCatalogPage(
              isFirstLoading: isFirstLoading,
              points: points,
              items: items,
              onRefresh: () {
                final bloc = context.read<RewardsCatalogBloc>();
                bloc.add(const RewardsPageRefreshedEvent());
              },
              onRedeem: (item) {
                final bloc = context.read<RewardsCatalogBloc>();
                bloc.add(RewardsPageClaimRequestedEvent(item.id));
              },
            );
          },
        ),
      ),
    );
  }
}
