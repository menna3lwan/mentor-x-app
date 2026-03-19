import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../../core/core.dart';
import 'bloc/my_grades_page_bloc.dart';

final class MyGradesPagePage extends StatelessWidget {
  final MyGradesPageState state;
  final VoidCallback onRefresh;
  final ValueChanged<String?> onCourseFilterChanged;
  final VoidCallback onQuizTap;
  final VoidCallback onAssignmentTap;

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Grades'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.loadingState.isError
            ? ListView(
                children: [
                  const SizedBox(height: 140),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        state.errorMessage ?? 'Unable to load grades.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: palette.statusDanger),
                      ),
                    ),
                  ),
                ],
              )
            : _buildLoaded(context, palette),
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, MentorXThemeColorPalette palette) {
    if (state.sections.isEmpty) {
      return ListView(
        children: [
          const SizedBox(height: 120),
          Icon(
            Icons.school_outlined,
            size: 68,
            color: palette.textSecondary,
          ),
          const SizedBox(height: 14),
          Text(
            'No grades available yet.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Complete quizzes and assignments to see your grades.',
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.textSecondary),
          ),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SummaryCard(
          average: state.overallAverage,
          palette: palette,
        ),
        const SizedBox(height: 12),
        _CourseFilter(
          selectedCourseId: state.selectedCourseId,
          courses: state.courses,
          onChanged: onCourseFilterChanged,
        ),
        const SizedBox(height: 16),
        ...state.sections.map(
          (section) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _CourseSectionCard(
              section: section,
              onQuizTap: onQuizTap,
              onAssignmentTap: onAssignmentTap,
            ),
          ),
        ),
      ],
    );
  }
}

final class _SummaryCard extends StatelessWidget {
  final double? average;
  final MentorXThemeColorPalette palette;

  const _SummaryCard({required this.average, required this.palette});

  @override
  Widget build(BuildContext context) {
    final display = average == null ? '--' : average!.toStringAsFixed(1);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: palette.brandTertiary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.grading_rounded, color: palette.brandPrimary),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Overall Average',
                style: TextStyle(color: palette.textSecondary),
              ),
              Text(
                '$display%',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _CourseFilter extends StatelessWidget {
  final String? selectedCourseId;
  final List<CourseSummaryEntity> courses;
  final ValueChanged<String?> onChanged;

  const _CourseFilter({
    required this.selectedCourseId,
    required this.courses,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCourseId ?? 'all',
      decoration: const InputDecoration(
        labelText: 'Course',
        border: OutlineInputBorder(),
      ),
      items: [
        const DropdownMenuItem(value: 'all', child: Text('All Courses')),
        ...courses.map<DropdownMenuItem<String>>(
          (CourseSummaryEntity course) => DropdownMenuItem<String>(
            value: course.id,
            child: Text(course.title),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}

final class _CourseSectionCard extends StatelessWidget {
  final CourseGradesSection section;
  final VoidCallback onQuizTap;
  final VoidCallback onAssignmentTap;

  const _CourseSectionCard({
    required this.section,
    required this.onQuizTap,
    required this.onAssignmentTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  section.course.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                section.averagePercentage == null
                    ? '--'
                    : '${section.averagePercentage!.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: palette.brandPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...section.quizzes.map(
            (quiz) => _AssessmentTile(
              title: 'Quiz ${quiz.quizId}',
              subtitle: 'Score ${quiz.score}/${quiz.totalMarks}',
              percentage: quiz.percentage,
              icon: Icons.quiz_outlined,
              onTap: onQuizTap,
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
                icon: Icons.assignment_turned_in_outlined,
                onTap: onAssignmentTap,
              );
            },
          ),
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
    final palette = MentorXThemeColorPalette.light;
    final color = _scoreColor(percentage, palette);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Icon(icon, color: palette.textSecondary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: Text(
        percentage == null ? '--' : '${percentage!.toStringAsFixed(1)}%',
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
      onTap: onTap,
    );
  }

  Color _scoreColor(double? percentage, MentorXThemeColorPalette palette) {
    if (percentage == null) {
      return palette.textSecondary;
    }
    if (percentage >= 70) {
      return palette.statusSuccess;
    }
    if (percentage >= 50) {
      return palette.statusWarning;
    }
    return palette.statusDanger;
  }
}
