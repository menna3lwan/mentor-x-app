import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class InlineSectionErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const InlineSectionErrorWidget({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: palette.statusDanger),
          const SizedBox(width: 8),
          Expanded(
            child: Text(context.t.home.dashboard.unableToLoadTapRetry),
          ),
          TextButton(
            onPressed: onRetry,
            child: Text(context.t.ui.errors.retry),
          ),
        ],
      ),
    );
  }
}
