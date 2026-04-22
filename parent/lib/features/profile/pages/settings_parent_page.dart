import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';

class SettingsParentPage extends StatelessWidget {
  const SettingsParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileStarted()),
      child: Scaffold(
        appBar: AppBar(title: const Text('App Settings')),
        body: const SettingsParentView(),
      ),
    );
  }
}

class SettingsParentView extends StatelessWidget {
  const SettingsParentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: const Text('Push Notifications'),
              value: state.settingsData['notificationsEnabled'] as bool,
              onChanged: (val) {
                // context.read<ProfileBloc>().add(ProfileSettingsUpdated({'notificationsEnabled': val}));
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Theme Mode'),
              subtitle: Text(state.settingsData['themeMode'].toString().toUpperCase()),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Open theme picker
              },
            ),
            ListTile(
              title: const Text('App Language'),
              subtitle: Text(state.settingsData['languageCode'].toString().toUpperCase()),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Open language picker
              },
            ),
          ],
        );
      },
    );
  }
}
