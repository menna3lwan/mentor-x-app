import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class AssignmentsListPagePage extends StatelessWidget {
  final bool isLoading;
  final List<AssignmentEntity> assignments;
  final String? errorMessage;
  final Future<void> Function() onRefresh;
  final ValueChanged<String> onAssignmentTap;

  const AssignmentsListPagePage({
    super.key,
    required this.isLoading,
    required this.assignments,
    this.errorMessage,
    required this.onRefresh,
    required this.onAssignmentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _BuildHeader(
            title: context.t.assignments.featureTitle,
          ),
          Expanded(
            child: _buildBody(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final t = context.t.assignments;

    if (errorMessage != null) {
      return AppErrorView(
        message: errorMessage!,
        onRetry: onRefresh,
      );
    }

    if (isLoading) {
      return ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
        itemCount: 6,
        separatorBuilder: (_, _) => const Gap(16),
        itemBuilder: (_, _) => const MentorXSkeleton(
          height: 110,
          borderRadius: 28,
        ),
      );
    }

    if (assignments.isEmpty) {
      return AppEmptyView(
        title: t.noAssignments,
        message: t.noAssignmentsDesc,
        icon: Icons.assignment_turned_in_rounded,
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      itemCount: assignments.length,
      separatorBuilder: (_, _) => const Gap(16),
      itemBuilder: (context, index) {
        final assignment = assignments[index];
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: _AssignmentCard(
            assignment: assignment,
            onTap: () => onAssignmentTap(assignment.id),
          ),
        );
      },
    );
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
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
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
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACADEMICS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      title,
                      style: TextStyle(
                        color: context.textPrimaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
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

final class _AssignmentCard extends StatelessWidget {
  final AssignmentEntity assignment;
  final VoidCallback onTap;

  const _AssignmentCard({
    required this.assignment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.assignments;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.brandPrimaryColor.withValues(alpha: 0.2),
                    context.brandPrimaryColor.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Hero(
                tag: 'assignment_icon_${assignment.id}',
                child: Icon(
                  Icons.assignment_rounded,
                  size: 26,
                  color: context.brandPrimaryColor,
                ),
              ),
            ),
            const Gap(18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assignment.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 14,
                        color: context.textTertiaryColor,
                      ),
                      const Gap(6),
                      Text(
                        assignment.deadline != null
                            ? t.dueAt(
                                date: assignment.deadline!.toString().split(
                                  ' ',
                                )[0],
                              )
                            : t.noDeadline,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.textTertiaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.backgroundPrimaryColor.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                color: context.textTertiaryColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
