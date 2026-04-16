import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/core.dart';
import '../bloc/profile_bloc.dart';

final class ParentProfilePage extends StatelessWidget {
  const ParentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final profile = state.profile;
        if (state.isLoading || profile == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Parent Profile')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              CircleAvatar(
                radius: 40,
                child: Text(profile.fullName[0]),
              ),
              const SizedBox(height: 16),
              Text(
                profile.fullName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: const Text('Phone'),
                  subtitle: Text(profile.phone),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Email'),
                  subtitle: Text(profile.email),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Member Since'),
                  subtitle: Text(
                    DateFormat('dd MMM yyyy').format(profile.createdAt),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Linked Relationships',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              ...profile.relationships.entries.map(
                (entry) => ListTile(
                  dense: true,
                  title: Text(entry.key),
                  trailing: Text(entry.value),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => const SettingsParentPageRoute().push(context),
                child: const Text('Open Settings'),
              ),
            ],
          ),
        );
      },
    );
  }
}
