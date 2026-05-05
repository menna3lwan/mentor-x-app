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
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          final palette = MentorXThemeColorPalette.light;
          final isInitialLoading = state.isFirstLoading;
          final hour = DateTime.now().hour;
          final greeting = (hour >= 5 && hour < 12)
              ? context.t.home.dashboard.greetingMorning
              : context.t.home.dashboard.greetingEvening;

          return HomePagePage(
            backgroundColor: palette.backgroundSecondary,
            onRefresh: () async {
              bloc.add(const HomePageRefreshedEvent());
            },
            appBar: FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: HomeHeader(
                studentName: state.studentName,
                greetingText: greeting,
                unreadCount: state.unreadCountSection.data ?? 0,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.isRefreshing && state.lastUpdatedAt != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      context.t.home.dashboard.updatedAt(
                        time: state.lastUpdatedAt!,
                      ),
                      style: TextStyle(color: palette.textSecondary),
                    ),
                  ),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child:
                      state.walletSection.isFailure &&
                          state.walletSection.data == null
                      ? InlineSectionError(
                          onRetry: () => bloc.add(
                            const HomePageRetrySectionEvent(HomeSection.wallet),
                          ),
                        )
                      : WalletQuickViewCard(
                          walletSummary: state.walletSection.data,
                          isLoading:
                              isInitialLoading || state.walletSection.isLoading,
                        ),
                ),
                const Gap(16),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 100),
                  child:
                      state.bannersSection.isFailure &&
                          state.bannersSection.data == null
                      ? InlineSectionError(
                          onRetry: () => bloc.add(
                            const HomePageRetrySectionEvent(
                              HomeSection.banners,
                            ),
                          ),
                        )
                      : BannersCarousel(
                          banners: state.bannersSection.data ?? const [],
                          isLoading:
                              isInitialLoading ||
                              state.bannersSection.isLoading,
                          onTapBanner: (bannerId) =>
                              bloc.add(HomePageBannerClickedEvent(bannerId)),
                        ),
                ),
                const Gap(24),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 200),
                  child: Column(
                    children: [
                      SectionHeader(
                        title: context.t.home.dashboard.continueLearning,
                        onSeeAll: () =>
                            const MyCoursesPageRoute().push(context),
                      ),
                      const Gap(12),
                      ContinueLearningSection(
                        section: state.continueLearningSection,
                        onTapCourse: (courseId) => CourseDetailPageRoute(
                          courseId: courseId,
                        ).push(context),
                        onRetry: () => bloc.add(
                          const HomePageRetrySectionEvent(
                            HomeSection.continueLearning,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(24),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 300),
                  child: Column(
                    children: [
                      SectionHeader(
                        title: context.t.home.dashboard.featuredCourses,
                        onSeeAll: () =>
                            const CourseCatalogPageRoute().push(context),
                      ),
                      const Gap(12),
                      FeaturedCoursesSection(
                        section: state.featuredCoursesSection,
                        onTapCourse: (courseId) => CourseDetailPageRoute(
                          courseId: courseId,
                        ).push(context),
                        onRetry: () => bloc.add(
                          const HomePageRetrySectionEvent(
                            HomeSection.featuredCourses,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(24),
                if ((state.announcementsSection.data?.isNotEmpty ?? false) ||
                    state.announcementsSection.isLoading ||
                    state.announcementsSection.isFailure) ...[
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 400),
                    child: Column(
                      children: [
                        SectionHeader(
                          title: context.t.home.dashboard.announcements,
                          onSeeAll: () {},
                        ),
                        const Gap(12),
                        AnnouncementsSection(
                          section: state.announcementsSection,
                          onRetry: () => bloc.add(
                            const HomePageRetrySectionEvent(
                              HomeSection.announcements,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(24),
                ],
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: context.t.home.dashboard.quickActions,
                      ),
                      const Gap(12),
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
                            default:
                              return;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const Gap(40),
              ],
            ),
          );
        },
      ),
    );
  }
}
