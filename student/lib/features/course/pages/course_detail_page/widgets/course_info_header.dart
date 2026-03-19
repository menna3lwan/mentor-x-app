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
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Hero(
                  tag: 'catalog_course_${course.id}',
                  child: Image.network(
                    course.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: palette.backgroundSecondary,
                      child: Icon(
                        Icons.school_outlined,
                        size: 64,
                        color: palette.textTertiary,
                      ),
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
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: palette.brandPrimary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: palette.brandPrimary.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        'Introduction Video',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: palette.textPrimary,
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
              ),
              if (course.subtitle != null) ...[
                const SizedBox(height: 10),
                Text(
                  course.subtitle!,
                  style: TextStyle(
                    fontSize: 15,
                    color: palette.textSecondary,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 24),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _StatChip(
                      icon: Icons.people_alt_rounded,
                      label: '${course.enrolledCount} Students',
                      palette: palette,
                    ),
                    const SizedBox(width: 12),
                    _StatChip(
                      icon: Icons.play_circle_filled_rounded,
                      label: '${course.totalVideos} Lessons',
                      palette: palette,
                    ),
                    const SizedBox(width: 12),
                    _StatChip(
                      icon: Icons.access_time_filled_rounded,
                      label: _formatDuration(context, course.totalDurationMinutes),
                      palette: palette,
                    ),
                  ],
                ),
              ),
              if (enrollment != null) ...[
                const SizedBox(height: 24),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: palette.backgroundSecondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.textTertiary.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: palette.brandPrimary),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: palette.textPrimary,
            ),
          ),
        ],
      ),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.brandPrimary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: palette.brandPrimary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Course Progress',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: palette.brandPrimary,
                ),
              ),
              Text(
                '${progressPercent.toInt()}%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: palette.brandPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: palette.backgroundSecondary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    height: 8,
                    width: constraints.maxWidth * (progressPercent / 100),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [palette.brandPrimary, palette.brandPrimary.withOpacity(0.7)],
                      ),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: palette.brandPrimary.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
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
