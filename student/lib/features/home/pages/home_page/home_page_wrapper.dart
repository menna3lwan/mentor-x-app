import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../core/core.dart';
import 'bloc/home_page_bloc.dart';
import 'home_page_page.dart';
import 'widgets/widgets.dart';

final class HomePageWrapper extends StatefulWidget {
  const HomePageWrapper({super.key});

  @override
  State<HomePageWrapper> createState() => _HomePageWrapperState();
}

final class _HomePageWrapperState extends State<HomePageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<HomePageBloc, HomePagePresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case HomePageFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final bloc = context.read<HomePageBloc>();

    return AppRefreshListener(
      onRefresh: () => bloc.add(const HomePageRefreshedEvent()),
      child: HomePagePage(
        onRefresh: () async {
          bloc.add(const HomePageRefreshedEvent());
        },
        appBar: FadeInDown(
          duration: const Duration(milliseconds: 600),
          child: const HomeHeaderWrapper(),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(
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
            ),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: const WalletQuickViewCardWrapper(),
            ),
            const Gap(32),
            FadeInUp(
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
                          const StudentCardPageRoute().push(context);
                          return;
                        default:
                          return;
                      }
                    },
                  ),
                ],
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 200),
              child: const BannersCarouselWrapper(),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 300),
              child: Column(
                children: [
                  SectionHeader(
                    title: context.t.home.dashboard.continueLearning,
                    onSeeAll: () =>
                        const MyCoursesPageRoute().push(context),
                  ),
                  const Gap(16),
                  const ContinueLearningSectionWrapper(),
                ],
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 400),
              child: Column(
                children: [
                  SectionHeader(
                    title: context.t.home.dashboard.featuredCourses,
                    onSeeAll: () =>
                        const CourseCatalogPageRoute().push(context),
                  ),
                  const Gap(16),
                  const FeaturedCoursesSectionWrapper(),
                ],
              ),
            ),
            const Gap(32),
            Builder(
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
            ),
            const Gap(60),
          ],
        ),
      ),
    );
  }
}
