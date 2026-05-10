import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/assignment_detail_page_bloc.dart';

final class AssignmentDetailPage extends StatelessWidget {
  const AssignmentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return BlocBuilder<AssignmentDetailPageBloc, AssignmentDetailPageState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.errorMessage != null) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInDown(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: context.statusDangerColor.withValues(
                            alpha: 0.1,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.error_outline_rounded,
                          size: 64,
                          color: context.statusDangerColor,
                        ),
                      ),
                    ),
                    const Gap(32),
                    FadeInUp(
                      child: Text(
                        state.errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: context.textPrimaryColor,
                        ),
                      ),
                    ),
                    const Gap(48),
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
            backgroundColor: context.backgroundPrimaryColor,
            body: Center(
              child: Text(
                t['assignmentNotFound'] ?? 'Assignment not found',
                style: TextStyle(color: context.textPrimaryColor),
              ),
            ),
          );
        }

        final submission = state.submission;
        final isSubmitted = submission != null;
        final deadlineStr = assignment.deadline != null
            ? DateFormat.yMMMd(
                context.languageCode,
              ).format(assignment.deadline!)
            : t['noDeadline'] ?? 'No deadline';

        return Scaffold(
          backgroundColor: context.backgroundPrimaryColor,
          body: Stack(
            children: [
              const _BackgroundDecorations(),
              Column(
                children: [
                  _BuildHeader(t: t),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
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
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: context.textPrimaryColor,
                                    letterSpacing: -1.0,
                                  ),
                                ),
                                const Gap(12),
                                if ((assignment.description ?? '').isNotEmpty)
                                  Text(
                                    assignment.description!,
                                    style: TextStyle(
                                      fontSize: 15,
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
                            duration: const Duration(milliseconds: 500),
                            delay: const Duration(milliseconds: 100),
                            child: Row(
                              children: [
                                _DetailChip(
                                  icon: Icons.timer_rounded,
                                  label: t['deadline']!,
                                  value: deadlineStr,
                                ),
                                const Gap(16),
                                _DetailChip(
                                  icon: Icons.stars_rounded,
                                  label: t['maxScore']!,
                                  value: '${assignment.maxScore} ${t['points']!}',
                                ),
                              ],
                            ),
                          ),
                          const Gap(48),
                          FadeInUp(
                            duration: const Duration(milliseconds: 500),
                            delay: const Duration(milliseconds: 200),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: context.brandPrimaryColor,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    const Gap(16),
                                    Text(
                                      t['instructionsLabel']!,
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
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(32),
                                  decoration: BoxDecoration(
                                    color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
                                    borderRadius: BorderRadius.circular(32),
                                    border: Border.all(
                                      color: context.borderPrimaryColor.withValues(
                                        alpha: 0.1,
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(32),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                      child: Text(
                                        (assignment.instructions ?? '').isNotEmpty
                                            ? assignment.instructions!
                                            : t['assignmentInstructions']!,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: context.textSecondaryColor,
                                          height: 1.8,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (assignment.fileUrl != null) ...[
                            const Gap(32),
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 300),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(
                                    color: context.brandPrimaryColor.withValues(
                                      alpha: 0.1,
                                    ),
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: context.brandPrimaryColor.withValues(
                                                alpha: 0.1,
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
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  t['assignmentFile']!,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w900,
                                                    color: context.textPrimaryColor,
                                                  ),
                                                ),
                                                const Gap(4),
                                                Text(
                                                  assignment.fileName ?? 'attachment.pdf',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: context.textTertiaryColor,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.download_rounded,
                                              color: context.brandPrimaryColor,
                                              size: 24,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          const Gap(56),
                          FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 400),
                            child: isSubmitted
                                ? StatusBadge(
                                    message:
                                        t['alreadySubmitted'] ??
                                        'You have already submitted this assignment',
                                    status: StatusBadgeType.success,
                                  )
                                : MentorXButton(
                                    onPressed: () => context.push(
                                      '/assignment-submit/${assignment.id}',
                                    ),
                                    label: t['submitAssignment']!,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final dynamic t;

  const _BuildHeader({required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.paddingOf(context).top + 16,
        24,
        24,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: context.textPrimaryColor,
                  size: 20,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    t['assignmentDetail']!,
                    style: TextStyle(
                      color: context.textPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              const Gap(48),
            ],
          ),
        ),
      ),
    );
  }
}

final class _DetailChip extends StatelessWidget {
  const _DetailChip({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(24),
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
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.brandPrimaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, size: 20, color: context.brandPrimaryColor),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: context.textTertiaryColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            color: context.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
