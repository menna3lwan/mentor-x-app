import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

import 'bloc/my_courses_page_bloc.dart';
import 'widgets/widgets.dart';

final class MyCoursesPagePage extends StatelessWidget {
  final MyCoursesTab selectedTab;
  final bool isLoading;
  final List<CourseSummaryEntity> courses;
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
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
            boxShadow: [
              BoxShadow(color: palette.brandPrimary.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 4)),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              context.t.course.myCourses,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.5),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Gap(16),
          FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _TabBar(
                selectedTab: selectedTab,
                onTabChanged: onTabChanged,
                palette: palette,
              ),
            ),
          ),
          const Gap(8),
          Expanded(
            child: _buildBody(context, palette),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, MentorXThemeColorPalette palette) {
    if (errorMessage != null) {
      return Center(
        child: FadeIn(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline_rounded, size: 64, color: palette.statusDanger.withValues(alpha: 0.3)),
                const Gap(24),
                Text(
                  errorMessage!,
                  style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (courses.isEmpty) {
      return _EmptyCourses(
        palette: palette,
        onBrowseCatalog: onBrowseCatalog,
      );
    }

    return RefreshIndicator(
      color: palette.brandPrimary,
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: courses.length,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) {
          final course = courses[index];
          return FadeInUp(
            duration: const Duration(milliseconds: 500),
            delay: Duration(milliseconds: 50 * index),
            child: EnrolledCourseCard(
              course: course,
              onTap: () => onCourseTap(course.id),
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
  final MentorXThemeColorPalette palette;

  const _TabBar({
    required this.selectedTab,
    required this.onTabChanged,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
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
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? palette.brandPrimary : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isSelected
                      ? [BoxShadow(color: palette.brandPrimary.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))]
                      : null,
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: isSelected ? Colors.white : palette.textSecondary,
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

class _EmptyCourses extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final VoidCallback onBrowseCatalog;

  const _EmptyCourses({required this.palette, required this.onBrowseCatalog});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeInUp(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: palette.backgroundPrimary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20),
                  ],
                ),
                child: Icon(Icons.school_rounded, size: 80, color: palette.textTertiary.withValues(alpha: 0.2)),
              ),
              const Gap(32),
              Text(
                context.t.course.empty.noEnrolledCourses,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: palette.textPrimary),
              ),
              const Gap(12),
              Text(
                context.t.course.empty.noEnrolledCoursesDescription,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: palette.textSecondary),
              ),
              const Gap(40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: MentorXButton(
                  onPressed: onBrowseCatalog,
                  text: context.t.course.empty.browseCatalog,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
