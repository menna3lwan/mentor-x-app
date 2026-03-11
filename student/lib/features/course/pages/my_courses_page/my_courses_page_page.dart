import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(context.t.course.myCourses),
      ),
      body: Column(
        children: [
          _TabBar(
            selectedTab: selectedTab,
            onTabChanged: onTabChanged,
          ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: palette.statusDanger),
            const SizedBox(height: 12),
            Text(
              errorMessage!,
              style: TextStyle(color: palette.statusDanger),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (courses.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school_outlined,
                size: 64,
                color: palette.textSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                context.t.course.empty.noEnrolledCourses,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                context.t.course.empty.noEnrolledCoursesDescription,
                style: TextStyle(color: palette.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onBrowseCatalog,
                child: Text(context.t.course.empty.browseCatalog),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final course = courses[index];
          return EnrolledCourseCard(
            course: course,
            onTap: () => onCourseTap(course.id),
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
    final palette = MentorXThemeColorPalette.light;

    return Container(
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        border: Border(
          bottom: BorderSide(
            color: palette.textTertiary,
            width: 0.5,
          ),
        ),
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
            child: InkWell(
              onTap: () => onTabChanged(tab),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? palette.brandPrimary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    color: isSelected
                        ? palette.brandPrimary
                        : palette.textSecondary,
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
