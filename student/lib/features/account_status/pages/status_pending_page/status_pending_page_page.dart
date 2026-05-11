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
    final t = context.t.accountStatus;

    return StatusLayout(
      icon: Icons.hourglass_top_rounded,
      iconBackground: context.statusWarningColor,
      title: t.pendingTitle,
      description: t.pendingDescription,
      extra: Column(
        children: [
          if (studentCode != null && studentCode!.trim().isNotEmpty) ...[
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: context.borderPrimaryColor.withValues(alpha: 0.05),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      context.t.student['studentCodeLabel'] ?? 'STUDENT CODE',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: context.textTertiaryColor,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      studentCode!,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const Gap(32),
          ],
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 200),
            child: Text(
              t.pendingSupportInfo,
              style: TextStyle(
                fontSize: 14,
                color: context.textTertiaryColor,
                fontWeight: FontWeight.w700,
                height: 1.6,
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
                color: context.textTertiaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
