import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../bloc/home_bloc.dart';
import '../widgets/child_switcher.dart';
import '../widgets/parent_hero_card.dart';
import '../widgets/parent_activity_feed.dart';
import '../widgets/parent_quick_actions_grid.dart';
 
final class HomePagePage extends StatelessWidget {
  final HomeStatus status;
  final List<ParentChildEntity> children;
  final ParentChildEntity? selectedChild;
  final ParentHomeSummaryEntity? summary;
  final List<ParentRecentActivityEntity> recentActivity;
  final List<AnnouncementEntity> announcements;
  final String? errorMessage;
  final VoidCallback onRefresh;
  final VoidCallback onRetry;
  final ValueChanged<ParentChildEntity> onChildSwitched;

  const HomePagePage({
    super.key,
    required this.status,
    required this.children,
    required this.selectedChild,
    required this.summary,
    required this.recentActivity,
    required this.announcements,
    required this.errorMessage,
    required this.onRefresh,
    required this.onRetry,
    required this.onChildSwitched,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          RefreshIndicator(
            displacement: MediaQuery.paddingOf(context).top + 80,
            color: context.brandPrimaryColor,
            onRefresh: () async => onRefresh(),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(MediaQuery.paddingOf(context).top + 12),
                        _buildHeader(context, t),
                        const Gap(32),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          child: ChildSwitcher(
                            children: children,
                            selectedChild: selectedChild,
                            onChildSwitched: onChildSwitched,
                          ),
                        ),
                        const Gap(32),
                        if (summary != null && selectedChild != null) ...[
                          ParentHeroCard(
                            summary: summary!,
                            selectedChildId: selectedChild!.id,
                          ),
                          const Gap(40),
                        ],
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 200),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppSectionHeader(
                                title: t.services,
                              ),
                              const Gap(16),
                              const ParentQuickActionsGrid(),
                            ],
                          ),
                        ),
                        const Gap(40),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 400),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppSectionHeader(
                                title: t.recentActivity,
                              ),
                              const Gap(16),
                              ParentActivityFeed(
                                activities: recentActivity,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (status == HomeStatus.loading)
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (status == HomeStatus.failure)
            Positioned.fill(
              child: AppErrorView(
                message: errorMessage ?? t.unableToLoad,
                onRetry: onRetry,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PARENT ACCOUNT',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: context.brandPrimaryColor,
                    letterSpacing: 2.0,
                  ),
                ),
                const Gap(4),
                Text(
                  t.welcomeBack,
                  style: TextStyle(
                    color: context.textPrimaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: MentorXIconButton(
              onPressed: () {},
              icon: Icons.notifications_none_rounded,
              color: context.textPrimaryColor,
              size: MentorXIconButtonSize.small,
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -150,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.18),
            size: 450,
          ),
        ),
        Positioned(
          top: 200,
          left: -200,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.12),
            size: 500,
          ),
        ),
        Positioned(
          top: 450,
          right: -150,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.08),
            size: 380,
          ),
        ),
        Positioned(
          bottom: -100,
          left: -50,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.1),
            size: 400,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
