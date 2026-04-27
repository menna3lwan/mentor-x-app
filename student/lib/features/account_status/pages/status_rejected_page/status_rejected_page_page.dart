import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';
import '../../widgets/status_layout.dart';

final class StatusRejectedPagePage extends StatelessWidget {
  const StatusRejectedPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final t = context.t.accountStatus;

    return StatusLayout(
      icon: Icons.close_rounded,
      iconBackground: palette.statusDanger,
      title: t.rejectedTitle,
      description: t.rejectedDescription,
      extra: FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          decoration: BoxDecoration(
            color: palette.statusDanger.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: palette.statusDanger.withValues(alpha: 0.1)),
          ),
          child: Column(
            children: [
              Text(
                'REJECTION REASON',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: palette.statusDanger.withValues(alpha: 0.6),
                  letterSpacing: 1.2,
                ),
              ),
              const Gap(12),
              Text(
                t.rejectedReason,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: palette.statusDanger,
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
            onPressed: () => const LoginPageRoute().go(context),
            label: context.t.ui.common.backToLogin,
            color: palette.statusDanger,
          ),
        ),
      ],
    );
  }
}
