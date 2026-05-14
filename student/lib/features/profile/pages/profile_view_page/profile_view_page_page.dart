import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

final class ProfileViewPage extends StatelessWidget {
  const ProfileViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final session = context.watch<AppSessionCubit>().state;
    final isAr = context.isArabic;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _ProfileHeader(session: session, isAr: isAr),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    children: [
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: _QuickStats(
                          session: session,
                          t: t,
                        ),
                      ),
                      const Gap(28),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 100),
                        child: _PersonalDetails(
                          session: session,
                          isAr: isAr,
                          t: t,
                        ),
                      ),
                      const Gap(28),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 200),
                        child: _ActionButtons(t: t),
                      ),
                      const Gap(100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.session,
    required this.isAr,
  });
  final AppSessionState session;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      pinned: true,
      stretch: true,
      backgroundColor: context.backgroundPrimaryColor,
      elevation: 0,
      systemOverlayStyle: Theme.of(context).brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
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
                    context.brandPrimaryColor.withValues(alpha: 0.2),
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
                              color: context.brandPrimaryColor
                                  .withValues(alpha: 0.4),
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
                            child: Icon(
                              Icons.person_rounded,
                              size: 68,
                              color: context.brandPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.brandSecondaryColor,
                              context.brandSecondaryColor.withValues(alpha: 0.8),
                            ],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.backgroundPrimaryColor,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                            ),
                          ],
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
                    isAr ? session.studentNameAr : session.studentName,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -1.0,
                      height: 1.1,
                    ),
                  ),
                ),
                const Gap(12),
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 100),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: context.backgroundSecondaryColor
                              .withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: context.borderPrimaryColor
                                .withValues(alpha: 0.1),
                          ),
                        ),
                        child: Text(
                          session.studentCode,
                          style: TextStyle(
                            color: context.textSecondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
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
    required this.t,
  });
  final AppSessionState session;
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _StatItem(
                label: t['wallet'],
                value: session.walletBalance.toStringAsFixed(0),
                unit: 'EGP',
                icon: Icons.account_balance_wallet_rounded,
                color: context.brandPrimaryColor,
              ),
            ),
            VerticalDivider(
              color: context.borderPrimaryColor.withValues(alpha: 0.08),
              thickness: 1.5,
              indent: 10,
              endIndent: 10,
            ),
            Expanded(
              child: _StatItem(
                label: t['attendance'],
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
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: context.textPrimaryColor,
                letterSpacing: -0.8,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              unit,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: context.textTertiaryColor,
              ),
            ),
          ],
        ),
        const Gap(6),
        Text(
          label.toUpperCase(),
          style: TextStyle(
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
    required this.isAr,
    required this.t,
  });
  final AppSessionState session;
  final bool isAr;
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6, bottom: 14),
          child: Text(
            t['personalData'].toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: context.brandPrimaryColor,
              letterSpacing: 2.0,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              _DetailRow(
                icon: Icons.person_outline_rounded,
                label: t['name'],
                value: isAr ? session.studentNameAr : session.studentName,
              ),
              _DetailRow(
                icon: Icons.phone_android_rounded,
                label: t['phone'],
                value: session.phone,
              ),
              _DetailRow(
                icon: Icons.school_outlined,
                label: t['grade'],
                value: isAr ? session.gradeAr : session.grade,
              ),
              _DetailRow(
                icon: Icons.business_rounded,
                label: t['center'],
                value: isAr ? session.centerAr : session.center,
              ),
              _DetailRow(
                icon: Icons.account_balance_rounded,
                label: t['school'],
                value: isAr ? session.schoolAr : session.school,
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
                  style: TextStyle(
                    fontSize: 10,
                    color: context.textTertiaryColor,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
                const Gap(4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: context.textPrimaryColor,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.3,
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
  final dynamic t;
  const _ActionButtons({required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ActionTile(
          label: t['studentDigitalId'] ?? 'Digital ID',
          icon: Icons.badge_rounded,
          onTap: () => context.push('/student-card'),
          color: context.brandPrimaryColor,
        ),
        const Gap(14),
        _ActionTile(
          label: t['editProfile'],
          icon: Icons.edit_rounded,
          onTap: () => context.push('/edit-profile'),
          color: context.brandSecondaryColor,
        ),
        const Gap(14),
        _ActionTile(
          label: t['settingsTitle'],
          icon: Icons.settings_rounded,
          onTap: () => context.push('/settings'),
          color: context.textSecondaryColor,
        ),
        const Gap(32),
        MentorXButton(
          onPressed: () => _showLogoutDialog(context),
          label: t['logoutSetting'],
          color: context.statusDangerColor,
          size: MentorXButtonSize.large,
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final t = context.t.student;
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
          t['logoutConfirmTitle'],
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: context.textPrimaryColor,
            fontSize: 22,
            letterSpacing: -0.8,
          ),
        ),
        content: Text(
          t['logoutConfirmDesc'],
          style: TextStyle(
            color: context.textSecondaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15,
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
                    t['cancel'],
                    style: TextStyle(
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
                  label: t['logoutSetting'],
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.3,
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
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 350,
          ),
        ),
        Positioned(
          bottom: -50,
          left: -100,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
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
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: const SizedBox.expand(),
      ),
    );
  }
}
