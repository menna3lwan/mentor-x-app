import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/courses_bloc.dart';

final class AcademicMonitorPage extends StatelessWidget {
  final CoursesStatus status;
  final String? errorMessage;
  final List<CourseEntity> courses;
  final ParentGradeSummaryEntity? gradeSummary;
  final VoidCallback onRefresh;
  final VoidCallback onRetry;

  const AcademicMonitorPage({
    super.key,
    required this.status,
    required this.errorMessage,
    required this.courses,
    required this.gradeSummary,
    required this.onRefresh,
    required this.onRetry,
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
    final t = Translations.of(context).parent;

    if (status == CoursesStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == CoursesStatus.failure) {
      return AppErrorView(
        message: errorMessage ?? t.unableToLoad,
        onRetry: onRetry,
      );
    }

    return RefreshIndicator(
      displacement: MediaQuery.paddingOf(context).top + 80,
      color: context.brandPrimaryColor,
      onRefresh: () async => onRefresh(),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(MediaQuery.paddingOf(context).top + 12),
                  _buildHeader(context, t),
                  const Gap(32),
                  if (gradeSummary != null) ...[
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: AppHeroCard(
                        title: t.overallAverage.toUpperCase(),
                        icon: Icons.auto_graph_rounded,
                        stats: [
                          AppHeroStatItem(
                            label: 'Average',
                            value: '${gradeSummary!.overallAverage.toStringAsFixed(1)}%',
                            onTap: () {},
                          ),
                          AppHeroStatItem(
                            label: 'Graded',
                            value: gradeSummary!.graded.toString(),
                            onTap: () {},
                          ),
                          AppHeroStatItem(
                            label: 'Pending',
                            value: gradeSummary!.pending.toString(),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const Gap(40),
                  ],

                  if (courses.isEmpty && gradeSummary == null) ...[
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: AppEmptyView(
                        title: t.noData,
                        message: 'Academic data will appear here once available.',
                        icon: Icons.auto_stories_rounded,
                        onAction: onRefresh,
                        actionLabel: 'Refresh',
                      ),
                    ),
                  ] else ...[
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 100),
                      child: AppSectionHeader(title: t.enrolledCourses),
                    ),
                    const Gap(16),
                    ...courses.asMap().entries.map(
                          (entry) => _CourseCard(
                            course: entry.value,
                            index: entry.key,
                          ),
                        ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            style: IconButton.styleFrom(
              backgroundColor: context.backgroundSecondaryColor.withValues(alpha: 0.6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Text(
              t.academicMonitor,
              style: TextStyle(
                color: context.textPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.0,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final CourseEntity course;
  final int index;

  const _CourseCard({required this.course, required this.index});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      delay: Duration(milliseconds: 100 * index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.borderPrimaryColor.withValues(alpha: 0.1)),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.brandPrimaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.book_rounded, color: context.brandPrimaryColor, size: 24),
          ),
          title: Text(
            course.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: context.textPrimaryColor,
              letterSpacing: -0.2,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              children: [
                Icon(Icons.video_library_rounded, size: 14, color: context.textTertiaryColor),
                const Gap(4),
                Text(
                  '${course.totalSessions} Sessions',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_forward_ios_rounded, color: context.textTertiaryColor, size: 12),
          ),
          onTap: () {
            // Navigate to course details
          },
        ),
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
          top: -150,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -100,
          left: -50,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 350,
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
