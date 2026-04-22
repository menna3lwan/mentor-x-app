import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/children_bloc.dart';

class LinkedChildrenManagementPage extends StatelessWidget {
  const LinkedChildrenManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildrenBloc(
        childrenRepository: context.read<ParentChildrenRepository>(),
      )..add(ChildrenStarted()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Linked Children')),
        body: const LinkedChildrenListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to Add Child Link page
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class LinkedChildrenListView extends StatelessWidget {
  const LinkedChildrenListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildrenBloc, ChildrenState>(
      builder: (context, state) {
        if (state.status == ChildrenStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.children.isEmpty) {
          return const Center(child: Text('No children linked.'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: state.children.length,
          separatorBuilder: (_, _) => const Divider(),
          itemBuilder: (context, index) {
            final child = state.children[index];
            return ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(child.name),
              subtitle: Text('ID: ${child.id}'),
              trailing: const Icon(Icons.chevron_right),
            );
          },
        );
      },
    );
  }
}
