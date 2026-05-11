import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';
import '../bloc/profile_bloc.dart';

class SettingsParentPage extends StatelessWidget {
  const SettingsParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileStarted()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return AppDashboardScaffold(
            title: 'Settings',
            body: const SettingsParentView(),
          );
        },
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
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            _SettingsSection(
              title: 'App Configuration',
              children: [
                _SettingsToggleTile(
                  icon: Icons.notifications_active_rounded,
                  label: 'Push Notifications',
                  value: state.settingsData['notificationsEnabled'] as bool? ?? true,
                  onChanged: (val) {
                    // context.read<ProfileBloc>().add(ProfileSettingsUpdated({'notificationsEnabled': val}));
                  },
                ),
              ],
            ),
            const Gap(24),
            _SettingsSection(
              title: 'Preferences',
              children: [
                _SettingsNavigationTile(
                  icon: Icons.palette_rounded,
                  label: 'Theme Mode',
                  value: state.settingsData['themeMode'].toString().toUpperCase(),
                  onTap: () {},
                ),
                _SettingsNavigationTile(
                  icon: Icons.language_rounded,
                  label: 'App Language',
                  value: state.settingsData['languageCode'].toString().toUpperCase(),
                  onTap: () {},
                ),
              ],
            ),
            const Gap(24),
            _SettingsSection(
              title: 'Support',
              children: [
                _SettingsNavigationTile(
                  icon: Icons.help_outline_rounded,
                  label: 'Help Center',
                  value: 'FAQs & Support',
                  onTap: () {},
                ),
                _SettingsNavigationTile(
                  icon: Icons.info_outline_rounded,
                  label: 'About MentorX',
                  value: 'Version 1.0.0',
                  onTap: () {},
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// Removed _BuildHeader in favor of AppDashboardScaffold

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: context.textTertiaryColor,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: context.textTertiaryColor.withValues(alpha: 0.1)),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _SettingsToggleTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggleTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.brandPrimaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: context.brandPrimaryColor, size: 22),
          ),
          const Gap(16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: context.textPrimaryColor,
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: context.brandPrimaryColor,
          ),
        ],
      ),
    );
  }
}

class _SettingsNavigationTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _SettingsNavigationTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.brandPrimaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: context.brandPrimaryColor, size: 22),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.textTertiaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: context.textTertiaryColor, size: 14),
          ],
        ),
      ),
    );
  }
}
