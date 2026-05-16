import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class CourseInfoHeader extends StatelessWidget {
  final CourseEntity course;
  final EnrollmentEntity? enrollment;

  const CourseInfoHeader({
    super.key,
    required this.course,
    this.enrollment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (course.imageUrl != null)
          FadeInDown(
            key: const ValueKey('course_header_image_fade'),
            duration: const Duration(milliseconds: 600),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Hero(
                    tag: 'catalog_course_${course.id}',
                    child: AppDynamicImage(
                      course.imageUrl ?? '',
                      fit: BoxFit.cover,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(32),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          context.backgroundPrimaryColor.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: FadeInLeft(
                    key: const ValueKey('course_header_preview_btn_fade'),
                    delay: const Duration(milliseconds: 400),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: context.brandPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: context.brandPrimaryColor.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          const Gap(6),
                          Text(
                            context.t.core.preview,
                            style: context.smallTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInUp(
                key: const ValueKey('course_header_title_fade'),
                duration: const Duration(milliseconds: 500),
                child: Text(
                  course.title,
                  style: context.titleH2Style.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                    height: 1.1,
                  ),
                ),
              ),
              if (course.subtitle != null) ...[
                const Gap(12),
                FadeInUp(
                  key: const ValueKey('course_header_subtitle_fade'),
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    course.subtitle!,
                    style: context.bodyPrimaryStyle.copyWith(
                      color: context.textSecondaryColor,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              const Gap(24),
              FadeInUp(
                key: const ValueKey('course_header_stats_fade'),
                delay: const Duration(milliseconds: 400),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      ...() {
                        final items = [
                          if (course.enrolledCount > 0)
                            _StatChip(
                              icon: Icons.people_alt_rounded,
                              label:
                                  '${course.enrolledCount} ${context.t.course.detail.students}',
                            ),
                          if (course.totalVideos > 0)
                            _StatChip(
                              icon: Icons.play_circle_filled_rounded,
                              label:
                                  '${course.totalVideos} ${context.t.course.detail.videos}',
                            ),
                          if (course.totalDurationMinutes > 0)
                            _StatChip(
                              icon: Icons.access_time_filled_rounded,
                              label: _formatDuration(course.totalDurationMinutes),
                            ),
                          if (enrollment != null &&
                              enrollment!.remainingDays > 0)
                            _StatChip(
                              icon: Icons.event_available_rounded,
                              label:
                                  '${enrollment!.remainingDays} ${context.t.course.detail.daysLeft}',
                              isHighlight: true,
                            ),
                        ];
                        if (items.isEmpty) return <Widget>[];
                        return items
                            .expand((w) => [w, const Gap(12)])
                            .toList()
                          ..removeLast();
                      }(),
                    ],
                  ),
                ),
              ),
              if (enrollment != null) ...[
                const Gap(24),
                FadeInUp(
                  key: const ValueKey('course_header_progress_fade'),
                  delay: const Duration(milliseconds: 600),
                  child: _ProgressBar(
                    progressPercent: enrollment!.progressPercent,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(int minutes) {
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      final mins = minutes % 60;
      return '${hours}h ${mins}m';
    }
    return '${minutes}m';
  }
}

final class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isHighlight;

  const _StatChip({
    required this.icon,
    required this.label,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      borderRadius: BorderRadius.circular(18),
      style: Style(
        $box.padding.horizontal(14),
        $box.padding.vertical(10),
        isHighlight
            ? $box.color(context.brandPrimaryColor.withValues(alpha: 0.15))
            : $box.color(
                context.backgroundSecondaryColor.withValues(alpha: 0.45),
              ),
        $box.border.all.color(
          isHighlight
              ? context.brandPrimaryColor.withValues(alpha: 0.3)
              : context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        $box.shadows(context.softShadow),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: context.brandPrimaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 14,
              color: context.brandPrimaryColor,
            ),
          ),
          const Gap(8),
          Text(
            label,
            style: context.smallTextStyle.copyWith(
              fontWeight: FontWeight.w900,
              color: isHighlight
                  ? context.brandPrimaryColor
                  : context.textPrimaryColor.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

final class _ProgressBar extends StatelessWidget {
  final double progressPercent;

  const _ProgressBar({
    required this.progressPercent,
  });

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      borderRadius: BorderRadius.circular(28),
      style: Style(
        $box.padding.all(20),
        $box.shadows(context.mediumShadow),
        $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.45)),
        $box.border.all.color(
          context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.t.course.detail.yourProgress,
                style: context.smallTextStyle.copyWith(
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                '${progressPercent.toInt()}%',
                style: context.smallTextStyle.copyWith(
                  fontWeight: FontWeight.w900,
                  color: context.brandPrimaryColor,
                ),
              ),
            ],
          ),
          const Gap(16),
          Stack(
            children: [
              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.backgroundPrimaryColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progressPercent / 100),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: value.clamp(0, 1),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 10,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.brandPrimaryColor,
                            context.brandPrimaryColor.withValues(alpha: 0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: context.brandPrimaryColor.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
