import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/routing/app_routes.dart';
import '../bloc/children_bloc.dart';
import '../widgets/widgets.dart';

/// Lists the parent's currently linked children and lets them link new ones
/// or unlink existing ones.
class LinkedChildrenManagementPage extends StatelessWidget {
  const LinkedChildrenManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildrenBloc(
        childrenRepository: context.read<ParentChildrenRepository>(),
      )..add(const ChildrenStarted()),
      child: const _LinkedChildrenView(),
    );
  }
}

class _LinkedChildrenView extends StatelessWidget {
  const _LinkedChildrenView();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<ChildrenBloc, ChildrenPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case ChildUnlinkSucceededPresentationEvent():
            MentorXUI.showToast(message: t.children.unlinkSuccess);
          case ChildLinkSucceededPresentationEvent():
            MentorXUI.showToast(message: t.children.linkSuccess);
          case ChildrenFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
        }
      },
      child: AppDashboardScaffold(
        title: t.children.title,
        body: const LinkedChildrenListWrapper(),
        floatingActionButton: _LinkChildFab(label: t.children.linkNewChild),
      ),
    );
  }
}

class _LinkChildFab extends StatelessWidget {
  final String label;
  const _LinkChildFab({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.brandPrimaryColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: () => const AddChildLinkRoute().go(context),
        backgroundColor: context.brandPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: const Icon(Icons.person_add_rounded),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}
