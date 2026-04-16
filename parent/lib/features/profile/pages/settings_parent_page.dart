import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../bloc/profile_bloc.dart';

final class SettingsParentPage extends StatelessWidget {
  const SettingsParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) =>
          previous.saveSuccessTick != current.saveSuccessTick,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Settings saved successfully.')),
        );
      },
      builder: (context, state) {
        final settings = state.settings;
        if (settings == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Parent Settings')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              DropdownButtonFormField<String>(
                value: settings.languageCode,
                decoration: const InputDecoration(labelText: 'Language'),
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'ar', child: Text('Arabic')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    context.read<ProfileBloc>().add(
                      SettingsLanguageChanged(value),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: settings.themeMode,
                decoration: const InputDecoration(labelText: 'Theme'),
                items: const [
                  DropdownMenuItem(value: 'system', child: Text('System')),
                  DropdownMenuItem(value: 'light', child: Text('Light')),
                  DropdownMenuItem(value: 'dark', child: Text('Dark')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    context.read<ProfileBloc>().add(
                      SettingsThemeChanged(value),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                value: settings.pushNotificationsEnabled,
                title: const Text('Push Notifications'),
                onChanged: (value) {
                  context.read<ProfileBloc>().add(
                    SettingsPushToggleChanged(value),
                  );
                },
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: state.isSaving
                    ? null
                    : () {
                        context.read<ProfileBloc>().add(const SettingsSaved());
                      },
                child: state.isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save Settings'),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () => const LoginPageRoute().go(context),
                child: const Text('Logout'),
              ),
            ],
          ),
        );
      },
    );
  }
}
