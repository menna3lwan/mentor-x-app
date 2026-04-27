import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';
import '../bloc/children_bloc.dart';

class LinkedChildrenManagementPage extends StatelessWidget {
  const LinkedChildrenManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return BlocProvider(
      create: (context) => ChildrenBloc(
        childrenRepository: context.read<ParentChildrenRepository>(),
      )..add(ChildrenStarted()),
      child: Scaffold(
        backgroundColor: palette.backgroundSecondary,
        body: Column(
          children: [
            // Premium Header
            _BuildHeader(palette: palette),
            
            const Expanded(
              child: LinkedChildrenListView(),
            ),
          ],
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: palette.brandPrimary.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: FloatingActionButton.extended(
            onPressed: () => const AddChildLinkRoute().go(context),
            backgroundColor: palette.brandPrimary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            icon: const Icon(Icons.person_add_rounded),
            label: const Text('Link New Child', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ),
      ),
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  const _BuildHeader({required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 24,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [palette.brandPrimary, palette.brandPrimary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          ),
          const Expanded(
            child: Text(
              'Linked Children',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 48), // Spacer
        ],
      ),
    );
  }
}

class LinkedChildrenListView extends StatelessWidget {
  const LinkedChildrenListView({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return BlocBuilder<ChildrenBloc, ChildrenState>(
      builder: (context, state) {
        if (state.status == ChildrenStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.children.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_outline_rounded, size: 64, color: palette.textTertiary.withOpacity(0.2)),
                const SizedBox(height: 16),
                Text(
                  'No children linked yet',
                  style: TextStyle(
                    color: palette.textSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: state.children.length,
          itemBuilder: (context, index) {
            final child = state.children[index];
            return _ChildManagementCard(child: child, palette: palette);
          },
        );
      },
    );
  }
}

class _ChildManagementCard extends StatelessWidget {
  final ParentChildEntity child;
  final MentorXThemeColorPalette palette;

  const _ChildManagementCard({required this.child, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: palette.brandPrimary.withOpacity(0.2), width: 2),
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: palette.backgroundSecondary,
              backgroundImage: child.profileImageUrl != null ? NetworkImage(child.profileImageUrl!) : null,
              child: child.profileImageUrl == null 
                  ? Icon(Icons.person_rounded, color: palette.brandPrimary, size: 32)
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
                    color: palette.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Student ID: ${child.id}',
                  style: TextStyle(
                    fontSize: 12,
                    color: palette.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_outlined, color: palette.textTertiary, size: 20),
          ),
        ],
      ),
    );
  }
}
