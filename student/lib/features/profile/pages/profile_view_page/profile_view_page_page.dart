import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class ProfileViewPage extends StatelessWidget {
  const ProfileViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final session = context.watch<AppSessionCubit>().state;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _ProfileHeader(session: session, isAr: isAr),
            const SizedBox(height: 20),
            _QuickStats(session: session, t: t),
            const SizedBox(height: 20),
            _PersonalDetails(session: session, isAr: isAr, t: t),
            const SizedBox(height: 20),
            _ActionButtons(t: t),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ── Premium Gradient Header ──────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.session, required this.isAr});
  final AppSessionState session;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 28, bottom: 32, left: 24, right: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight, AppColors.primaryMid],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x400B1D3A),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar with glow ring
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.accent, AppColors.accentLight],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.4),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 38,
              backgroundColor: AppColors.primaryMid,
              child: Icon(Icons.person_rounded, size: 40, color: Colors.white),
            ),
          ),
          const SizedBox(height: 14),
          // Name
          Text(
            isAr ? session.studentNameAr : session.studentName,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          // Student code chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Text(
              session.studentCode,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.9),
                letterSpacing: 0.8,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Quick Stat Chips ─────────────────────────────────────────────────────────

class _QuickStats extends StatelessWidget {
  const _QuickStats({required this.session, required this.t});
  final AppSessionState session;
  final Map<String, String> t;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _StatChip(
              icon: Icons.account_balance_wallet_outlined,
              label: t['wallet'] ?? 'Wallet',
              value: '${session.walletBalance.toStringAsFixed(0)} EGP',
              color: AppColors.accent,
              bgColor: AppColors.accent.withValues(alpha: 0.1),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _StatChip(
              icon: Icons.check_circle_outline,
              label: t['attendance'] ?? 'Attendance',
              value: '${session.attendancePercent.toStringAsFixed(0)}%',
              color: AppColors.success,
              bgColor: AppColors.success.withValues(alpha: 0.1),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _StatChip(
              icon: Icons.school_outlined,
              label: t['average'] ?? 'Average',
              value: '${session.averageScore.toStringAsFixed(1)}%',
              color: AppColors.primary,
              bgColor: AppColors.primary.withValues(alpha: 0.08),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.bgColor,
  });
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ── Personal Details Section ─────────────────────────────────────────────────

class _PersonalDetails extends StatelessWidget {
  const _PersonalDetails({
    required this.session,
    required this.isAr,
    required this.t,
  });
  final AppSessionState session;
  final bool isAr;
  final Map<String, String> t;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                t['personalData'] ?? 'Personal Data',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _DetailRow(
                  icon: Icons.person_outline_rounded,
                  iconColor: AppColors.primary,
                  label: t['name'] ?? 'Name',
                  value: isAr ? session.studentNameAr : session.studentName,
                  isFirst: true,
                ),
                _DetailRow(
                  icon: Icons.phone_outlined,
                  iconColor: AppColors.teal,
                  label: t['phone'] ?? 'Phone',
                  value: session.phone,
                  isLtr: true,
                ),
                _DetailRow(
                  icon: Icons.menu_book_outlined,
                  iconColor: AppColors.accent,
                  label: t['grade'] ?? 'Grade',
                  value: isAr ? session.gradeAr : session.grade,
                ),
                _DetailRow(
                  icon: Icons.location_on_outlined,
                  iconColor: AppColors.success,
                  label: t['center'] ?? 'Center',
                  value: isAr ? session.centerAr : session.center,
                ),
                _DetailRow(
                  icon: Icons.account_balance_outlined,
                  iconColor: AppColors.purple,
                  label: t['school'] ?? 'School',
                  value: isAr ? session.schoolAr : session.school,
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.isLtr = false,
    this.isFirst = false,
    this.isLast = false,
  });
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final bool isLtr;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: AppColors.greyLight.withValues(alpha: 0.6),
                  width: 0.8,
                ),
              ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.greyDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  textDirection: isLtr ? TextDirection.ltr : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Action Buttons ──────────────────────────────────────────────────────────

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.t});
  final Map<String, String> t;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _PremiumButton(
              label: t['editRequest'] ?? 'Edit Profile',
              icon: Icons.edit_outlined,
              onTap: () => context.push('/edit-profile'),
              isPrimary: true,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _PremiumButton(
              label: t['settingsTitle'] ?? 'Settings',
              icon: Icons.settings_outlined,
              onTap: () => context.push('/settings'),
              isPrimary: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumButton extends StatelessWidget {
  const _PremiumButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isPrimary,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isPrimary ? AppColors.primary : Colors.white,
      borderRadius: BorderRadius.circular(14),
      elevation: isPrimary ? 4 : 0,
      shadowColor: isPrimary
          ? AppColors.primary.withValues(alpha: 0.3)
          : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: isPrimary
                ? null
                : Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isPrimary ? Colors.white : AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isPrimary ? Colors.white : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
