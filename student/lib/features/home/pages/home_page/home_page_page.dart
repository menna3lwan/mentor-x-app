import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/routing/app_routes.dart';
import 'bloc/home_page_bloc.dart';
import 'widgets/widgets.dart';

final class HomePagePage extends StatelessWidget {
  const HomePagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomePageBloc>();

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          RefreshIndicator(
            onRefresh: () async {
              bloc.add(const HomePageRefreshedEvent());
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
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: const WalletQuickViewCardWrapper(),
                    ),
                    const Gap(32),
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 150),
                      child: const LeaderboardShortcutCardWidget(),
                    ),
                    const Gap(32),
                    _buildQuickActions(context),
                    const Gap(32),
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 200),
                      child: const BannersCarouselWrapper(),
                    ),
                    const Gap(32),
                    _buildContinueLearning(context),
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
        ],
      ),
    );
  }

  Widget _buildUpdatedAt(BuildContext context) {
    return Builder(
      builder: (context) {
        final isRefreshing = context.select<HomePageBloc, bool>(
          (bloc) => bloc.state.isRefreshing,
        );
        final lastUpdatedAt = context.select<HomePageBloc, DateTime?>(
          (bloc) => bloc.state.lastUpdatedAt,
        );

        if (isRefreshing && lastUpdatedAt != null) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12, left: 4),
            child: Text(
              context.t.home.dashboard.updatedAt(
                time: lastUpdatedAt,
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
      },
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
                  const MyCoursesPageRoute().push(context);
                  return;
                case 1:
                  const AttendanceHistoryPageRoute().push(context);
                  return;
                case 2:
                  const MyGradesPageRoute().push(context);
                  return;
                case 3:
                  const AiConversationsPageRoute().push(context);
                  return;
                case 4:
                  const AssignmentsListPageRoute().push(context);
                  return;
                case 5:
                  const RewardsCatalogPageRoute().push(context);
                  return;
                case 6:
                  const MarketplaceGridPageRoute().push(context);
                  return;
                case 7:
                  const AnalyticsDashboardPageRoute().push(context);
                  return;
                case 8:
                  const LeaderboardPageRoute().push(context);
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
            onSeeAll: () => const MyCoursesPageRoute().push(context),
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
            onSeeAll: () => const CourseCatalogPageRoute().push(context),
          ),
          const Gap(16),
          const FeaturedCoursesSectionWrapper(),
        ],
      ),
    );
  }

  Widget _buildAnnouncements(BuildContext context) {
    return Builder(
      builder: (context) {
        final announcementsSection = context.select<HomePageBloc, dynamic>(
          (bloc) => bloc.state.announcementsSection,
        );

        if ((announcementsSection.data?.isNotEmpty ?? false) ||
            announcementsSection.isLoading ||
            announcementsSection.isFailure) {
          return FadeInUp(
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 500),
            child: Column(
              children: [
                SectionHeader(
                  title: context.t.home.dashboard.announcements,
                  onSeeAll: () {},
                ),
                const Gap(16),
                const AnnouncementsSectionWrapper(),
                const Gap(32),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
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
