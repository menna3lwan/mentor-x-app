import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/core.dart';
import '../../portal_data/portal_data.dart';
import '../bloc/children_bloc.dart';

final class LinkedChildrenManagementPage extends StatelessWidget {
  const LinkedChildrenManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildrenBloc, ChildrenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Linked Children')),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    if (state.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          state.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final child = state.children[index];
                          return _ChildTile(
                            child: child,
                            isActive: child.id == state.activeChildId,
                            onSelect: () {
                              context.read<ChildrenBloc>().add(
                                ChildrenSwitched(child.id),
                              );
                            },
                            onUnlink: () {
                              context.read<ChildrenBloc>().add(
                                ChildrenUnlinked(child.id),
                              );
                            },
                          );
                        },
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemCount: state.children.length,
                      ),
                    ),
                  ],
                ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: FilledButton.icon(
              onPressed: () => const AddChildLinkPageRoute().push(context),
              icon: const Icon(Icons.person_add_alt_1),
              label: const Text('Add Child'),
            ),
          ),
        );
      },
    );
  }
}

final class _ChildTile extends StatelessWidget {
  final ParentChild child;
  final bool isActive;
  final VoidCallback onSelect;
  final VoidCallback onUnlink;

  const _ChildTile({
    required this.child,
    required this.isActive,
    required this.onSelect,
    required this.onUnlink,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yyyy').format(child.linkedAt);
    return ListTile(
      onTap: onSelect,
      leading: CircleAvatar(
        child: Text(
          child.fullName.trim().isEmpty ? '?' : child.fullName.trim()[0],
        ),
      ),
      title: Text(child.fullName),
      subtitle: Text(
        '${child.gradeName} • ${child.tenantName}\n${child.studentCode} • Linked $date',
      ),
      isThreeLine: true,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isActive)
            const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(Icons.check_circle, color: Colors.green),
            ),
          IconButton(
            icon: const Icon(Icons.link_off, color: Colors.red),
            onPressed: onUnlink,
            tooltip: 'Unlink',
          ),
        ],
      ),
    );
  }
}
