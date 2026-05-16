import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

final class ProfileViewPage extends StatelessWidget {
  final AppSessionState session;
  final String? avatarUrl;

  const ProfileViewPage({
    super.key,
    required this.session,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _ProfileHeader(session: session, avatarUrl: avatarUrl),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: _QuickStats(
                      session: session,
                    ),
                  ),
                  const Gap(28),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 100),
                    child: _PersonalDetails(
                      session: session,
                    ),
                  ),
                  const Gap(28),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 200),
                    child: const _ActionButtons(),
                  ),
                  const Gap(100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.session,
    this.avatarUrl,
  });
  final AppSessionState session;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      pinned: true,
      stretch: true,
      backgroundColor: context.backgroundPrimaryColor,
      elevation: 0,
      leading: Center(
        child: MentorXIconButton(
          onPressed: () => context.pop(),
          icon: Icons.arrow_back_ios_new_rounded,
          variant: MentorXIconButtonVariant.outline,
          size: MentorXIconButtonSize.small,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
        ],
        background: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    context.brandPrimaryColor.withValues(alpha: 0.15),
                    context.backgroundPrimaryColor,
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(60),
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              context.brandPrimaryColor,
                              context.brandSecondaryColor,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: context.brandPrimaryColor.withValues(
                                alpha: 0.4,
                              ),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Hero(
                          tag: 'profile_avatar',
                          child: CircleAvatar(
                            radius: 64,
                            backgroundColor: context.backgroundPrimaryColor,
                            child: AppDynamicImage(
                              avatarUrl ?? '',
                              width: 128,
                              height: 128,
                              borderRadius: BorderRadius.circular(64),
                              errorWidget: Icon(
                                Icons.person_rounded,
                                size: 68,
                                color: context.brandPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      PressableBox(
                        onPress: () {}, // TODO: Change avatar
                        style: Style(
                          $box.padding.all(10),
                          $box.shape.circle(),
                          $box.color(context.brandSecondaryColor),
                          $box.border.all.color(context.backgroundPrimaryColor),
                          $box.border.all.width(3),
                          $box.shadows(context.softShadow),
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(24),
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  child: Text(
                    context.isArabic
                        ? session.studentNameAr
                        : session.studentName,
                    style: context.titleH1Style.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.0,
                    ),
                  ),
                ),
                const Gap(12),
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 100),
                  child: MentorXGlassCard(
                    style: Style(
                      $box.padding.horizontal(16),
                      $box.padding.vertical(8),
                      $box.borderRadius(16),
                    ),
                    child: Text(
                      session.studentCode,
                      style: context.bodySecondaryStyle.copyWith(
                        color: context.textSecondaryColor,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final class _QuickStats extends StatelessWidget {
  const _QuickStats({
    required this.session,
  });
  final AppSessionState session;

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile;

    return MentorXGlassCard(
      style: Style(
        $box.padding.all(28),
        $box.borderRadius(32),
      ),
      child: SizedBox(
        height: 110,
        child: Row(
          children: [
            Expanded(
              child: _StatItem(
                label: t.wallet,
                value: session.walletBalance.toStringAsFixed(0),
                unit: context.t.core.currency,
                icon: Icons.account_balance_wallet_rounded,
                color: context.brandPrimaryColor,
              ),
            ),
            VerticalDivider(
              color: context.borderPrimaryColor.withValues(alpha: 0.1),
              thickness: 1.5,
              indent: 10,
              endIndent: 10,
            ),
            Expanded(
              child: _StatItem(
                label: t.attendance,
                value: session.attendancePercent.toStringAsFixed(0),
                unit: '%',
                icon: Icons.how_to_reg_rounded,
                color: context.brandSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.2),
                color.withValues(alpha: 0.05),
              ],
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const Gap(14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: context.titleH2Style.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -0.8,
              ),
            ),
            const Gap(4),
            Text(
              unit,
              style: context.bodySecondaryStyle.copyWith(
                fontWeight: FontWeight.w800,
                color: context.textTertiaryColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const Gap(6),
        Text(
          label.toUpperCase(),
          style: context.bodySecondaryStyle.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: context.textSecondaryColor,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}

final class _PersonalDetails extends StatelessWidget {
  const _PersonalDetails({
    required this.session,
  });
  final AppSessionState session;

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6, bottom: 14),
          child: Text(
            t.personalData.toUpperCase(),
            style: context.bodySecondaryStyle.copyWith(
              fontWeight: FontWeight.w900,
              color: context.brandPrimaryColor,
              letterSpacing: 2.0,
              fontSize: 11,
            ),
          ),
        ),
        MentorXGlassCard(
          style: Style(
            $box.borderRadius(32),
            $box.padding.all(0),
          ),
          child: Column(
            children: [
              _DetailRow(
                icon: Icons.person_outline_rounded,
                label: t.name,
                value: context.isArabic
                    ? session.studentNameAr
                    : session.studentName,
              ),
              _DetailRow(
                icon: Icons.phone_android_rounded,
                label: t.phone,
                value: session.phone,
              ),
              _DetailRow(
                icon: Icons.school_outlined,
                label: t.grade,
                value: context.isArabic ? session.gradeAr : session.grade,
              ),
              _DetailRow(
                icon: Icons.business_rounded,
                label: t.center,
                value: context.isArabic ? session.centerAr : session.center,
              ),
              _DetailRow(
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

final class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const _DetailRow({
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
                  color: context.borderPrimaryColor.withValues(alpha: 0.08),
                ),
              ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.backgroundPrimaryColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 22, color: context.brandPrimaryColor),
          ),
          const Gap(18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: context.bodySecondaryStyle.copyWith(
                    fontSize: 10,
                    color: context.textTertiaryColor,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
                const Gap(4),
                Text(
                  value,
                  style: context.bodyPrimaryStyle.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.3,
                    fontSize: 15,
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

final class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    final t = context.t.profile;

    return Column(
      children: [
        _ActionTile(
          label: t.digitalId,
          icon: Icons.badge_rounded,
          onTap: () => context.push('/student-card'),
          color: context.brandPrimaryColor,
        ),
        const Gap(14),
        _ActionTile(
          label: t.editProfile,
          icon: Icons.edit_rounded,
          onTap: () => context.push('/edit-profile'),
          color: context.brandSecondaryColor,
        ),
        const Gap(14),
        _ActionTile(
          label: t.settingsTitle,
          icon: Icons.settings_rounded,
          onTap: () => context.push('/settings'),
          color: context.textSecondaryColor,
        ),
        const Gap(32),
        MentorXButton(
          onPressed: () => _showLogoutDialog(context),
          label: t.logoutSetting,
          color: context.statusDangerColor,
          size: MentorXButtonSize.large,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        titlePadding: const EdgeInsets.fromLTRB(28, 28, 28, 12),
        contentPadding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
        actionsPadding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
        title: Text(
          t.logoutConfirmTitle,
          style: context.titleH2Style.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.8,
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
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    t.cancel,
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
      ),
    );
  }
}

final class _ActionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _ActionTile({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onTap,
      child: MentorXGlassCard(
        style: Style(
          $box.padding.all(18),
          $box.borderRadius(24),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.2),
                    color.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 22, color: color),
            ),
            const Gap(18),
            Expanded(
              child: Text(
                label,
                style: context.bodyPrimaryStyle.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: context.backgroundPrimaryColor.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                color: context.textTertiaryColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
