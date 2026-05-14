part of '../mentorx_ui.dart';

class MentorXErrorIndicator extends StatelessWidget {
  const MentorXErrorIndicator({
    super.key,
    this.message,
    this.onRetry,
    this.icon = Icons.error_outline_rounded,
  });

  final String? message;
  final VoidCallback? onRetry;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.statusDangerColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: context.statusDangerColor,
              ),
            ),
            const Gap(20),
            Text(
              message ?? t.ui.widgets.error.title,
              textAlign: TextAlign.center,
              style: context.bodyPrimaryStyle.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            if (onRetry != null) ...[
              const Gap(24),
              MentorXButton(
                label: t.ui.widgets.error.retry,
                onPressed: onRetry,
                width: 140,
                size: MentorXButtonSize.small,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
