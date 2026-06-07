import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';
import '../bloc/children_bloc.dart';

final class LinkedChildrenManagementPage extends StatelessWidget {
  final ChildrenStatus status;
  final List<ParentChildEntity> children;

  const LinkedChildrenManagementPage({
    super.key,
    required this.status,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return AppDashboardScaffold(
      title: 'Linked Children',
      body: LinkedChildrenListView(
        status: status,
        children: children,
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
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
          label: const Text('Link New Child', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}

class LinkedChildrenListView extends StatelessWidget {
  final ChildrenStatus status;
  final List<ParentChildEntity> children;

  const LinkedChildrenListView({
    super.key,
    required this.status,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    if (status == ChildrenStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (children.isEmpty) {
      return AppEmptyView(
        title: 'No Children Linked',
        message: 'You haven\'t linked any children to your account yet.',
        icon: Icons.people_outline_rounded,
        onAction: () => const AddChildLinkRoute().go(context),
        actionLabel: 'Link Child',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: children.length,
      itemBuilder: (context, index) {
        final child = children[index];
        return _ChildManagementCard(child: child);
      },
    );
  }
}

class _ChildManagementCard extends StatelessWidget {
  final ParentChildEntity child;

  const _ChildManagementCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.textTertiaryColor.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: context.brandPrimaryColor.withValues(alpha: 0.2),
                  width: 2),
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: context.backgroundSecondaryColor,
              backgroundImage: child.profileImageUrl != null
                  ? NetworkImage(child.profileImageUrl!)
                  : null,
              child: child.profileImageUrl == null
                  ? Icon(Icons.person_rounded,
                      color: context.brandPrimaryColor, size: 32)
                  : null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  child.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Student ID: ${child.id}',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textTertiaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_outlined,
                color: context.textTertiaryColor, size: 20),
          ),
        ],
      ),
    );
  }
}
