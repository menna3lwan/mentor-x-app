import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../bloc/profile_bloc.dart';

class SettingsParentPage extends StatelessWidget {
  const SettingsParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileStarted()),
      child: Scaffold(
        backgroundColor: palette.backgroundPrimary,
        body: const SettingsParentView(),
      ),
    );
  }
}

class SettingsParentView extends StatelessWidget {
  const SettingsParentView({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(palette.brandPrimary),
            ),
          );
        }

        return Column(
          children: [
            // Header
            _BuildHeader(palette: palette),
            
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: _SettingsSection(
                      title: 'App Configuration',
                      children: [
                        _SettingsToggleTile(
                          icon: Icons.notifications_active_rounded,
                          label: 'Push Notifications',
                          value: state.settingsData['notificationsEnabled'] as bool? ?? true,
                          onChanged: (val) {
                            // context.read<ProfileBloc>().add(ProfileSettingsUpdated({'notificationsEnabled': val}));
                          },
                          palette: palette,
                        ),
                      ],
                    ),
                  ),
                  const Gap(24),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 100),
                    child: _SettingsSection(
                      title: 'Preferences',
                      children: [
                        _SettingsNavigationTile(
                          icon: Icons.palette_rounded,
                          label: 'Theme Mode',
                          value: state.settingsData['themeMode'].toString().toUpperCase(),
                          onTap: () {},
                          palette: palette,
                        ),
                        _SettingsNavigationTile(
                          icon: Icons.language_rounded,
                          label: 'App Language',
                          value: state.settingsData['languageCode'].toString().toUpperCase(),
                          onTap: () {},
                          palette: palette,
                        ),
                      ],
                    ),
                  ),
                  const Gap(24),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                    child: _SettingsSection(
                      title: 'Support',
                      children: [
                        _SettingsNavigationTile(
                          icon: Icons.help_outline_rounded,
                          label: 'Help Center',
                          value: 'FAQs & Support',
                          onTap: () {},
                          palette: palette,
                        ),
                        _SettingsNavigationTile(
                          icon: Icons.info_outline_rounded,
                          label: 'About MentorX',
                          value: 'Version 1.0.0',
                          onTap: () {},
                          palette: palette,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
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
        left: 12,
        right: 12,
      ),
      color: palette.backgroundPrimary,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: palette.textPrimary, size: 20),
          ),
          const Expanded(
            child: Text(
              'Settings',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const Gap(48), // Spacer for balance
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: palette.textTertiary,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
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
  final MentorXThemeColorPalette palette;

  const _SettingsToggleTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: palette.brandPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: palette.brandPrimary, size: 20),
          ),
          const Gap(16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: palette.textPrimary,
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: palette.brandPrimary,
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
  final MentorXThemeColorPalette palette;

  const _SettingsNavigationTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: palette.brandPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: palette.brandPrimary, size: 20),
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
                      color: palette.textPrimary,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: palette.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: palette.textTertiary, size: 14),
          ],
        ),
      ),
    );
  }
}
