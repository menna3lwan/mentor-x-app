import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';
import '../bloc/courses_bloc.dart';

class AcademicMonitorPage extends StatelessWidget {
  final String childId;

  const AcademicMonitorPage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final t = Translations.of(context).parent;

    return BlocProvider(
      create: (context) => CoursesBloc(
        courseRepository: context.read<ParentCourseRepository>(),
        gradeRepository: context.read<ParentGradeRepository>(),
      )..add(CoursesStarted(childId)),
      child: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: palette.backgroundSecondary,
            body: Column(
              children: [
                // Premium Header
                _BuildHeader(palette: palette, childId: childId, title: t.academicMonitor),
                
                Expanded(
                  child: _buildBody(context, state, palette, t),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, CoursesState state, MentorXThemeColorPalette palette, TranslationsParentEn t) {
    if (state.status == CoursesStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == CoursesStatus.failure) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline_rounded, size: 64, color: palette.statusDanger),
              const SizedBox(height: 16),
              Text(
                state.errorMessage ?? t.unableToLoad,
                textAlign: TextAlign.center,
                style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 120,
                child: MentorXButton(
                  onPressed: () => context.read<CoursesBloc>().add(CoursesStarted(childId)),
                  text: t.retry,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state.courses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_stories_rounded, size: 64, color: palette.textTertiary.withOpacity(0.2)),
            const SizedBox(height: 16),
            Text(
              t.noData,
              style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: palette.brandPrimary,
      onRefresh: () async {
        context.read<CoursesBloc>().add(CoursesRefreshRequested(childId));
      },
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (state.gradeSummary != null) ...[
            _BuildGradeSummaryCard(summary: state.gradeSummary!, palette: palette),
            const SizedBox(height: 32),
          ],
          
          Text(
            t.enrolledCourses,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: palette.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          
          ...state.courses.map(
            (course) => _CourseCard(course: course, palette: palette),
          ),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final String childId;
  final String title;
  const _BuildHeader({required this.palette, required this.childId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 24,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [palette.brandPrimary, palette.brandPrimary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () => context.read<CoursesBloc>().add(CoursesRefreshRequested(childId)),
            icon: const Icon(Icons.refresh_rounded, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }
}

class _BuildGradeSummaryCard extends StatelessWidget {
  final ParentGradeSummaryEntity summary;
  final MentorXThemeColorPalette palette;

  const _BuildGradeSummaryCard({required this.summary, required this.palette});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            t.overallAverage,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: palette.textTertiary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                summary.overallAverage.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: palette.brandPrimary,
                ),
              ),
              Text(
                '%',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: palette.brandPrimary.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: summary.distribution.entries.map((entry) => _DistributionItem(
              grade: entry.key,
              count: entry.value,
              palette: palette,
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _DistributionItem extends StatelessWidget {
  final String grade;
  final int count;
  final MentorXThemeColorPalette palette;

  const _DistributionItem({required this.grade, required this.count, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          grade,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: palette.brandPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '$count Courses',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: palette.textTertiary,
          ),
        ),
      ],
    );
  }
}

class _CourseCard extends StatelessWidget {
  final CourseEntity course;
  final MentorXThemeColorPalette palette;

  const _CourseCard({required this.course, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: palette.brandPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.book_rounded, color: palette.brandPrimary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: palette.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Sessions: ${course.totalSessions}',
                  style: TextStyle(
                    fontSize: 12,
                    color: palette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: palette.textTertiary, size: 14),
        ],
      ),
    );
  }
}
