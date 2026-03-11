import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/core.dart';
import 'bloc/home_page_bloc.dart';
import 'home_page_page.dart';
import 'widgets/widgets.dart';

final class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
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
            appBar: HomeHeader(
              studentName: state.studentName,
              greetingText: greeting,
              unreadCount: state.unreadCountSection.data ?? 0,
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
                if (state.walletSection.isFailure &&
                    state.walletSection.data == null)
                  InlineSectionError(
                    onRetry: () => bloc.add(
                      const HomePageRetrySectionEvent(HomeSection.wallet),
                    ),
                  )
                else
                  WalletQuickViewCard(
                    walletSummary: state.walletSection.data,
                    isLoading:
                        isInitialLoading || state.walletSection.isLoading,
                  ),
                const Gap(16),
                if (state.bannersSection.isFailure &&
                    state.bannersSection.data == null)
                  InlineSectionError(
                    onRetry: () => bloc.add(
                      const HomePageRetrySectionEvent(HomeSection.banners),
                    ),
                  )
                else
                  BannersCarousel(
                    banners: state.bannersSection.data ?? const [],
                    isLoading:
                        isInitialLoading || state.bannersSection.isLoading,
                    onTapBanner: (bannerId) =>
                        bloc.add(HomePageBannerClickedEvent(bannerId)),
                  ),
                const Gap(20),
                SectionHeader(
                  title: context.t.home.dashboard.continueLearning,
                  onSeeAll: () => const MyCoursesPageRoute().push(context),
                ),
                const Gap(8),
                ContinueLearningSection(
                  section: state.continueLearningSection,
                  onTapCourse: (courseId) =>
                      CourseDetailPageRoute(courseId: courseId).push(context),
                  onRetry: () => bloc.add(
                    const HomePageRetrySectionEvent(
                      HomeSection.continueLearning,
                    ),
                  ),
                ),
                const Gap(20),
                SectionHeader(
                  title: context.t.home.dashboard.featuredCourses,
                  onSeeAll: () => const CourseCatalogPageRoute().push(context),
                ),
                const Gap(8),
                FeaturedCoursesSection(
                  section: state.featuredCoursesSection,
                  onTapCourse: (courseId) =>
                      CourseDetailPageRoute(courseId: courseId).push(context),
                  onRetry: () => bloc.add(
                    const HomePageRetrySectionEvent(
                      HomeSection.featuredCourses,
                    ),
                  ),
                ),
                const Gap(20),
                if ((state.announcementsSection.data?.isNotEmpty ?? false) ||
                    state.announcementsSection.isLoading ||
                    state.announcementsSection.isFailure) ...[
                  SectionHeader(
                    title: context.t.home.dashboard.announcements,
                    onSeeAll: () {},
                  ),
                  const Gap(8),
                  AnnouncementsSection(
                    section: state.announcementsSection,
                    onRetry: () => bloc.add(
                      const HomePageRetrySectionEvent(
                        HomeSection.announcements,
                      ),
                    ),
                  ),
                  const Gap(20),
                ],
                SectionHeader(title: context.t.home.dashboard.quickActions),
                const Gap(8),
                QuickActionsGrid(
                  onActionTap: (index) {
                    switch (index) {
                      case 0:
                        const MyCoursesPageRoute().push(context);
                      default:
                        break;
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
