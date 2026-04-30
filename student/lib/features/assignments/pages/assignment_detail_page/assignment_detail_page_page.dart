import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/assignment_detail_page_bloc.dart';

class AssignmentDetailPage extends StatelessWidget {
  const AssignmentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;

    return BlocBuilder<AssignmentDetailPageBloc, AssignmentDetailPageState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.errorMessage != null) {
          return Scaffold(
            backgroundColor: palette.backgroundSecondary,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInDown(
                      child: Icon(Icons.error_outline_rounded, size: 64, color: palette.statusDanger.withValues(alpha: 0.5)),
                    ),
                    const Gap(24),
                    FadeInUp(
                      child: Text(
                        state.errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: palette.textSecondary),
                      ),
                    ),
                    const Gap(32),
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: MentorXButton(
                        label: t['commonBack']!,
                        onPressed: () => context.pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final assignment = state.assignment;
        if (assignment == null) {
          return Scaffold(
            backgroundColor: palette.backgroundSecondary,
            body: Center(child: Text(t['assignmentNotFound'] ?? 'Assignment not found')),
          );
        }

        final submission = state.submission;
        final isSubmitted = submission != null;
        final deadlineStr = "${assignment.deadlineAt.day} ${_getMonth(assignment.deadlineAt.month)} ${assignment.deadlineAt.year}";

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
                  t['assignmentDetail']!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assignment.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: palette.textPrimary,
                          letterSpacing: -0.8,
                        ),
                      ),
                      const Gap(8),
                      if ((assignment.description ?? '').isNotEmpty)
                        Text(
                          assignment.description!,
                          style: TextStyle(fontSize: 15, color: palette.textSecondary, height: 1.6, fontWeight: FontWeight.w500),
                        ),
                    ],
                  ),
                ),
                const Gap(32),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 100),
                  child: Row(
                    children: [
                      _DetailChip(
                        icon: Icons.timer_rounded,
                        label: t['deadline']!,
                        value: deadlineStr,
                        palette: palette,
                      ),
                      const Gap(12),
                      _DetailChip(
                        icon: Icons.stars_rounded,
                        label: t['maxScore']!,
                        value: '${assignment.maxScore} ${t['points']!}',
                        palette: palette,
                      ),
                    ],
                  ),
                ),
                const Gap(40),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t['instructionsLabel']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: palette.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const Gap(16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 15, offset: const Offset(0, 8)),
                          ],
                        ),
                        child: Text(
                          (assignment.instructions ?? '').isNotEmpty 
                              ? assignment.instructions! 
                              : t['assignmentInstructions']!,
                          style: TextStyle(
                            fontSize: 15,
                            color: palette.textSecondary,
                            height: 1.8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (assignment.fileUrl != null) ...[
                  const Gap(24),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 300),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: palette.brandPrimary.withValues(alpha: 0.1)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: palette.brandPrimary.withValues(alpha: 0.05),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.picture_as_pdf_rounded, color: palette.brandPrimary, size: 26),
                          ),
                          const Gap(16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t['assignmentFile']!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: palette.textPrimary,
                                  ),
                                ),
                                const Gap(2),
                                Text(
                                  assignment.fileName ?? 'attachment.pdf',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: palette.textTertiary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.download_rounded, color: palette.brandPrimary),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const Gap(48),
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 400),
                  child: isSubmitted
                      ? StatusBadge(
                          message: t['alreadySubmitted'] ?? 'You have already submitted this assignment',
                          status: StatusBadgeType.success,
                        )
                      : MentorXButton(
                          onPressed: () => context.push('/assignment-submit/${assignment.id}'),
                          label: t['submitAssignment']!,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getMonth(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.palette,
  });
  final IconData icon;
  final String label, value;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: palette.brandPrimary),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: palette.textTertiary, letterSpacing: 0.5),
                  ),
                  const Gap(2),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: palette.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
