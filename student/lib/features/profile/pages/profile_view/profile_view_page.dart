import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

final class ProfileViewPage extends StatelessWidget {
  final AppSessionState session;
  final String? avatarUrl;
  final VoidCallback onLogout;
  final bool isLoading;

  const ProfileViewPage({
    super.key,
    required this.session,
    required this.onLogout,
    this.isLoading = false,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AppDashboardScaffold(
      title: context.t.profile.title,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  context.brandPrimaryColor,
                ),
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
              child: Column(
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: _ProfileSummary(
                      session: session,
                      avatarUrl: avatarUrl,
                    ),
                  ),
                  const Gap(32),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 100),
                    child: _InfoSection(session: session),
                  ),
                  const Gap(32),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 200),
                    child: _ActionsSection(onLogout: onLogout),
                  ),
                ],
              ),
            ),
    );
  }
}

final class _ProfileSummary extends StatelessWidget {
  final AppSessionState session;
  final String? avatarUrl;

  const _ProfileSummary({
    required this.session,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.brandPrimaryColor.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 54,
                backgroundColor: context.backgroundSecondaryColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(54),
                  child: AppDynamicImage(
                    avatarUrl ?? '',
                    width: 108,
                    height: 108,
                    fit: BoxFit.cover,
                    errorWidget: Icon(
                      Icons.person_rounded,
                      size: 50,
                      color: context.textTertiaryColor,
                    ),
                  ),
                ),
              ),
            ),
            PressableBox(
              onPress: () {}, // TODO: Edit avatar
              style: Style(
                $box.padding.all(8),
                $box.shape.circle(),
                $box.color(context.brandPrimaryColor),
                $box.border.all.color(context.backgroundPrimaryColor),
                $box.border.all.width(2.5),
                $box.shadows(context.softShadow),
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                size: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const Gap(16),
        Text(
          context.isArabic ? session.studentNameAr : session.studentName,
          style: context.titleH2Style.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 24,
            letterSpacing: -0.5,
          ),
        ),
        const Gap(4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: context.brandPrimaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            session.studentCode,
            style: TextStyle(
              color: context.brandPrimaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 12,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}

final class _InfoSection extends StatelessWidget {
  final AppSessionState session;

  const _InfoSection({required this.session});

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: t.personalData),
        const Gap(12),
        Container(
          decoration: BoxDecoration(
            color: context.backgroundPrimaryColor,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.1),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              _InfoTile(
                icon: Icons.phone_android_rounded,
                label: t.phone,
                value: session.phone,
              ),
              _InfoTile(
                icon: Icons.school_rounded,
                label: t.grade,
                value: context.isArabic ? session.gradeAr : session.grade,
              ),
              _InfoTile(
                icon: Icons.business_rounded,
                label: t.center,
                value: context.isArabic ? session.centerAr : session.center,
              ),
              _InfoTile(
                icon: Icons.account_balance_rounded,
                label: t.school,
                value: context.isArabic ? session.schoolAr : session.school,
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: context.borderPrimaryColor.withValues(alpha: 0.05),
                ),
              ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: context.textTertiaryColor),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: context.textTertiaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Gap(2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: context.textPrimaryColor,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
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

final class _ActionsSection extends StatelessWidget {
  final VoidCallback onLogout;

  const _ActionsSection({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: t.settingsTitle),
        const Gap(12),
        _ActionTile(
          icon: Icons.badge_rounded,
          title: t.digitalId,
          onTap: () => context.push('/student-card'),
        ),
        const Gap(12),
        _ActionTile(
          icon: Icons.edit_rounded,
          title: t.editProfile,
          onTap: () => context.push('/edit-profile'),
        ),
        const Gap(12),
        _ActionTile(
          icon: Icons.settings_rounded,
          title: t.settingsTitle,
          onTap: () => context.push('/settings'),
        ),
        const Gap(12),
        _ActionTile(
          icon: Icons.logout_rounded,
          title: t.logoutSetting,
          onTap: () => _showLogoutDialog(context),
          isDestructive: true,
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final t = context.t.profile;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.backgroundPrimaryColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
        contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        title: Text(
          t.logoutConfirmTitle,
          style: context.titleH3Style.copyWith(fontWeight: FontWeight.w900),
        ),
        content: Text(
          t.logoutConfirmDesc,
          style: context.bodyPrimaryStyle.copyWith(
            color: context.textSecondaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    t.cancel,
                    style: TextStyle(
                      color: context.textTertiaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: MentorXButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    onLogout();
                  },
                  label: t.logoutSetting,
                  color: context.statusDangerColor,
                  size: MentorXButtonSize.medium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? context.statusDangerColor : context.textPrimaryColor;
    final iconBgColor = isDestructive 
        ? context.statusDangerColor.withValues(alpha: 0.1) 
        : context.backgroundSecondaryColor;

    return PressableBox(
      onPress: onTap,
      style: Style(
        $box.padding.all(16),
        $box.borderRadius(24),
        $box.color(context.backgroundPrimaryColor),
        $box.border.all.color(context.borderPrimaryColor.withValues(alpha: 0.08)),
        $box.border.all.width(1.5),
        $on.hover($box.color(context.backgroundSecondaryColor.withValues(alpha: 0.5))),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const Gap(16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: color,
                letterSpacing: -0.3,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            size: 20,
            color: isDestructive ? color.withValues(alpha: 0.5) : context.textTertiaryColor,
          ),
        ],
      ),
    );
  }
}

final class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          color: context.brandPrimaryColor,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
