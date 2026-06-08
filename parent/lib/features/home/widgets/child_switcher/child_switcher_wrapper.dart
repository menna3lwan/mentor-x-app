import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../bloc/home_bloc.dart';
import 'child_switcher_widget.dart';

/// Selects the children list + selected id from [HomeBloc] and dispatches
/// switch / add-child events.
class ChildSwitcherWrapper extends StatelessWidget {
  const ChildSwitcherWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) =>
          prev.childrenSection != curr.childrenSection ||
          prev.selectedChild?.id != curr.selectedChild?.id,
      builder: (context, state) {
        if (state.childrenSection.isInitial ||
            (state.childrenSection.isLoading && state.children.isEmpty)) {
          return const _ChildSwitcherSkeleton();
        }
        if (state.children.isEmpty) {
          // Empty state handled by the parent page; nothing to render here.
          return const SizedBox.shrink();
        }

        return ChildSwitcherWidget(
          children: state.children,
          selectedChildId: state.selectedChild?.id,
          onChildSelected: (child) =>
              context.read<HomeBloc>().add(HomeChildSwitched(child)),
          onAddChildPressed: () => const AddChildLinkRoute().go(context),
          addChildLabel: t.home.addChild,
        );
      },
    );
  }
}

class _ChildSwitcherSkeleton extends StatelessWidget {
  const _ChildSwitcherSkeleton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: 4,
        itemBuilder: (_, _) {
          return Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                MentorXSkeleton(width: 72, height: 72, borderRadius: 36),
                SizedBox(height: 12),
                MentorXSkeleton(width: 48, height: 12, borderRadius: 4),
              ],
            ),
          );
        },
      ),
    );
  }
}
