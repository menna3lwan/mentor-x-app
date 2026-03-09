import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/core.dart';
import '../../widgets/status_layout.dart';

final class StatusPendingPagePage extends StatelessWidget {
  const StatusPendingPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return StatusLayout(
      icon: Icons.hourglass_top_outlined,
      iconBackground: palette.backgroundSecondary,
      title: context.t.accountStatus.pendingTitle,
      description: context.t.accountStatus.pendingDescription,
      extra: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            context.t.accountStatus.pendingSupportInfo,
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
