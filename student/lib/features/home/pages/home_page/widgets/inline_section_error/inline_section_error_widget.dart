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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.statusDanger.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: palette.statusDanger.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: palette.statusDanger.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.error_outline_rounded,
                color: palette.statusDanger, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.t.home.dashboard.unableToLoadTapRetry,
              style: TextStyle(
                color: palette.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onRetry,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  context.t.ui.errors.retry,
                  style: TextStyle(
                    color: palette.statusDanger,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
