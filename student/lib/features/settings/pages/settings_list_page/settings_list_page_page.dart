import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';

class SettingsListPage extends StatelessWidget {
  const SettingsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final isAr = context.isArabic;
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Container(
            decoration: BoxDecoration(
              color: palette.backgroundPrimary,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: palette.textPrimary,
              centerTitle: true,
              title: Text(
                t['settingsTitle'] ?? 'Settings',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.5),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Language Section ─────────────────────────────────────────
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: _SectionTitle(title: t['language'] ?? 'Language', palette: palette),
            ),
            const Gap(12),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 100),
              child: _LanguageSwitcher(isAr: isAr, palette: palette),
            ),
            const Gap(32),

            // ── Account Section ─────────────────────────────────────────
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              child: _SectionTitle(title: t['account'] ?? 'Account', palette: palette),
            ),
            const Gap(12),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 300),
              child: _SettingsGroup(
                palette: palette,
                children: [
                  _SettingsItem(
                    icon: Icons.lock_person_rounded,
                    label: t['changePasswordSetting'] ?? 'Change Password',
                    color: palette.brandPrimary,
                    onTap: () => context.push('/change-password'),
                    palette: palette,
                  ),
                  _SettingsItem(
                    icon: Icons.devices_other_rounded,
                    label: t['deviceManagement'] ?? 'Device Management',
                    color: palette.brandSecondary,
                    onTap: () => context.push('/device-management'),
                    palette: palette,
                  ),
                ],
              ),
            ),
            const Gap(32),

            // ── Communication Section ───────────────────────────────────
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 400),
              child: _SectionTitle(title: t['communication'] ?? 'Communication', palette: palette),
            ),
            const Gap(12),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 500),
              child: _SettingsGroup(
                palette: palette,
                children: [
                  _SettingsItem(
                    icon: Icons.notifications_active_rounded,
                    label: t['notificationsSetting'] ?? 'Notifications',
                    color: Colors.orange,
                    onTap: () => context.push('/notifications'),
                    palette: palette,
                  ),
                  _SettingsItem(
                    icon: Icons.groups_rounded,
                    label: t['whatsappGroups'] ?? 'WhatsApp Groups',
                    color: const Color(0xFF25D366),
                    onTap: () => context.push('/whatsapp-groups'),
                    palette: palette,
                  ),
                ],
              ),
            ),
            const Gap(32),

            // ── Help & Info Section ─────────────────────────────────────
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 600),
              child: _SectionTitle(title: t['helpAndInfo'] ?? 'Help & Info', palette: palette),
            ),
            const Gap(12),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 700),
              child: _SettingsGroup(
                palette: palette,
                children: [
                  _SettingsItem(
                    icon: Icons.info_rounded,
                    label: t['aboutSetting'] ?? 'About',
                    color: palette.textTertiary,
                    onTap: () => context.push('/about'),
                    palette: palette,
                    isLast: true,
                  ),
                ],
              ),
            ),
            const Gap(40),

            // ── Logout ──────────────────────────────────────────────────
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 800),
              child: _SettingsGroup(
                palette: palette,
                children: [
                  _SettingsItem(
                    icon: Icons.logout_rounded,
                    label: t['logoutSetting'] ?? 'Log Out',
                    color: palette.statusDanger,
                    onTap: () => _showLogoutDialog(context, t),
                    palette: palette,
                    isLast: true,
                    isDestructive: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, Map<String, String> t) {
    showDialog(
      context: context,
      builder: (ctx) => ZoomIn(
        duration: const Duration(milliseconds: 300),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          backgroundColor: MentorXThemeColorPalette.light.backgroundPrimary,
          title: Text(
            t['logoutConfirmTitle'] ?? 'Log Out',
            style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5),
          ),
          content: Text(
            t['logoutConfirmDesc'] ?? 'Are you sure you want to log out?',
            style: TextStyle(color: MentorXThemeColorPalette.light.textSecondary, fontWeight: FontWeight.w500),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                t['cancel'] ?? 'Cancel',
                style: TextStyle(color: MentorXThemeColorPalette.light.textTertiary, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              width: 130,
              child: MentorXButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  context.read<AppAuthenticationCubit>().logout();
                  context.go('/login');
                },
                label: t['logoutSetting'] ?? 'Log Out',
                color: MentorXThemeColorPalette.light.statusDanger,
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final MentorXThemeColorPalette palette;
  const _SectionTitle({required this.title, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.7)],
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const Gap(12),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: palette.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}

class _LanguageSwitcher extends StatelessWidget {
  const _LanguageSwitcher({required this.isAr, required this.palette});
  final bool isAr;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _LanguageOption(
              label: 'العربية',
              isSelected: isAr,
              onTap: () {
                if (!isAr) LocaleSettings.setLocaleRaw('ar');
              },
              palette: palette,
            ),
          ),
          const Gap(10),
          Expanded(
            child: _LanguageOption(
              label: 'English',
              isSelected: !isAr,
              onTap: () {
                if (isAr) LocaleSettings.setLocaleRaw('en');
              },
              palette: palette,
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.palette,
  });
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: palette.brandPrimary.withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: isSelected ? palette.textForeground : palette.textTertiary,
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<_SettingsItem> children;
  final MentorXThemeColorPalette palette;
  const _SettingsGroup({required this.children, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    required this.palette,
    this.isLast = false,
    this.isDestructive = false,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final MentorXThemeColorPalette palette;
  final bool isLast;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            border: isLast ? null : Border(bottom: BorderSide(color: palette.backgroundSecondary, width: 1.5)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, size: 22, color: color),
              ),
              const Gap(16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: isDestructive ? palette.statusDanger : palette.textPrimary,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: palette.textTertiary.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
