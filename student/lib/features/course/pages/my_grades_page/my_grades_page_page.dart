import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../../core/core.dart';
import 'bloc/my_grades_page_bloc.dart';

final class MyGradesPagePage extends StatelessWidget {
  final MyGradesPageState state;
  final VoidCallback onRefresh;
  final ValueChanged<String?> onCourseFilterChanged;
  final ValueChanged<String> onQuizTap;
  final ValueChanged<String> onAssignmentTap;

  const MyGradesPagePage({
    super.key,
    required this.state,
    required this.onRefresh,
    required this.onCourseFilterChanged,
    required this.onQuizTap,
    required this.onAssignmentTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          Positioned.fill(
            child: RefreshIndicator(
              color: context.brandPrimaryColor,
              onRefresh: () async => onRefresh(),
              child: state.isLoading
                  ? Column(
                      children: [
                        Gap(MediaQuery.paddingOf(context).top + 20),
                        _buildHeader(context, t),
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: MentorXSkeleton(height: 140, borderRadius: 24),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: MentorXSkeleton(height: 56, borderRadius: 16),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(20),
                            itemCount: 3,
                            separatorBuilder: (_, _) => const Gap(16),
                            itemBuilder: (_, _) => const MentorXSkeleton(
                                height: 180, borderRadius: 24),
                          ),
                        ),
                      ],
                    )
                  : state.loadingState.isError
                      ? AppErrorView(
                          message:
                              state.errorMessage ?? 'Unable to load grades.',
                          onRetry: onRefresh,
                        )
                      : Column(
                          children: [
                            Gap(MediaQuery.paddingOf(context).top + 20),
                            _buildHeader(context, t),
                            Expanded(child: _buildLoaded(context, t)),
                          ],
                        ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: MentorXIconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icons.arrow_back_ios_new_rounded,
              color: context.textPrimaryColor,
              size: MentorXIconButtonSize.small,
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
                    'ACADEMIC RECORD',
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
                    t['myGrades'] ?? 'My Grades',
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

  Widget _buildLoaded(
    BuildContext context,
    dynamic t,
  ) {
    if (state.sections.isEmpty) {
      return AppEmptyView(
        title: t['noGrades'] ?? 'No grades available yet.',
        message: t['completeAssessmentsDesc'] ?? 'Complete quizzes and assignments to see your grades.',
        icon: Icons.auto_stories_rounded,
      );
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: _SummaryHeader(
                average: state.overallAverage,
                t: t,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 100),
              child: _CourseFilter(
                selectedCourseId: state.selectedCourseId,
                courses: state.courses,
                onChanged: onCourseFilterChanged,
                t: t,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final section = state.sections[index];
                return FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 50 * index),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _CourseSectionCard(
                      section: section,
                      t: t,
                      onQuizTap: onQuizTap,
                      onAssignmentTap: onAssignmentTap,
                    ),
                  ),
                );
              },
              childCount: state.sections.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: Gap(100)),
      ],
    );
  }
}

final class _SummaryHeader extends StatelessWidget {
  final double? average;
  final dynamic t;

  const _SummaryHeader({
    required this.average,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final display = average == null ? '--' : average!.toStringAsFixed(1);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.brandPrimaryColor,
            context.brandSecondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: context.brandPrimaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t['overallAverage'] ?? 'Overall Performance',
                  style: TextStyle(
                    color: context.textForegroundColor.withValues(alpha: 0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                const Gap(8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      display,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: context.textForegroundColor,
                        letterSpacing: -1.5,
                      ),
                    ),
                    const Gap(4),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        '%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: context.textForegroundColor.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_graph_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

final class _CourseFilter extends StatelessWidget {
  final String? selectedCourseId;
  final List<EnrollmentEntity> courses;
  final ValueChanged<String?> onChanged;
  final dynamic t;

  const _CourseFilter({
    required this.selectedCourseId,
    required this.courses,
    required this.onChanged,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCourseId ?? 'all',
          isExpanded: true,
          dropdownColor: context.backgroundSecondaryColor,
          borderRadius: BorderRadius.circular(16),
          style: TextStyle(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
          icon: Icon(
            Icons.filter_list_rounded,
            color: context.brandPrimaryColor,
          ),
          items: [
            DropdownMenuItem(
              value: 'all',
              child: Text(t['allCourses'] ?? 'All Courses'),
            ),
            ...courses.map<DropdownMenuItem<String>>(
              (course) => DropdownMenuItem<String>(
                value: course.id,
                child: Text(
                  course.courseTitle ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}

final class _CourseSectionCard extends StatelessWidget {
  final CourseGradesSection section;
  final dynamic t;
  final ValueChanged<String> onQuizTap;
  final ValueChanged<String> onAssignmentTap;

  const _CourseSectionCard({
    required this.section,
    required this.t,
    required this.onQuizTap,
    required this.onAssignmentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    section.course.courseTitle ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const Gap(12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: context.brandPrimaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    section.averagePercentage == null
                        ? '--'
                        : '${section.averagePercentage!.toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: context.brandPrimaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: context.borderPrimaryColor.withValues(alpha: 0.05),
          ),
          ...section.quizzes.map(
            (quiz) => _AssessmentTile(
              title: 'Quiz ${quiz.quizId}',
              subtitle: 'Score ${quiz.score}/${quiz.totalMarks}',
              percentage: quiz.percentage,
              icon: Icons.quiz_rounded,
              onTap: () => onQuizTap(quiz.quizId),
            ),
          ),
          ...section.assignments.map(
            (assignment) {
              final score = assignment.score;
              final total = assignment.totalMarks;
              final subtitle = score == null || total == null
                  ? 'Pending review'
                  : 'Score $score/$total';
              return _AssessmentTile(
                title: 'Assignment ${assignment.assignmentId}',
                subtitle: subtitle,
                percentage: assignment.percentage,
                icon: Icons.assignment_turned_in_rounded,
                onTap: () => onAssignmentTap(assignment.assignmentId),
              );
            },
          ),
          const Gap(8),
        ],
      ),
    );
  }
}

final class _AssessmentTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final double? percentage;
  final IconData icon;
  final VoidCallback onTap;

  const _AssessmentTile({
    required this.title,
    required this.subtitle,
    required this.percentage,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _scoreColor(context, percentage);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.backgroundPrimaryColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: context.textTertiaryColor, size: 18),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 14,
          color: context.textPrimaryColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 11,
          color: context.textTertiaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        percentage == null
            ? '--'
            : '${percentage!.toStringAsFixed(1)}%',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: 13,
        ),
      ),
    );
  }

  Color _scoreColor(BuildContext context, double? percentage) {
    if (percentage == null) return context.textSecondaryColor;
    if (percentage >= 85) return context.statusSuccessColor;
    if (percentage >= 70) return context.brandPrimaryColor;
    if (percentage >= 50) return Colors.orange;
    return context.statusDangerColor;
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
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 350,
          ),
        ),
        Positioned(
          bottom: -50,
          left: -100,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
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

