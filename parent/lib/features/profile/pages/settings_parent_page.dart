import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../bloc/profile_bloc.dart';

final class SettingsParentPage extends StatelessWidget {
  final ProfileStatus status;
  final Map<String, dynamic> settingsData;
  final ValueChanged<bool> onNotificationToggle;
  final VoidCallback onThemeTap;
  final VoidCallback onLanguageTap;
  final VoidCallback onHelpCenterTap;
  final VoidCallback onAboutTap;

  const SettingsParentPage({
    super.key,
    required this.status,
    required this.settingsData,
    required this.onNotificationToggle,
    required this.onThemeTap,
    required this.onLanguageTap,
    required this.onHelpCenterTap,
    required this.onAboutTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppDashboardScaffold(
      title: 'Settings',
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (status == ProfileStatus.loading) {
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
              value: settingsData['notificationsEnabled'] as bool? ?? true,
              onChanged: onNotificationToggle,
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
              value: settingsData['themeMode'].toString().toUpperCase(),
              onTap: onThemeTap,
            ),
            _SettingsNavigationTile(
              icon: Icons.language_rounded,
              label: 'App Language',
              value: settingsData['languageCode'].toString().toUpperCase(),
              onTap: onLanguageTap,
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
              onTap: onHelpCenterTap,
            ),
            _SettingsNavigationTile(
              icon: Icons.info_outline_rounded,
              label: 'About MentorX',
              value: 'Version 1.0.0',
              onTap: onAboutTap,
            ),
          ],
        ),
      ],
    );
  }
}

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
