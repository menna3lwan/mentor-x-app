part of '../mentorx_ui.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    required this.message,
    this.title,
    this.onRetry,
    this.buttonText,
  });

  final String? title;
  final String message;
  final VoidCallback? onRetry;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: context.statusDangerColor.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: context.statusDangerColor.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title ?? t_ui.widgets.error.title,
              style: context.bodyPrimaryStyle.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 22,
                color: context.textPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.bodySecondaryStyle.copyWith(
                color: context.textSecondaryColor,
                height: 1.5,
                fontSize: 15,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 32),
              MentorXButton(
                text: buttonText ?? t_ui.widgets.error.retry,
                onPressed: onRetry,
                style: Style($box.width(200)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
