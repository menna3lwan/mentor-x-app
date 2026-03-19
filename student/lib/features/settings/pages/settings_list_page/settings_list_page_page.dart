import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class SettingsListPage extends StatelessWidget {
  const SettingsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primary,
        title: Text(
          t['settingsTitle'] ?? 'Settings',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Language Section ─────────────────────────────────────────
            _SectionHeader(title: t['language'] ?? 'Language'),
            const SizedBox(height: 8),
            _LanguageSwitcher(isAr: isAr),
            const SizedBox(height: 24),

            // ── Account Section ─────────────────────────────────────────
            _SectionHeader(title: t['account'] ?? 'Account'),
            const SizedBox(height: 8),
            _SettingsCard(
              children: [
                _SettingsItem(
                  icon: Icons.lock_outline_rounded,
                  label: t['changePasswordSetting'] ?? 'Change Password',
                  color: AppColors.primary,
                  onTap: () => context.push('/change-password'),
                ),
                _SettingsItem(
                  icon: Icons.devices_outlined,
                  label: t['deviceManagement'] ?? 'Device Management',
                  color: AppColors.teal,
                  onTap: () => context.push('/device-management'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Communication Section ───────────────────────────────────
            _SectionHeader(title: t['communication'] ?? 'Communication'),
            const SizedBox(height: 8),
            _SettingsCard(
              children: [
                _SettingsItem(
                  icon: Icons.notifications_outlined,
                  label: t['notificationsSetting'] ?? 'Notifications',
                  color: AppColors.accent,
                  onTap: () => context.push('/notifications'),
                ),
                _SettingsItem(
                  icon: Icons.groups_outlined,
                  label: t['whatsappGroups'] ?? 'WhatsApp Groups',
                  color: AppColors.whatsAppGreen,
                  onTap: () => context.push('/whatsapp-groups'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Help & Info Section ─────────────────────────────────────
            _SectionHeader(title: t['helpAndInfo'] ?? 'Help & Info'),
            const SizedBox(height: 8),
            _SettingsCard(
              children: [
                _SettingsItem(
                  icon: Icons.headset_mic_outlined,
                  label: t['supportSetting'] ?? 'Support',
                  color: AppColors.success,
                  onTap: () => context.push('/support'),
                ),
                _SettingsItem(
                  icon: Icons.info_outline_rounded,
                  label: t['aboutSetting'] ?? 'About',
                  color: AppColors.primary,
                  onTap: () => context.push('/about'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Danger Zone ─────────────────────────────────────────────
            _SettingsCard(
              children: [
                _SettingsItem(
                  icon: Icons.logout_rounded,
                  label: t['logoutSetting'] ?? 'Log Out',
                  color: AppColors.red,
                  isDestructive: true,
                  onTap: () => _showLogoutDialog(context, t),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, Map<String, String> t) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          t['logoutConfirmTitle'] ?? 'Log Out',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        content: Text(
          t['logoutConfirmDesc'] ?? 'Are you sure you want to log out?',
          style: const TextStyle(color: AppColors.greyDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              t['cancel'] ?? 'Cancel',
              style: const TextStyle(color: AppColors.greyDark),
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.go('/login');
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(t['logoutSetting'] ?? 'Log Out'),
          ),
        ],
      ),
    );
  }
}

// ── Section Header ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

// ── Language Switcher ─────────────────────────────────────────────────────────

class _LanguageSwitcher extends StatelessWidget {
  const _LanguageSwitcher({required this.isAr});
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Expanded(
              child: _LanguageOption(
                label: 'العربية',
                isSelected: isAr,
                onTap: () {
                  if (!isAr) LocaleSettings.setLocaleRaw('ar');
                },
              ),
            ),
            Expanded(
              child: _LanguageOption(
                label: 'English',
                isSelected: !isAr,
                onTap: () {
                  if (isAr) LocaleSettings.setLocaleRaw('en');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.greyDark,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Settings Card & Item ─────────────────────────────────────────────────────

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<_SettingsItem> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(children.length, (i) {
          return Column(
            children: [
              children[i],
              if (i < children.length - 1)
                Divider(
                  height: 0.8,
                  indent: 56,
                  color: AppColors.greyLight.withValues(alpha: 0.5),
                ),
            ],
          );
        }),
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
    this.isDestructive = false,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDestructive ? AppColors.red : AppColors.primary,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: isDestructive
                    ? AppColors.red.withValues(alpha: 0.5)
                    : AppColors.greyDark.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
