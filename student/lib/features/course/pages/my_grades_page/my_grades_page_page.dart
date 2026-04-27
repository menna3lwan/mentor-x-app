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
    final palette = MentorXThemeColorPalette.light;
    final t = context.t.student;

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
              t['myGrades'] ?? 'My Grades',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.5),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        color: palette.brandPrimary,
        onRefresh: () async => onRefresh(),
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.loadingState.isError
                ? _ErrorView(errorMessage: state.errorMessage, palette: palette)
                : _buildLoaded(context, palette, t),
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, MentorXThemeColorPalette palette, dynamic t) {
    if (state.sections.isEmpty) {
      return FadeInUp(child: _EmptyGrades(palette: palette, t: t));
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
                palette: palette,
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
                palette: palette,
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
                  delay: Duration(milliseconds: 200 + (100 * index)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _CourseSectionCard(
                      section: section,
                      palette: palette,
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
        const SliverToBoxAdapter(child: Gap(40)),
      ],
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  final double? average;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _SummaryHeader({required this.average, required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    final display = average == null ? '--' : average!.toStringAsFixed(1);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: palette.brandPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.auto_graph_rounded, color: palette.brandPrimary, size: 32),
          ),
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t['overallAverage'] ?? 'Overall Average',
                  style: TextStyle(color: palette.textSecondary, fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const Gap(4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      display,
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: palette.textPrimary),
                    ),
                    const Gap(4),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        '%',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: palette.brandPrimary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseFilter extends StatelessWidget {
  final String? selectedCourseId;
  final List<CourseSummaryEntity> courses;
  final ValueChanged<String?> onChanged;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _CourseFilter({
    required this.selectedCourseId,
    required this.courses,
    required this.onChanged,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.brandPrimary.withValues(alpha: 0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCourseId ?? 'all',
          isExpanded: true,
          style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.w700, fontSize: 14),
          icon: Icon(Icons.filter_list_rounded, color: palette.brandPrimary),
          items: [
            DropdownMenuItem(value: 'all', child: Text(t['allCourses'] ?? 'All Courses')),
            ...courses.map<DropdownMenuItem<String>>(
              (course) => DropdownMenuItem<String>(
                value: course.id,
                child: Text(course.title),
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _CourseSectionCard extends StatelessWidget {
  final CourseGradesSection section;
  final MentorXThemeColorPalette palette;
  final dynamic t;
  final ValueChanged<String> onQuizTap;
  final ValueChanged<String> onAssignmentTap;

  const _CourseSectionCard({
    required this.section,
    required this.palette,
    required this.t,
    required this.onQuizTap,
    required this.onAssignmentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    section.course.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: palette.textPrimary),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: palette.brandPrimary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    section.averagePercentage == null
                        ? '--'
                        : '${section.averagePercentage!.toStringAsFixed(1)}%',
                    style: TextStyle(color: palette.brandPrimary, fontWeight: FontWeight.w900, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: palette.backgroundSecondary),
          ...section.quizzes.map(
            (quiz) => _AssessmentTile(
              title: 'Quiz ${quiz.quizId}',
              subtitle: 'Score ${quiz.score}/${quiz.totalMarks}',
              percentage: quiz.percentage,
              icon: Icons.quiz_rounded,
              palette: palette,
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
                palette: palette,
                onTap: () => onAssignmentTap(assignment.assignmentId),
              );
            },
          ),
          const Gap(12),
        ],
      ),
    );
  }
}

class _AssessmentTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final double? percentage;
  final IconData icon;
  final MentorXThemeColorPalette palette;
  final VoidCallback onTap;

  const _AssessmentTile({
    required this.title,
    required this.subtitle,
    required this.percentage,
    required this.icon,
    required this.palette,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _scoreColor(percentage, palette);

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
                  color: palette.backgroundSecondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: palette.textSecondary, size: 20),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: palette.textPrimary),
                    ),
                    const Gap(2),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 11, color: palette.textTertiary, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Gap(12),
              Text(
                percentage == null ? '--' : '${percentage!.toStringAsFixed(1)}%',
                style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _scoreColor(double? percentage, MentorXThemeColorPalette palette) {
    if (percentage == null) return palette.textSecondary;
    if (percentage >= 85) return palette.statusSuccess;
    if (percentage >= 70) return palette.brandPrimary;
    if (percentage >= 50) return Colors.orange;
    return palette.statusDanger;
  }
}

class _ErrorView extends StatelessWidget {
  final String? errorMessage;
  final MentorXThemeColorPalette palette;

  const _ErrorView({this.errorMessage, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, size: 64, color: palette.statusDanger.withValues(alpha: 0.3)),
            const Gap(24),
            Text(
              errorMessage ?? 'Unable to load grades.',
              textAlign: TextAlign.center,
              style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyGrades extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _EmptyGrades({required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20),
              ],
            ),
            child: Icon(Icons.school_rounded, size: 80, color: palette.textTertiary.withValues(alpha: 0.2)),
          ),
          const Gap(32),
          Text(
            t['noGrades'] ?? 'No grades available yet.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: palette.textPrimary),
          ),
          const Gap(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              t['completeAssessmentsDesc'] ?? 'Complete quizzes and assignments to see your grades.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: palette.textSecondary, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
