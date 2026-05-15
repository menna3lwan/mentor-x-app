import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

import '../child_management_card/child_management_card_widget.dart';

/// The body of the linked-children management screen — drives one of:
/// loading skeleton, error retry, empty-with-action, or a list of cards.
class LinkedChildrenListWidget extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final VoidCallback onLinkChildPressed;
  final Future<void> Function() onRefresh;
  final List<ParentChildEntity> children;
  final ValueChanged<ParentChildEntity>? onUnlinkPressed;
  final String? unlinkingChildId;

  final String emptyTitle;
  final String emptyMessage;
  final String emptyActionLabel;
  final String unlinkLabel;
  final String Function(String id) studentIdLabelBuilder;
  final String Function(String grade) gradeLabelBuilder;
  final String Function(String center) centerLabelBuilder;

  const LinkedChildrenListWidget({
    super.key,
    required this.isLoading,
    required this.errorMessage,
    required this.onRetry,
    required this.onLinkChildPressed,
    required this.onRefresh,
    required this.children,
    required this.onUnlinkPressed,
    required this.unlinkingChildId,
    required this.emptyTitle,
    required this.emptyMessage,
    required this.emptyActionLabel,
    required this.unlinkLabel,
    required this.studentIdLabelBuilder,
    required this.gradeLabelBuilder,
    required this.centerLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && children.isEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 4,
        itemBuilder: (_, __) => const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: MentorXSkeleton(height: 96, borderRadius: 24),
        ),
      );
    }

    if (errorMessage != null && children.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: AppErrorView(
          message: errorMessage!,
          onRetry: onRetry,
        ),
      );
    }

    if (children.isEmpty) {
      return AppEmptyView(
        title: emptyTitle,
        message: emptyMessage,
        icon: Icons.people_outline_rounded,
        onAction: onLinkChildPressed,
        actionLabel: emptyActionLabel,
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.all(20),
        itemCount: children.length,
        itemBuilder: (context, index) {
          final child = children[index];
          return FadeInUp(
            duration: const Duration(milliseconds: 400),
            delay: Duration(milliseconds: 50 * index),
            child: ChildManagementCardWidget(
              child: child,
              unlinkingInProgress: unlinkingChildId == child.id,
              onUnlinkPressed: onUnlinkPressed == null
                  ? null
                  : () => onUnlinkPressed!(child),
              studentIdLabel: studentIdLabelBuilder(
                child.studentCode ?? child.id,
              ),
              gradeLabel: (child.gradeName?.isNotEmpty ?? false)
                  ? gradeLabelBuilder(child.gradeName!)
                  : null,
              centerLabel: (child.centerName?.isNotEmpty ?? false)
                  ? centerLabelBuilder(child.centerName!)
                  : null,
              unlinkLabel: unlinkLabel,
            ),
          );
        },
      ),
    );
  }
}
