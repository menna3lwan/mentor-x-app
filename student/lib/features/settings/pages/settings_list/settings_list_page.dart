import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart'
    hide LocaleSettings, TranslationProvider;
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class SettingsListPage extends StatelessWidget {
  const SettingsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isAr = context.isArabic;
    final t = context.t.settings;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _BuildHeader(t: t),
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: _SectionTitle(
                          title: t.language,
                        ),
                      ),
                      const Gap(14),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 100),
                        child: _LanguageSwitcher(isAr: isAr),
                      ),
                      const Gap(32),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 200),
                        child: _SectionTitle(
                          title: t.account,
                        ),
                      ),
                      const Gap(14),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 300),
                        child: _SettingsGroup(
                          children: [
                            _SettingsItem(
                              icon: Icons.lock_person_rounded,
                              label: t.changePasswordSetting,
                              color: context.brandPrimaryColor,
                              onTap: () => context.push('/change-password'),
                            ),
                            _SettingsItem(
                              icon: Icons.badge_rounded,
                              label: t.studentCard,
                              color: Colors.blueAccent,
                              onTap: () => context.push('/student-card'),
                            ),
                            _SettingsItem(
                              icon: Icons.devices_other_rounded,
                              label: t.deviceManagement,
                              color: context.brandSecondaryColor,
                              onTap: () => context.push('/device-management'),
                            ),
                          ],
                        ),
                      ),
                      const Gap(32),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 400),
                        child: _SectionTitle(
                          title: t.communication,
                        ),
                      ),
                      const Gap(14),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 500),
                        child: _SettingsGroup(
                          children: [
                            _SettingsItem(
                              icon: Icons.notifications_active_rounded,
                              label: t.notificationsSetting,
                              color: Colors.orange,
                              onTap: () => context.push('/notifications'),
                            ),
                            _SettingsItem(
                              icon: Icons.groups_rounded,
                              label: t.whatsappGroups,
                              color: const Color(0xFF25D366),
                              onTap: () => context.push('/whatsapp-groups'),
                            ),
                          ],
                        ),
                      ),
                      const Gap(32),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 600),
                        child: _SectionTitle(
                          title: t.helpAndInfo,
                        ),
                      ),
                      const Gap(14),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 700),
                        child: _SettingsGroup(
                          children: [
                            _SettingsItem(
                              icon: Icons.info_rounded,
                              label: t.aboutSetting,
                              color: context.textTertiaryColor,
                              onTap: () => context.push('/about'),
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                      const Gap(48),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 800),
                        child: MentorXButton(
                          onPressed: () => _showLogoutDialog(context, t),
                          label: t.logoutSetting,
                          color: context.statusDangerColor,
                          variant: MentorXButtonVariant.outline,
                          size: MentorXButtonSize.large,
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final dynamic t;

  const _BuildHeader({required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => context.pop(),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.preferencesLabel,
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.title,
                      style: context.titleH1Style.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showLogoutDialog(BuildContext context, dynamic t) {
  showDialog(
    context: context,
    builder: (ctx) => ZoomIn(
      duration: const Duration(milliseconds: 300),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        backgroundColor: context.backgroundPrimaryColor,
        surfaceTintColor: Colors.transparent,
        title: Text(
          t.logoutConfirmTitle,
          style: context.titleH2Style.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        content: Text(
          t.logoutConfirmDesc,
          style: context.bodyPrimaryStyle.copyWith(
            color: context.textSecondaryColor,
            fontWeight: FontWeight.w700,
            height: 1.5,
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    context.t.core.cancel,
                    style: context.bodySecondaryStyle.copyWith(
                      color: context.textTertiaryColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const Gap(16),
              Expanded(
                child: MentorXButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    context.read<AppAuthenticationCubit>().logout();
                    context.go('/login');
                  },
                  label: t.logoutSetting,
                  color: context.statusDangerColor,
                  size: MentorXButtonSize.medium,
                ),
              ),
            ],
          ),
        ],
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      ),
    ),
  );
}

final class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title.toUpperCase(),
        style: context.bodySecondaryStyle.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          color: context.brandPrimaryColor,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}

final class _LanguageSwitcher extends StatelessWidget {
  const _LanguageSwitcher({required this.isAr});
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      style: Style(
        $box.padding.all(6),
        $box.borderRadius(20),
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
            ),
          ),
          const Gap(8),
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
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    context.brandPrimaryColor,
                    context.brandSecondaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected
              ? null
              : context.backgroundPrimaryColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.brandPrimaryColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: context.bodyPrimaryStyle.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 14,
              color: isSelected ? Colors.white : context.textSecondaryColor,
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
    return MentorXGlassCard(
      style: Style(
        $box.borderRadius(28),
        $box.padding.all(0),
      ),
      child: Column(
        children: children,
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
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onTap,
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
                style: context.bodyPrimaryStyle.copyWith(
                  fontWeight: FontWeight.w800,
                  color: context.textPrimaryColor,
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
