import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../widgets/status_layout.dart';

final class StatusPendingPagePage extends StatelessWidget {
  final String? studentCode;
  final bool isRefreshing;
  final bool showContactTeacher;
  final VoidCallback onRefresh;
  final VoidCallback? onContactTeacher;
  final VoidCallback onLogout;

  const StatusPendingPagePage({
    super.key,
    required this.studentCode,
    required this.isRefreshing,
    required this.showContactTeacher,
    required this.onRefresh,
    required this.onContactTeacher,
    required this.onLogout,
  });

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
          if (studentCode != null && studentCode!.trim().isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: palette.backgroundSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Student Code',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: palette.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    studentCode!,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
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
          onPressed: isRefreshing ? null : onRefresh,
          child: isRefreshing
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Refresh Status'),
        ),
        if (showContactTeacher)
          OutlinedButton(
            onPressed: onContactTeacher,
            child: const Text('Contact Teacher'),
          ),
        TextButton(
          onPressed: isRefreshing ? null : onLogout,
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
