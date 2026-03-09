import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/core.dart';
import '../../widgets/status_layout.dart';

final class StatusBlockedPagePage extends StatelessWidget {
  const StatusBlockedPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return StatusLayout(
      icon: Icons.lock_outline,
      iconBackground: palette.statusDanger.withAlpha(25),
      title: context.t.accountStatus.blockedTitle,
      description: context.t.accountStatus.blockedDescription,
      extra: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            context.t.accountStatus.blockedSupportInfo,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: palette.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => const LoginPageRoute().go(context),
          child: Text(context.t.ui.common.backToLogin),
        ),
      ],
    );
  }
}
