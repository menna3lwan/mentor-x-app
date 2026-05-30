import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

import '../../../core/core.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/home_bloc.dart';
import '../widgets/widgets.dart';
import 'home_page_page.dart' hide HomeSection;

/// Top-level entry for the parent home tab. Owns the [HomeBloc] lifecycle,
/// listens for one-shot presentation events (toasts), and composes the
/// section wrappers into the layout shell ([HomePagePage]).
final class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        childrenRepository: context.read<ParentChildrenRepository>(),
        homeRepository: context.read<ParentHomeRepository>(),
        cacheRepository: context.read<CacheRepository>(),
      )..add(const HomeStarted()),
      child: const _HomePageView(),
    );
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<HomeBloc, HomePresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case HomeFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
          case HomeUnauthorizedPresentationEvent():
            // Drop the local session and bounce to login.
            context.read<AppAuthenticationCubit>().logout();
            const LoginPageRoute().go(context);
        }
      },
      child: AppRefreshListener(
        onRefresh: () =>
            context.read<HomeBloc>().add(const HomeRefreshRequested()),
        child: HomePagePage(
          title: t.dashboardTitle,
          onRefresh: () async =>
              context.read<HomeBloc>().add(const HomeRefreshRequested()),
          actions: [
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (a, b) => a.selectedChild?.id != b.selectedChild?.id,
              builder: (context, state) {
                final childId = state.selectedChild?.id;
                return _NotificationActionButton(
                  tooltip: t.notifications,
                  onPressed: childId == null
                      ? null
                      : () => NotificationsRoute(childId: childId).go(context),
                );
              },
            ),
            const Gap(8),
          ],
          content: const _HomeContent(),
        ),
      ),
    );
  }
}

class _NotificationActionButton extends StatelessWidget {
  final String tooltip;
  final VoidCallback? onPressed;

  const _NotificationActionButton({
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBadgeCubit, NotificationsBadgeState>(
      buildWhen: (previous, current) => previous.count != current.count,
      builder: (context, state) {
        return IconButton(
          tooltip: tooltip,
          onPressed: onPressed,
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications_none_rounded),
              if (state.count > 0)
                Positioned(
                  right: -6,
                  top: -6,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: context.statusDangerColor,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      state.count > 99 ? '99+' : state.count.toString(),
                      style: TextStyle(
                        color: context.textForegroundColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) =>
          prev.childrenSection != curr.childrenSection ||
          prev.lastUpdatedAt != curr.lastUpdatedAt ||
          prev.isRefreshing != curr.isRefreshing,
      builder: (context, state) {
        // Top-of-screen failure to load children at all.
        if (state.childrenSection.isFailure && state.children.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 32),
            child: AppErrorView(
              message: state.childrenSection.errorMessage ?? t.unableToLoad,
              onRetry: () => context.read<HomeBloc>().add(
                HomeRetrySectionRequested(HomeSection.children),
              ),
            ),
          );
        }

        // No children linked yet → dedicated empty state.
        final isResolved = state.childrenSection.isLoaded;
        if (isResolved && state.children.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeroHeading(label: t.home.parentAccount),
                const Gap(24),
                NoChildrenLinkedState(
                  title: t.home.noChildrenTitle,
                  hint: t.home.noChildrenHint,
                  actionLabel: t.home.linkChild,
                  onLinkChildPressed: () =>
                      const AddChildLinkRoute().go(context),
                ),
              ],
            ),
          );
        }

        // Full dashboard layout.
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeUpdatedAtChip(
              lastUpdatedAt: state.isRefreshing ? state.lastUpdatedAt : null,
              labelBuilder: (time) => t.home.updatedAt(
                time: DateFormat('hh:mm a').format(time),
              ),
            ),
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: _HeroHeading(label: t.home.parentAccount),
            ),
            const Gap(24),
            const ChildSwitcherWrapper(),
            const Gap(24),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: const ParentHeroCardWrapper(),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 100),
              child: _SectionBlock(
                title: t.services,
                child: const ParentQuickActionsWrapper(),
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 200),
              child: _SectionBlock(
                title: t.home.upcomingSessions,
                onSeeAll: _onSeeAllAcademic(context),
                child: const UpcomingSessionsWrapper(),
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 300),
              child: _SectionBlock(
                title: t.home.recentGrades,
                onSeeAll: _onSeeAllGrades(context),
                child: const RecentGradesWrapper(),
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 400),
              child: _SectionBlock(
                title: t.announcements,
                onSeeAll: _onSeeAllAnnouncements(context),
                child: const ParentAnnouncementsWrapper(),
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 500),
              child: _SectionBlock(
                title: t.recentActivity,
                child: const ParentActivityFeedWrapper(),
              ),
            ),
            const Gap(100),
          ],
        );
      },
    );
  }

  VoidCallback? _onSeeAllAcademic(BuildContext context) {
    final childId = context.read<HomeBloc>().state.selectedChild?.id;
    if (childId == null) return null;
    return () => AcademicMonitorRoute(childId: childId).go(context);
  }

  VoidCallback? _onSeeAllGrades(BuildContext context) {
    final childId = context.read<HomeBloc>().state.selectedChild?.id;
    if (childId == null) return null;
    return () => GradeMonitorRoute(childId: childId).go(context);
  }

  VoidCallback? _onSeeAllAnnouncements(BuildContext context) {
    final childId = context.read<HomeBloc>().state.selectedChild?.id;
    if (childId == null) return null;
    return () => AnnouncementsRoute(childId: childId).go(context);
  }
}

class _HeroHeading extends StatelessWidget {
  final String label;
  const _HeroHeading({required this.label});

  @override
  Widget build(BuildContext context) {
    // Slight downscale on narrow phones (e.g. iPhone SE 320px width) so the
    // heading doesn't dominate the viewport.
    final width = MediaQuery.sizeOf(context).width;
    final fontSize = width < 360 ? 22.0 : 26.0;
    return Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: context.textPrimaryColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        letterSpacing: -1.0,
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onSeeAll;

  const _SectionBlock({
    required this.title,
    required this.child,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: context.textPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (onSeeAll != null)
              TextButton(
                onPressed: onSeeAll,
                child: Text(Translations.of(context).parent.viewAll),
              ),
          ],
        ),
        const Gap(12),
        child,
      ],
    );
  }
}
