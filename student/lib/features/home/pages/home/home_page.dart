import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import 'widgets/widgets.dart';

final class HomePage extends StatelessWidget {
  final bool isRefreshing;
  final DateTime? lastUpdatedAt;
  final bool hasAnnouncements;
  final VoidCallback onRefresh;

  const HomePage({
    super.key,
    required this.isRefreshing,
    required this.lastUpdatedAt,
    required this.hasAnnouncements,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: RefreshIndicator(
        onRefresh: () async {
          onRefresh();
        },
        displacement: MediaQuery.paddingOf(context).top + 80,
        color: context.brandPrimaryColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(MediaQuery.paddingOf(context).top + 12),
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: const HomeHeaderWrapper(),
                ),
                const Gap(32),
                _buildUpdatedAt(context),
                _buildContinueLearning(context),
                const Gap(32),
                _buildStatsHub(context),
                const Gap(32),
                _buildQuickActions(context),
                const Gap(32),
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 200),
                  child: const BannersCarouselWrapper(),
                ),
                const Gap(32),
                _buildFeaturedCourses(context),
                const Gap(32),
                _buildAnnouncements(context),
                const Gap(60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpdatedAt(BuildContext context) {
    if (isRefreshing && lastUpdatedAt != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 4),
        child: Text(
          context.t.home.dashboard.updatedAt(
            time: lastUpdatedAt!,
          ),
          style: TextStyle(
            color: context.textTertiaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildStatsHub(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: context.t.analytics.performanceDashboard,
          ),
          const Gap(16),
          const WalletQuickViewCardWrapper(),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: context.t.home.dashboard.quickActions,
          ),
          const Gap(16),
          QuickActionsGrid(
            onActionTap: (index) {
              switch (index) {
                case 0:
                  const MyCoursesRoute().push(context);
                  return;
                case 1:
                  const AttendanceHistoryRoute().push(context);
                  return;
                case 2:
                  const MyGradesRoute().push(context);
                  return;
                case 3:
                  const AiConversationsRoute().push(context);
                  return;
                case 4:
                  const AssignmentsListRoute().push(context);
                  return;
                case 5:
                  const RewardsCatalogRoute().push(context);
                  return;
                case 6:
                  const AnalyticsDashboardRoute().push(context);
                  return;
                case 7:
                  const LeaderboardRoute().push(context);
                  return;
                default:
                  return;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContinueLearning(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 300),
      child: Column(
        children: [
          SectionHeader(
            title: context.t.home.dashboard.continueLearning,
            onSeeAll: () => const MyCoursesRoute().push(context),
          ),
          const Gap(16),
          const ContinueLearningSectionWrapper(),
        ],
      ),
    );
  }

  Widget _buildFeaturedCourses(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 400),
      child: Column(
        children: [
          SectionHeader(
            title: context.t.home.dashboard.featuredCourses,
            onSeeAll: () => const CourseCatalogRoute().push(context),
          ),
          const Gap(16),
          const FeaturedCoursesSectionWrapper(),
        ],
      ),
    );
  }

  Widget _buildAnnouncements(BuildContext context) {
    if (hasAnnouncements) {
      return FadeInUp(
        duration: const Duration(milliseconds: 600),
        delay: const Duration(milliseconds: 500),
        child: Column(
          children: [
            SectionHeader(
              title: context.t.home.dashboard.announcements,
              onSeeAll: () => const AnnouncementsRoute().push(context),
            ),
            const Gap(16),
            const AnnouncementsSectionWrapper(),
            const Gap(32),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
