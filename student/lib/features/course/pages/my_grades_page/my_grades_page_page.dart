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
                          child: MentorXSkeleton(height: 140, borderRadius: 32),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: MentorXSkeleton(height: 56, borderRadius: 16),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(20),
                            itemCount: 3,
                            separatorBuilder: (_, _) => const Gap(20),
                            itemBuilder: (_, _) => const MentorXSkeleton(
                                height: 200, borderRadius: 24),
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
              color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
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
                    'PERFORMANCE',
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
        icon: Icons.school_rounded,
      );
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
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
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final section = state.sections[index];
                return FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 50 * index),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
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
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.brandPrimaryColor.withValues(alpha: 0.2),
                      context.brandPrimaryColor.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  ),
                ),
                child: Icon(
                  Icons.auto_graph_rounded,
                  color: context.brandPrimaryColor,
                  size: 32,
                ),
              ),
              const Gap(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t['overallAverage'] ?? 'Overall Average',
                      style: TextStyle(
                        color: context.textTertiaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Gap(4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          display,
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: context.textPrimaryColor,
                            letterSpacing: -1.5,
                          ),
                        ),
                        const Gap(4),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '%',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: context.brandPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCourseId ?? 'all',
              isExpanded: true,
              dropdownColor: context.backgroundSecondaryColor,
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
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                          fontWeight: FontWeight.w900,
                          color: context.textPrimaryColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const Gap(12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: context.brandPrimaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              context.brandPrimaryColor.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        section.averagePercentage == null
                            ? '--'
                            : '${section.averagePercentage!.toStringAsFixed(1)}%',
                        style: TextStyle(
                          color: context.brandPrimaryColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
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
              const Gap(12),
            ],
          ),
        ),
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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.backgroundPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: context.textTertiaryColor, size: 20),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: context.textTertiaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(12),
              Text(
                percentage == null
                    ? '--'
                    : '${percentage!.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ],
          ),
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

