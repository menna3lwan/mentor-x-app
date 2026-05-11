import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';

final class SettingsListPage extends StatelessWidget {
  const SettingsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isAr = context.isArabic;
    final t = context.t.student;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                collapsedHeight: 80,
                pinned: true,
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        t['settingsTitle'] ?? 'Settings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: context.textPrimaryColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          color: context.backgroundSecondaryColor.withValues(
                            alpha: 0.45,
                          ),
                          border: Border(
                            bottom: BorderSide(
                              color: context.borderPrimaryColor.withValues(
                                alpha: 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // ── Language Section ─────────────────────────────────────────
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: _SectionTitle(
                        title: t['language'] ?? 'Language',
                      ),
                    ),
                    const Gap(12),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 100),
                      child: _LanguageSwitcher(isAr: isAr),
                    ),
                    const Gap(32),

                    // ── Account Section ─────────────────────────────────────────
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 200),
                      child: _SectionTitle(
                        title: t['account'] ?? 'Account',
                      ),
                    ),
                    const Gap(12),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 300),
                      child: _SettingsGroup(
                        children: [
                          _SettingsItem(
                            icon: Icons.lock_person_rounded,
                            label: t['changePasswordSetting'] ??
                                'Change Password',
                            color: context.brandPrimaryColor,
                            onTap: () => context.push('/change-password'),
                          ),
                          _SettingsItem(
                            icon: Icons.devices_other_rounded,
                            label: t['deviceManagement'] ?? 'Device Management',
                            color: context.brandSecondaryColor,
                            onTap: () => context.push('/device-management'),
                          ),
                        ],
                      ),
                    ),
                    const Gap(32),

                    // ── Communication Section ───────────────────────────────────
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 400),
                      child: _SectionTitle(
                        title: t['communication'] ?? 'Communication',
                      ),
                    ),
                    const Gap(12),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 500),
                      child: _SettingsGroup(
                        children: [
                          _SettingsItem(
                            icon: Icons.notifications_active_rounded,
                            label: t['notificationsSetting'] ?? 'Notifications',
                            color: Colors.orange,
                            onTap: () => context.push('/notifications'),
                          ),
                          _SettingsItem(
                            icon: Icons.groups_rounded,
                            label: t['whatsappGroups'] ?? 'WhatsApp Groups',
                            color: const Color(0xFF25D366),
                            onTap: () => context.push('/whatsapp-groups'),
                          ),
                        ],
                      ),
                    ),
                    const Gap(32),

                    // ── Help & Info Section ─────────────────────────────────────
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 600),
                      child: _SectionTitle(
                        title: t['helpAndInfo'] ?? 'Help & Info',
                      ),
                    ),
                    const Gap(12),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 700),
                      child: _SettingsGroup(
                        children: [
                          _SettingsItem(
                            icon: Icons.info_rounded,
                            label: t['aboutSetting'] ?? 'About',
                            color: context.textTertiaryColor,
                            onTap: () => context.push('/about'),
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
                        children: [
                          _SettingsItem(
                            icon: Icons.logout_rounded,
                            label: t['logoutSetting'] ?? 'Log Out',
                            color: context.statusDangerColor,
                            onTap: () => _showLogoutDialog(context, t),
                            isLast: true,
                            isDestructive: true,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, dynamic t) {
    showDialog(
      context: context,
      builder: (ctx) => ZoomIn(
        duration: const Duration(milliseconds: 300),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: context.backgroundSecondaryColor,
          title: Text(
            t['logoutConfirmTitle'] ?? 'Log Out',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
              color: context.textPrimaryColor,
            ),
          ),
          content: Text(
            t['logoutConfirmDesc'] ?? 'Are you sure you want to log out?',
            style: TextStyle(
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                t['cancel'] ?? 'Cancel',
                style: TextStyle(
                  color: context.textTertiaryColor,
                  fontWeight: FontWeight.w800,
                ),
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
                color: context.statusDangerColor,
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        ),
      ),
    );
  }
}

final class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

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
              colors: [
                context.brandPrimaryColor,
                context.brandPrimaryColor.withValues(alpha: 0.7),
              ],
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
            color: context.textPrimaryColor,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}

final class _LanguageSwitcher extends StatelessWidget {
  const _LanguageSwitcher({required this.isAr});
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
              const Gap(10),
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
      ),
    );
  }
}

final class _LanguageOption extends StatelessWidget {
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    context.brandPrimaryColor,
                    context.brandPrimaryColor.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.brandPrimaryColor.withValues(alpha: 0.25),
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
              color: isSelected
                  ? context.textForegroundColor
                  : context.textTertiaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

final class _SettingsGroup extends StatelessWidget {
  final List<_SettingsItem> children;
  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}

final class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.isLast = false,
    this.isDestructive = false,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isLast;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: context.borderPrimaryColor.withValues(alpha: 0.05),
                    width: 1,
                  ),
                ),
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
                  color: isDestructive
                      ? context.statusDangerColor
                      : context.textPrimaryColor,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: context.textTertiaryColor.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
      ),
    );
  }
}
