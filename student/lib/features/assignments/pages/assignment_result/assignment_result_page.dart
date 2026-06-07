import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import '../../../../core/widgets/score_circle.dart';
import 'bloc/assignment_result_bloc.dart';

final class AssignmentResultPage extends StatelessWidget {
  final AssignmentResultState state;
  final VoidCallback onRetry;

  const AssignmentResultPage({
    super.key,
    required this.state,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.assignments;

    if (state.loadingState == LoadingState.loading) {
      return Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: Column(
          children: [
            const MentorXSkeleton(height: 120, borderRadius: 32),
            const Gap(40),
            Center(
              child: MentorXSkeleton(
                width: 180,
                height: 180,
                borderRadius: 90,
              ),
            ),
            const Gap(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: MentorXSkeleton(height: 200, borderRadius: 32),
            ),
          ],
        ),
      );
    }

    if (state.errorMessage != null) {
      return Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: AppErrorView(
          message: state.errorMessage!,
          onRetry: onRetry,
        ),
      );
    }

    final submission = state.submission;
    if (submission == null) {
      return Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: AppEmptyView(
          title: t.notFound,
          message: 'Try again later',
        ),
      );
    }

    final score = submission.score ?? 0;
    final total = submission.totalMarks ?? 0;
    final feedback =
        submission.feedback ?? 'No feedback from instructor yet.';
    final performanceText = _getPerformanceText(context, score, total);

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _BuildHeader(title: t.result),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
              child: Column(
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: context.backgroundSecondaryColor.withValues(
                          alpha: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: context.borderPrimaryColor.withValues(
                            alpha: 0.1,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ScoreCircle(
                            score: score,
                            total: total,
                            radius: 90,
                            lineWidth: 14,
                          ),
                          const Gap(32),
                          Text(
                            '$score / $total ${t.points}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: context.brandPrimaryColor,
                              letterSpacing: -1.0,
                            ),
                          ),
                          const Gap(16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: context.statusSuccessColor.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: context.statusSuccessColor
                                    .withValues(
                                      alpha: 0.1,
                                    ),
                              ),
                            ),
                            child: Text(
                              performanceText.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: context.statusSuccessColor,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(32),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 200),
                    child: _InfoSection(
                      title: t.instructorFeedback,
                      icon: Icons.chat_bubble_rounded,
                      child: Text(
                        feedback,
                        style: TextStyle(
                          fontSize: 15,
                          color: context.textSecondaryColor,
                          height: 1.7,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const Gap(56),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 400),
                    child: MentorXButton(
                      onPressed: () => Navigator.pop(context),
                      label: t.commonBack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPerformanceText(BuildContext context, int score, int total) {
    if (total == 0) return 'N/A';
    final percentage = (score / total) * 100;
    final t = context.t.assignments;
    if (percentage >= 90) return t.excellent;
    if (percentage >= 80) return t.veryGood;
    if (percentage >= 65) return t.good;
    if (percentage >= 50) return t.passed;
    return t.failed;
  }
}

final class _BuildHeader extends StatelessWidget {
  final String title;
  const _BuildHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(
                alpha: 0.6,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: MentorXIconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icons.arrow_back_ios_new_rounded,
              color: context.textPrimaryColor,
              size: MentorXIconButtonSize.small,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          const Gap(48),
        ],
      ),
    );
  }
}

final class _InfoSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _InfoSection({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: context.brandPrimaryColor,
                  size: 24,
                ),
              ),
              const Gap(16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const Gap(24),
          child,
        ],
      ),
    );
  }
}
