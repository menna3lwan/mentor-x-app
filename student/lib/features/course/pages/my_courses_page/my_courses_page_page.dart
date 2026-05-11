import 'dart:ui';
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
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        Gap(MediaQuery.paddingOf(context).top + 20),
        _buildHeader(context),
        FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _TabBar(
              selectedTab: selectedTab,
              onTabChanged: onTabChanged,
            ),
          ),
        ),
        const Gap(16),
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
          Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: context.textPrimaryColor,
                    size: 18,
                  ),
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ),
          ),
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'MY ACADEMY',
                    style: TextStyle(
                      fontSize: 10,
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
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.8,
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
      return Center(
        child: FadeIn(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 64,
                  color: context.statusDangerColor.withValues(alpha: 0.3),
                ),
                const Gap(24),
                Text(
                  errorMessage!,
                  style: TextStyle(
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
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
              onTap: () => onCourseTap(course.id),
            ),
          );
        },
      ),
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
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
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
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
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
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                      style: TextStyle(
                        fontSize: 13,
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
        ),
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
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.borderPrimaryColor.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                ),
              ),
              const Gap(40),
              Text(
                context.t.course.empty.noEnrolledCourses,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.5,
                ),
              ),
              const Gap(16),
              Text(
                context.t.course.empty.noEnrolledCoursesDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
