import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../widgets/status_layout.dart';

final class StatusPendingPagePage extends StatelessWidget {
  final String? studentCode;
  final bool isRefreshing;
  final VoidCallback onRefresh;
  final VoidCallback onLogout;

  const StatusPendingPagePage({
    super.key,
    required this.studentCode,
    required this.isRefreshing,
    required this.onRefresh,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final t = context.t.accountStatus;

    return StatusLayout(
      icon: Icons.hourglass_top_rounded,
      iconBackground: palette.brandSecondary,
      title: t.pendingTitle,
      description: t.pendingDescription,
      extra: Column(
        children: [
          if (studentCode != null && studentCode!.trim().isNotEmpty) ...[
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: palette.backgroundSecondary,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: palette.brandPrimary.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: palette.brandPrimary.withValues(alpha: 0.03),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      context.t.student['studentCodeLabel'] ?? 'STUDENT CODE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: palette.textTertiary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      studentCode!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: palette.brandPrimary,
                        letterSpacing: 3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const Gap(24),
          ],
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 200),
            child: Text(
              t.pendingSupportInfo,
              style: TextStyle(
                fontSize: 14,
                color: palette.textTertiary,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      actions: [
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 300),
          child: MentorXButton(
            onPressed: onRefresh,
            loading: isRefreshing,
            label: 'Refresh Status',
          ),
        ),

        const Gap(20),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 500),
          child: TextButton(
            onPressed: isRefreshing ? null : onLogout,
            child: Text(
              context.t.student['logoutSetting'] ?? 'Logout',
              style: TextStyle(
                color: palette.textTertiary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
