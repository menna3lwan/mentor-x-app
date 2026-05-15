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
import 'home_page_page.dart';

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
        }
      },
      child: AppRefreshListener(
        onRefresh: () =>
            context.read<HomeBloc>().add(const HomeRefreshRequested()),
        child: HomePagePage(
          title: t.dashboardTitle,
          onRefresh: () async => context
              .read<HomeBloc>()
              .add(const HomeRefreshRequested()),
          actions: [
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (a, b) =>
                  a.selectedChild?.id != b.selectedChild?.id,
              builder: (context, state) {
                final childId = state.selectedChild?.id;
                return IconButton(
                  tooltip: t.notifications,
                  onPressed: childId == null
                      ? null
                      : () =>
                          NotificationsRoute(childId: childId).go(context),
                  icon: const Icon(Icons.notifications_none_rounded),
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
                    const HomeRetrySectionRequested(HomeSection.children),
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
              child: HomeSection(
                title: t.services,
                child: const ParentQuickActionsWrapper(),
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 200),
              child: HomeSection(
                title: t.home.upcomingSessions,
                onSeeAll: _onSeeAllAcademic(context),
                child: const UpcomingSessionsWrapper(),
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 300),
              child: HomeSection(
                title: t.home.recentGrades,
                onSeeAll: _onSeeAllGrades(context),
                child: const RecentGradesWrapper(),
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 400),
              child: HomeSection(
                title: t.announcements,
                onSeeAll: _onSeeAllAnnouncements(context),
                child: const ParentAnnouncementsWrapper(),
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 500),
              child: HomeSection(
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
    return Text(
      label,
      style: TextStyle(
        color: context.textPrimaryColor,
        fontSize: 26,
        fontWeight: FontWeight.w900,
        letterSpacing: -1.0,
      ),
    );
  }
}
