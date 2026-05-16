import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/my_courses_page_bloc.dart';
import 'widgets/widgets.dart';

final class MyCoursesPagePage extends StatelessWidget {
  final MyCoursesTab selectedTab;
  final bool isLoading;
  final List<EnrollmentEntity> courses;
  final String? errorMessage;
  final ValueChanged<MyCoursesTab> onTabChanged;
  final Future<void> Function() onRefresh;
  final ValueChanged<String> onCourseTap;
  final VoidCallback onBrowseCatalog;

  const MyCoursesPagePage({
    super.key,
    required this.selectedTab,
    required this.isLoading,
    required this.courses,
    required this.errorMessage,
    required this.onTabChanged,
    required this.onRefresh,
    required this.onCourseTap,
    required this.onBrowseCatalog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        Gap(MediaQuery.paddingOf(context).top + 12),
        _buildHeader(context),
        FadeInDown(
          duration: const Duration(milliseconds: 600),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _TabBar(
              selectedTab: selectedTab,
              onTabChanged: onTabChanged,
            ),
          ),
        ),
        const Gap(24),
        Expanded(
          child: _buildBody(context),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Row(
        children: [
          MentorXIconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icons.arrow_back_ios_new_rounded,
            variant: MentorXIconButtonVariant.outline,
            size: MentorXIconButtonSize.small,
          ),
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    context.t.course.myAcademy,
                    style: context.smallTextStyle.copyWith(
                      fontWeight: FontWeight.w900,
                      color: context.brandPrimaryColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                const Gap(4),
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    context.t.course.myCourses,
                    style: context.titleH1Style.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (errorMessage != null) {
      return AppErrorView(
        message: errorMessage!,
        onRetry: onRefresh,
      );
    }

    if (isLoading) {
      return ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) => const MentorXSkeleton(
          height: 120,
          borderRadius: 24,
        ),
      );
    }

    if (courses.isEmpty) {
      return _EmptyCourses(
        onBrowseCatalog: onBrowseCatalog,
      );
    }

    return RefreshIndicator(
      color: context.brandPrimaryColor,
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
        physics: const BouncingScrollPhysics(),
        itemCount: courses.length,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) {
          final course = courses[index];
          return FadeInUp(
            duration: const Duration(milliseconds: 500),
            delay: Duration(milliseconds: 100 * index),
            child: EnrolledCourseCard(
              course: course,
              onTap: () => onCourseTap(course.courseId),
            ),
          );
        },
      ),
    );
  }
}



final class _TabBar extends StatelessWidget {
  final MyCoursesTab selectedTab;
  final ValueChanged<MyCoursesTab> onTabChanged;

  const _TabBar({
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      borderRadius: BorderRadius.circular(24),
      style: Style(
        $box.padding.all(6),
        $box.shadows(context.softShadow),
      ),
      child: Row(
        children: MyCoursesTab.values.map((tab) {
          final isSelected = tab == selectedTab;
          final label = switch (tab) {
            MyCoursesTab.inProgress => context.t.course.tabs.inProgress,
            MyCoursesTab.completed => context.t.course.tabs.completed,
            MyCoursesTab.expired => context.t.course.tabs.expired,
          };

          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            context.brandPrimaryColor,
                            context.brandSecondaryColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isSelected ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: context.brandPrimaryColor.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: context.smallTextStyle.copyWith(
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w800,
                    color: isSelected
                        ? context.textForegroundColor
                        : context.textPrimaryColor.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

final class _EmptyCourses extends StatelessWidget {
  final VoidCallback onBrowseCatalog;

  const _EmptyCourses({required this.onBrowseCatalog});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeInUp(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MentorXGlassCard(
                borderRadius: BorderRadius.circular(100),
                style: Style(
                  $box.padding.all(40),
                  $box.shadows(context.mediumShadow),
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      context.textTertiaryColor.withValues(alpha: 0.3),
                      context.textTertiaryColor.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Icon(
                    Icons.school_rounded,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(40),
              Text(
                context.t.course.empty.noEnrolledCourses,
                textAlign: TextAlign.center,
                style: context.titleH1Style.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const Gap(16),
              Text(
                context.t.course.empty.noEnrolledCoursesDescription,
                textAlign: TextAlign.center,
                style: context.bodyPrimaryStyle.copyWith(
                  color: context.textSecondaryColor,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              const Gap(48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: MentorXButton(
                  onPressed: onBrowseCatalog,
                  label: context.t.course.empty.browseCatalog,
                  color: context.brandPrimaryColor,
                  size: MentorXButtonSize.large,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
