import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../bloc/children_bloc.dart';
import 'linked_children_list_widget.dart';

class LinkedChildrenListWrapper extends StatelessWidget {
  const LinkedChildrenListWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<ChildrenBloc, ChildrenState>(
      buildWhen: (prev, curr) =>
          prev.childrenSection != curr.childrenSection ||
          prev.unlinkingChildId != curr.unlinkingChildId,
      builder: (context, state) {
        return LinkedChildrenListWidget(
          isLoading: state.childrenSection.isLoading ||
              state.childrenSection.isInitial,
          errorMessage: state.childrenSection.isFailure
              ? state.childrenSection.errorMessage ?? t.unableToLoad
              : null,
          onRetry: () =>
              context.read<ChildrenBloc>().add(const ChildrenStarted()),
          onLinkChildPressed: () => const AddChildLinkRoute().go(context),
          onRefresh: () async {
            context
                .read<ChildrenBloc>()
                .add(const ChildrenRefreshRequested());
          },
          children: state.children,
          unlinkingChildId: state.unlinkingChildId,
          onUnlinkPressed: (child) =>
              _confirmUnlink(context, child, t),
          emptyTitle: t.home.noChildrenTitle,
          emptyMessage: t.home.noChildrenHint,
          emptyActionLabel: t.home.linkChild,
          unlinkLabel: t.children.unlink,
          studentIdLabelBuilder: (id) => t.children.studentIdLabel(id: id),
          gradeLabelBuilder: (grade) => t.children.gradeLabel(grade: grade),
          centerLabelBuilder: (center) =>
              t.children.centerLabel(center: center),
        );
      },
    );
  }

  Future<void> _confirmUnlink(
    BuildContext context,
    ParentChildEntity child,
    TranslationsParentEn t,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: dialogContext.backgroundSecondaryColor,
          title: Text(t.children.unlinkConfirmTitle),
          content: Text(
            t.children.unlinkConfirmMessage(
              name: child.name.isEmpty ? '—' : child.name,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(t.children.cancel),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: dialogContext.statusDangerColor,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(t.children.unlink),
            ),
          ],
        );
      },
    );
    if (confirmed == true && context.mounted) {
      context.read<ChildrenBloc>().add(ChildUnlinkRequested(child.id));
    }
  }
}
