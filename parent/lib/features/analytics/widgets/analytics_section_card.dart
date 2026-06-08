import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

/// Card frame used for every analytics section. Provides title + body slot
/// + uniform corner / padding / border so the dashboard reads consistently.
class AnalyticsSectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const AnalyticsSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.textTertiaryColor.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: context.textPrimaryColor,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const Gap(16),
          child,
        ],
      ),
    );
  }
}

/// Standard small empty state inside a section card.
class AnalyticsEmptyState extends StatelessWidget {
  final String title;
  final String hint;

  const AnalyticsEmptyState({
    super.key,
    required this.title,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Icon(
            Icons.insights_rounded,
            size: 36,
            color: context.textTertiaryColor.withValues(alpha: 0.6),
          ),
          const Gap(8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: context.textPrimaryColor,
            ),
          ),
          const Gap(4),
          Text(
            hint,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Standard small failure state with retry CTA inside a section card.
class AnalyticsFailureState extends StatelessWidget {
  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  const AnalyticsFailureState({
    super.key,
    required this.message,
    required this.retryLabel,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: context.statusDangerColor,
            size: 28,
          ),
          const Gap(8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.textSecondaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(12),
          OutlinedButton(
            onPressed: onRetry,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: context.brandPrimaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              retryLabel,
              style: TextStyle(
                color: context.brandPrimaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
