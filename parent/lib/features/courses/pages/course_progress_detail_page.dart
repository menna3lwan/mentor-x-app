import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

/// Pure-layout view of a single course's progress. State + DI live in
/// [CourseProgressDetailPageWrapper].
class CourseProgressDetailPage extends StatelessWidget {
  final String title;
  final Widget body;
  final VoidCallback onBackPressed;
  final Future<void> Function() onRefresh;

  const CourseProgressDetailPage({
    super.key,
    required this.title,
    required this.body,
    required this.onBackPressed,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBar: AppBar(
        backgroundColor: context.backgroundSecondaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: context.textPrimaryColor,
            size: 20,
          ),
          onPressed: onBackPressed,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: context.brandPrimaryColor,
          ),
        ),
      ),
      body: RefreshIndicator(onRefresh: onRefresh, child: body),
    );
  }
}

/// Card showing the course title + thumbnail + the live progress percentage
/// pulled from the backend.
class CourseProgressHeroCard extends StatelessWidget {
  final String title;
  final String? description;
  final String thumbnailUrl;
  final double progressPercent;
  final String progressLabel;
  final String enrolledLabel;

  const CourseProgressHeroCard({
    super.key,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.progressPercent,
    required this.progressLabel,
    required this.enrolledLabel,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progressPercent.clamp(0, 100)) / 100.0;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.brandPrimaryColor,
            context.brandPrimaryColor.withValues(alpha: 0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: context.brandPrimaryColor.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.auto_stories_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const Gap(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.textForegroundColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    if (description != null && description!.isNotEmpty) ...[
                      const Gap(4),
                      Text(
                        description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: context.textForegroundColor.withValues(
                            alpha: 0.8,
                          ),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: Text(
                  progressLabel,
                  style: TextStyle(
                    color: context.textForegroundColor.withValues(alpha: 0.85),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '${progressPercent.toStringAsFixed(0)}%',
                style: TextStyle(
                  color: context.textForegroundColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const Gap(8),
          Stack(
            children: [
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percent,
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              Icon(
                Icons.group_rounded,
                color: context.textForegroundColor.withValues(alpha: 0.85),
                size: 14,
              ),
              const Gap(6),
              Text(
                enrolledLabel,
                style: TextStyle(
                  color: context.textForegroundColor.withValues(alpha: 0.85),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CourseProgressDetailsCard extends StatelessWidget {
  final List<({String label, String value})> rows;

  const CourseProgressDetailsCard({super.key, required this.rows});

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
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0)
              Divider(
                height: 24,
                color: context.textTertiaryColor.withValues(alpha: 0.1),
              ),
            _DetailRow(label: rows[i].label, value: rows[i].value),
          ],
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        const Gap(12),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class CourseProgressDetailSkeleton extends StatelessWidget {
  const CourseProgressDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        MentorXSkeleton(width: double.infinity, height: 180, borderRadius: 24),
        SizedBox(height: 24),
        MentorXSkeleton(width: double.infinity, height: 16, borderRadius: 6),
        SizedBox(height: 12),
        MentorXSkeleton(width: double.infinity, height: 16, borderRadius: 6),
        SizedBox(height: 12),
        MentorXSkeleton(width: double.infinity, height: 16, borderRadius: 6),
      ],
    );
  }
}

/// Empty-state used when the backend returns no summary at all (rare, but
/// covered so the page never blanks).
class CourseProgressEmptyView extends StatelessWidget {
  final String title;
  final String hint;
  final String retryLabel;
  final VoidCallback onRetry;

  const CourseProgressEmptyView({
    super.key,
    required this.title,
    required this.hint,
    required this.retryLabel,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Gap(40),
        Icon(
          Icons.menu_book_outlined,
          size: 56,
          color: context.textTertiaryColor,
        ),
        const Gap(12),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: context.textPrimaryColor,
          ),
        ),
        const Gap(4),
        Text(
          hint,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.textSecondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const Gap(20),
        Center(
          child: OutlinedButton(
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
        ),
      ],
    );
  }
}
