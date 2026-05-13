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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 48,
              color: context.statusDangerColor,
            ),
            const Gap(16),
            Text(
              message ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: context.bodyPrimaryStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (onRetry != null) ...[
              const Gap(24),
              MentorXButton(
                label: 'Retry',
                onPressed: onRetry,
                width: 120,
                size: MentorXButtonSize.small,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
