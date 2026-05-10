import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/core.dart';
import '../../widgets/status_layout.dart';

final class StatusBlockedPagePage extends StatelessWidget {
  const StatusBlockedPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.accountStatus;

    return StatusLayout(
      icon: Icons.lock_rounded,
      iconBackground: context.statusDangerColor,
      title: t.blockedTitle,
      description: t.blockedDescription,
      extra: FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Text(
          t.blockedSupportInfo,
          style: TextStyle(
            fontSize: 15,
            color: context.textTertiaryColor,
            fontWeight: FontWeight.w700,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 300),
          child: MentorXButton(
            onPressed: () => const LoginPageRoute().go(context),
            label: context.t.ui.common.backToLogin,
          ),
        ),
      ],
    );
  }
}
