import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import '../../widgets/status_layout.dart';

final class StatusRejectedPage extends StatelessWidget {
  const StatusRejectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.accountstatus;

    return StatusLayout(
      icon: Icons.close_rounded,
      iconBackground: context.statusDangerColor,
      title: t.rejectedTitle,
      description: t.rejectedDescription,
      extra: FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: context.statusDangerColor.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: context.statusDangerColor.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: [
              Text(
                'REJECTION REASON',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: context.statusDangerColor.withValues(alpha: 0.6),
                  letterSpacing: 1.5,
                ),
              ),
              const Gap(16),
              Text(
                t.rejectedReason,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: context.statusDangerColor,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      actions: [
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 300),
          child: MentorXButton(
            onPressed: () => const LoginRoute().go(context),
            label: context.t.auth.backToLogin,
          ),
        ),
      ],
    );
  }
}
