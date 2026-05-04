import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

class ProfileViewPage extends StatelessWidget {
  const ProfileViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final session = context.watch<AppSessionCubit>().state;
    final isAr = context.isArabic;
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _ProfileHeader(session: session, isAr: isAr, palette: palette),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: _QuickStats(session: session, t: t, palette: palette),
                  ),
                  const Gap(24),
                  
                  // Verification Section
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 100),
                    child: _VerificationCard(t: t, palette: palette),
                  ),
                  const Gap(24),

                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                    child: _PersonalDetails(session: session, isAr: isAr, t: t, palette: palette),
                  ),
                  const Gap(24),

                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 300),
                    child: _ActionButtons(t: t, palette: palette),
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.session, required this.isAr, required this.palette});
  final AppSessionState session;
  final bool isAr;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: palette.brandPrimary,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.85)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(40),
                    // Avatar with glow
                    FadeInDown(
                      duration: const Duration(milliseconds: 600),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person_rounded, size: 56, color: palette.brandPrimary),
                        ),
                      ),
                    ),
                    const Gap(16),
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        isAr ? session.studentNameAr : session.studentName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const Gap(8),
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 100),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                        child: Text(
                          session.studentCode,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickStats extends StatelessWidget {
  const _QuickStats({required this.session, required this.t, required this.palette});
  final AppSessionState session;
  final Map<String, String> t;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: t['wallet'] ?? 'Wallet',
            value: session.walletBalance.toStringAsFixed(0),
            unit: 'EGP',
            icon: Icons.account_balance_wallet_rounded,
            palette: palette,
          ),
        ),
        const Gap(16),
        Expanded(
          child: _StatCard(
            label: t['attendance'] ?? 'Attendance',
            value: session.attendancePercent.toStringAsFixed(0),
            unit: '%',
            icon: Icons.how_to_reg_rounded,
            palette: palette,
            color: palette.brandSecondary,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final MentorXThemeColorPalette palette;
  final Color? color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.palette,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final mainColor = color ?? palette.brandPrimary;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
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
                  color: palette.textPrimary,
                  letterSpacing: -1,
                ),
              ),
              const Gap(4),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: palette.textTertiary,
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
              color: palette.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerificationCard extends StatelessWidget {
  final dynamic t;
  final MentorXThemeColorPalette palette;
  const _VerificationCard({required this.t, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push('/verify-identity'),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: palette.brandPrimary.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: palette.brandPrimary.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: palette.brandPrimary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.verified_user_rounded, color: palette.brandPrimary, size: 28),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t['identityVerification'] ?? 'Identity Verification',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: palette.textPrimary,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      t['verifyNowDesc'] ?? 'Verify your ID to unlock all features.',
                      style: TextStyle(
                        fontSize: 12,
                        color: palette.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Icon(Icons.chevron_right_rounded, color: palette.brandPrimary),
            ],
          ),
        ),
      ),
    );
  }
}

class _PersonalDetails extends StatelessWidget {
  const _PersonalDetails({
    required this.session,
    required this.isAr,
    required this.t,
    required this.palette,
  });
  final AppSessionState session;
  final bool isAr;
  final dynamic t;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: t['personalData'] ?? 'Personal Data', palette: palette),
        const Gap(12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _DetailRow(
                icon: Icons.person_outline_rounded,
                label: t['name'] ?? 'Name',
                value: isAr ? session.studentNameAr : session.studentName,
                palette: palette,
              ),
              _DetailRow(
                icon: Icons.phone_android_rounded,
                label: t['phone'] ?? 'Phone',
                value: session.phone,
                palette: palette,
              ),
              _DetailRow(
                icon: Icons.school_outlined,
                label: t['grade'] ?? 'Grade',
                value: isAr ? session.gradeAr : session.grade,
                palette: palette,
              ),
              _DetailRow(
                icon: Icons.business_rounded,
                label: t['center'] ?? 'Center',
                value: isAr ? session.centerAr : session.center,
                palette: palette,
              ),
              _DetailRow(
                icon: Icons.account_balance_rounded,
                label: t['school'] ?? 'School',
                value: isAr ? session.schoolAr : session.school,
                palette: palette,
                isLast: true,
              ),
            ],
          ),
        ),
      ],
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
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: palette.brandSecondary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const Gap(10),
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: palette.textPrimary,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final MentorXThemeColorPalette palette;
  final bool isLast;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.palette,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: palette.backgroundSecondary)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: palette.backgroundSecondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: palette.textTertiary),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 11, color: palette.textTertiary, fontWeight: FontWeight.w700),
                ),
                const Gap(2),
                Text(
                  value,
                  style: TextStyle(fontSize: 14, color: palette.textPrimary, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final dynamic t;
  final MentorXThemeColorPalette palette;
  const _ActionButtons({required this.t, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                label: t['editProfile'] ?? 'Edit Profile',
                icon: Icons.edit_rounded,
                onTap: () => context.push('/edit-profile'),
                palette: palette,
              ),
            ),
            const Gap(12),
            Expanded(
              child: _ActionButton(
                label: t['settingsTitle'] ?? 'Settings',
                icon: Icons.settings_rounded,
                onTap: () => context.push('/settings'),
                palette: palette,
              ),
            ),
          ],
        ),
        const Gap(12),
        _ActionButton(
          label: t['logoutSetting'] ?? 'Log Out',
          icon: Icons.logout_rounded,
          onTap: () => _showLogoutDialog(context),
          palette: palette,
          isDanger: true,
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(t['logoutConfirmTitle'] ?? 'Log Out', style: const TextStyle(fontWeight: FontWeight.w900)),
        content: Text(t['logoutConfirmDesc'] ?? 'Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t['cancel'] ?? 'Cancel', style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 120,
            child: MentorXButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.read<AppAuthenticationCubit>().logout();
                context.go('/login');
              },
              text: t['logoutSetting'] ?? 'Log Out',
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final MentorXThemeColorPalette palette;
  final bool isDanger;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.palette,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isDanger ? palette.statusDanger.withValues(alpha: 0.1) : palette.brandPrimary.withValues(alpha: 0.1)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: isDanger ? palette.statusDanger : palette.brandPrimary),
              const Gap(8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: isDanger ? palette.statusDanger : palette.brandPrimary,
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
