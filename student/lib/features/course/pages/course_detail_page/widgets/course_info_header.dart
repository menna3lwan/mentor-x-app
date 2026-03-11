import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

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
    final palette = MentorXThemeColorPalette.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (course.imageUrl != null)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              course.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: palette.backgroundSecondary,
                child: Icon(
                  Icons.school_outlined,
                  size: 64,
                  color: palette.textSecondary,
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              if (course.subtitle != null) ...[
                const SizedBox(height: 6),
                Text(
                  course.subtitle!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: palette.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  _StatChip(
                    icon: Icons.people_outline,
                    label: '${course.enrolledCount}',
                    palette: palette,
                  ),
                  const SizedBox(width: 12),
                  _StatChip(
                    icon: Icons.play_circle_outline,
                    label: '${course.totalVideos}',
                    palette: palette,
                  ),
                  const SizedBox(width: 12),
                  _StatChip(
                    icon: Icons.access_time,
                    label: _formatDuration(
                      context,
                      course.totalDurationMinutes,
                    ),
                    palette: palette,
                  ),
                ],
              ),
              if (enrollment != null) ...[
                const SizedBox(height: 12),
                _ProgressBar(
                  progressPercent: enrollment!.progressPercent,
                  palette: palette,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(BuildContext context, int minutes) {
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
  final MentorXThemeColorPalette palette;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: palette.textSecondary),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: palette.textSecondary),
        ),
      ],
    );
  }
}

final class _ProgressBar extends StatelessWidget {
  final double progressPercent;
  final MentorXThemeColorPalette palette;

  const _ProgressBar({
    required this.progressPercent,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.t.course.detail.continueStudying,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: palette.textSecondary),
            ),
            Text(
              '${progressPercent.toInt()}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: palette.brandPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progressPercent / 100,
            minHeight: 6,
            backgroundColor: palette.backgroundSecondary,
            valueColor: AlwaysStoppedAnimation(palette.brandPrimary),
          ),
        ),
      ],
    );
  }
}
