part of '../mentorx_ui.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    required this.message,
    this.title = 'Something went wrong',
    this.onRetry,
    this.buttonText = 'Retry',
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline, 
              size: 60, 
              color: context.statusDangerColor
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.textPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: context.textSecondaryColor),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              MentorXButton(
                text: buttonText,
                onPressed: onRetry,
                style: Style($box.width(160)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
