import 'dart:ui';
import 'package:flutter/material.dart';
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    children: [
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        child: _QuickStats(
                          session: session,
                          t: t,
                        ),
                      ),
                      const Gap(24),
    
                      // Verification Section removed
                      const Gap(0),
    
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 200),
                        child: _PersonalDetails(
                          session: session,
                          isAr: isAr,
                          t: t,
                        ),
                      ),
                      const Gap(24),
    
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 300),
                        child: _ActionButtons(t: t),
                      ),
                      const Gap(40),
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
      expandedHeight: 280,
      pinned: true,
      backgroundColor: context.backgroundPrimaryColor,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
                border: Border(
                  bottom: BorderSide(
                    color: context.borderPrimaryColor.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: const SizedBox.expand(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(60),
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.brandPrimaryColor.withValues(alpha: 0.2),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 54,
                      backgroundColor: context.backgroundPrimaryColor,
                      child: Icon(
                        Icons.person_rounded,
                        size: 60,
                        color: context.brandPrimaryColor,
                      ),
                    ),
                  ),
                ),
                const Gap(16),
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    isAr
                        ? session.studentNameAr
                        : session.studentName,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const Gap(8),
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 100),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: context.brandPrimaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: context.brandPrimaryColor.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      session.studentCode,
                      style: TextStyle(
                        color: context.brandPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: t['wallet'],
                value: session.walletBalance.toStringAsFixed(0),
                unit: 'EGP',
                icon: Icons.account_balance_wallet_rounded,
              ),
            ),
            const Gap(16),
            Expanded(
              child: _StatCard(
                label: t['attendance'],
                value: session.attendancePercent.toStringAsFixed(0),
                unit: '%',
                icon: Icons.how_to_reg_rounded,
                color: context.brandSecondaryColor,
              ),
            ),
          ],
        ),
        const Gap(16),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Streak',
                value: '12',
                unit: 'Days',
                icon: Icons.local_fire_department_rounded,
                color: Colors.orangeAccent,
              ),
            ),
            const Gap(16),
            Expanded(
              child: _StatCard(
                label: 'Badges',
                value: '5',
                unit: 'Unlocked',
                icon: Icons.emoji_events_rounded,
                color: Colors.amberAccent,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

final class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final Color? color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final mainColor = color ?? context.brandPrimaryColor;
    return Container(
      padding: const EdgeInsets.all(20),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: mainColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: mainColor, size: 20),
              ),
              const Gap(16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -1,
                    ),
                  ),
                  const Gap(4),
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
              const Gap(4),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: context.textSecondaryColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
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
        _SectionTitle(
          title: t['personalData'],
        ),
        const Gap(12),
        Container(
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
              child: Column(
                children: [
                  _DetailRow(
                    icon: Icons.person_outline_rounded,
                    label: t['name'],
                    value: isAr
                        ? session.studentNameAr
                        : session.studentName,
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
          ),
        ),
      ],
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
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: context.brandSecondaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const Gap(10),
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: context.textPrimaryColor,
            letterSpacing: 0.5,
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
      padding: const EdgeInsets.all(18),
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.backgroundPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: context.textTertiaryColor),
          ),
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
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Gap(2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.textPrimaryColor,
                    fontWeight: FontWeight.w900,
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
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                label: t['editProfile'],
                icon: Icons.edit_rounded,
                onTap: () => context.push('/edit-profile'),
              ),
            ),
            const Gap(12),
            Expanded(
              child: _ActionButton(
                label: t['settingsTitle'],
                icon: Icons.settings_rounded,
                onTap: () => context.push('/settings'),
              ),
            ),
          ],
        ),
        const Gap(12),
        _ActionButton(
          label: t['logoutSetting'],
          icon: Icons.logout_rounded,
          onTap: () => _showLogoutDialog(context),
          isDanger: true,
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final t = context.t.student;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.backgroundSecondaryColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          t['logoutConfirmTitle'],
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: context.textPrimaryColor,
            letterSpacing: -0.5,
          ),
        ),
        content: Text(
          t['logoutConfirmDesc'],
          style: TextStyle(
            color: context.textSecondaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              t['cancel'],
              style: TextStyle(
                color: context.textTertiaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Gap(8),
          SizedBox(
            width: 120,
            child: MentorXButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.read<AppAuthenticationCubit>().logout();
                context.go('/login');
              },
              label: t['logoutSetting'],
            ),
          ),
        ],
      ),
    );
  }
}

final class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDanger;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        decoration: BoxDecoration(
          color: isDanger
              ? context.statusDangerColor.withValues(alpha: 0.1)
              : context.backgroundSecondaryColor.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDanger
                ? context.statusDangerColor.withValues(alpha: 0.3)
                : context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isDanger
                      ? context.statusDangerColor
                      : context.brandPrimaryColor,
                ),
                const Gap(8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: isDanger
                        ? context.statusDangerColor
                        : context.textPrimaryColor,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),
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
