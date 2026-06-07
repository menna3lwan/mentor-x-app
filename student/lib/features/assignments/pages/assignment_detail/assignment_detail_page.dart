import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/assignment_detail_bloc.dart';

final class AssignmentDetailPage extends StatelessWidget {
  const AssignmentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.assignments;

    return Builder(
      builder: (context) {
        final loadingState = context
            .select<AssignmentDetailBloc, LoadingState>(
              (bloc) => bloc.state.loadingState,
            );
        final errorMessage = context.select<AssignmentDetailBloc, String?>(
          (bloc) => bloc.state.errorMessage,
        );
        final assignment = context
            .select<AssignmentDetailBloc, AssignmentEntity?>(
              (bloc) => bloc.state.assignment,
            );
        final submission = context
            .select<AssignmentDetailBloc, AssignmentSubmissionEntity?>(
              (bloc) => bloc.state.submission,
            );

        if (loadingState == LoadingState.loading) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: Column(
              children: [
                const MentorXSkeleton(height: 120, borderRadius: 32),
                const Gap(32),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: MentorXSkeleton(height: 40, borderRadius: 12),
                ),
                const Gap(12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: MentorXSkeleton(height: 60, borderRadius: 12),
                ),
                const Gap(40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: MentorXSkeleton(height: 80, borderRadius: 24),
                      ),
                      Gap(16),
                      Expanded(
                        child: MentorXSkeleton(height: 80, borderRadius: 24),
                      ),
                    ],
                  ),
                ),
                const Gap(48),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: MentorXSkeleton(height: 200, borderRadius: 32),
                  ),
                ),
              ],
            ),
          );
        }

        if (errorMessage != null) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: AppErrorView(
              message: errorMessage,
              onRetry: () {
                final assignmentId = context
                    .read<AssignmentDetailBloc>()
                    .state
                    .assignment
                    ?.id;
                if (assignmentId != null) {
                  context.read<AssignmentDetailBloc>().add(
                    AssignmentDetailLoadEvent(assignmentId: assignmentId),
                  );
                }
              },
            ),
          );
        }

        if (assignment == null) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: AppEmptyView(
              title: t.notFound,
              message: 'Try again later',
            ),
          );
        }

        final isSubmitted = submission != null;
        final deadlineStr = assignment.deadline != null
            ? DateFormat.yMMMd(
                context.languageCode,
              ).format(assignment.deadline!)
            : t.noDeadline;

        return Scaffold(
          backgroundColor: context.backgroundPrimaryColor,
          body: Column(
            children: [
              const _BuildHeader(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<AssignmentDetailBloc>().add(
                      AssignmentDetailLoadEvent(
                        assignmentId: assignment.id,
                      ),
                    );
                  },
                  color: context.brandPrimaryColor,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInDown(
                          duration: const Duration(milliseconds: 600),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                assignment.title,
                                style: context.titleH1Style.copyWith(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -1.2,
                                ),
                              ),
                              const Gap(12),
                              if ((assignment.description ?? '').isNotEmpty)
                                Text(
                                  assignment.description!,
                                  style: context.bodyPrimaryStyle.copyWith(
                                    color: context.textSecondaryColor,
                                    height: 1.6,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const Gap(40),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 100),
                          child: Row(
                            children: [
                              _DetailChip(
                                icon: Icons.timer_rounded,
                                label: t.deadline,
                                value: deadlineStr,
                                color: context.brandSecondaryColor,
                              ),
                              const Gap(16),
                              _DetailChip(
                                icon: Icons.stars_rounded,
                                label: t.maxScore,
                                value: '${assignment.maxScore} ${t.points}',
                                color: Colors.orange,
                              ),
                            ],
                          ),
                        ),
                        const Gap(48),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 200),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          context.brandPrimaryColor,
                                          context.brandSecondaryColor,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const Gap(16),
                                  Text(
                                    t.instructionsLabel,
                                    style: context.titleH3Style.copyWith(
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(24),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(28),
                                decoration: BoxDecoration(
                                  color: context.backgroundSecondaryColor
                                      .withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                    color: context.borderPrimaryColor
                                        .withValues(alpha: 0.1),
                                  ),
                                ),
                                child: Text(
                                  (assignment.instructions ?? '').isNotEmpty
                                      ? assignment.instructions!
                                      : t.instructions,
                                  style: context.bodyPrimaryStyle.copyWith(
                                    color: context.textSecondaryColor,
                                    height: 1.8,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (assignment.fileUrl != null) ...[
                          const Gap(32),
                          FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 300),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: context.backgroundSecondaryColor
                                    .withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(
                                  color: context.borderPrimaryColor.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          context.brandPrimaryColor.withValues(
                                            alpha: 0.2,
                                          ),
                                          context.brandPrimaryColor.withValues(
                                            alpha: 0.05,
                                          ),
                                        ],
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.picture_as_pdf_rounded,
                                      color: context.brandPrimaryColor,
                                      size: 28,
                                    ),
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          t.file,
                                          style: context.bodyPrimaryStyle
                                              .copyWith(
                                                fontWeight: FontWeight.w900,
                                              ),
                                        ),
                                        const Gap(4),
                                        Text(
                                          assignment.fileName ??
                                              'attachment.pdf',
                                          style: context.smallTextStyle
                                              .copyWith(
                                                color:
                                                    context.textTertiaryColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  MentorXIconButton(
                                    onPressed: () {},
                                    icon: Icons.download_rounded,
                                    variant: MentorXIconButtonVariant.outline,
                                    size: MentorXIconButtonSize.medium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        const Gap(56),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 400),
                          child: isSubmitted
                              ? Column(
                                  children: [
                                    StatusBadge(
                                      message:
                                          submission.status ==
                                              SubmissionStatus.graded
                                          ? t.graded
                                          : t.alreadySubmitted,
                                      status: StatusBadgeType.success,
                                    ),
                                    const Gap(24),
                                    if (submission.status ==
                                        SubmissionStatus.graded)
                                      MentorXButton(
                                        onPressed: () => context.push(
                                          '/assignment-result/${assignment.id}',
                                        ),
                                        label: t.viewResult,
                                        variant: MentorXButtonVariant.outline,
                                      ),
                                  ],
                                )
                              : MentorXButton(
                                  onPressed: () => context.push(
                                    '/assignment-submit/${assignment.id}',
                                  ),
                                  label: t.submit,
                                  size: MentorXButtonSize.large,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  const _BuildHeader();

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
                context.t.assignments.detail,
                style: context.titleH3Style.copyWith(
                  fontWeight: FontWeight.w900,
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

final class _DetailChip extends StatelessWidget {
  const _DetailChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
  final IconData icon;
  final String label, value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.2),
                    color.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.smallTextStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: context.textTertiaryColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyPrimaryStyle.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
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
