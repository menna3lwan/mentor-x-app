import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/core.dart';
import '../../widgets/status_layout.dart';

final class StatusRejectedPagePage extends StatelessWidget {
  const StatusRejectedPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return StatusLayout(
      icon: Icons.close_rounded,
      iconBackground: palette.statusDanger.withAlpha(25),
      title: context.t.accountStatus.rejectedTitle,
      description: context.t.accountStatus.rejectedDescription,
      extra: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: palette.statusDanger.withAlpha(15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          context.t.accountStatus.rejectedReason,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: palette.statusDanger,
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
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
