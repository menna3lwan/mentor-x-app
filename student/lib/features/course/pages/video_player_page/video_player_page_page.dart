import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class VideoPlayerPagePage extends StatelessWidget {
  final String title;
  final String? streamUrl;
  final bool isLoading;
  final bool isReady;
  final bool isCompleted;
  final String? errorMessage;
  final int currentPositionSeconds;
  final int totalDurationSeconds;
  final void Function(int position, int total) onProgressChanged;
  final VoidCallback onCompleted;

  const VideoPlayerPagePage({
    super.key,
    required this.title,
    required this.streamUrl,
    required this.isLoading,
    required this.isReady,
    required this.isCompleted,
    required this.errorMessage,
    required this.currentPositionSeconds,
    required this.totalDurationSeconds,
    required this.onProgressChanged,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _buildBody(context, palette),
    );
  }

  Widget _buildBody(BuildContext context, MentorXThemeColorPalette palette) {
    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: palette.statusDanger),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                errorMessage!,
                style: TextStyle(color: palette.statusDanger),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        // Video placeholder area
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_fill,
                    size: 64,
                    color: Colors.white.withAlpha(204),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.t.course.player.title,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  if (streamUrl != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 8,
                      ),
                      child: Text(
                        streamUrl!,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        // Video controls placeholder
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: totalDurationSeconds > 0
                      ? currentPositionSeconds / totalDurationSeconds
                      : 0,
                  minHeight: 4,
                  backgroundColor: palette.backgroundSecondary,
                  valueColor: AlwaysStoppedAnimation(palette.brandPrimary),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatTime(currentPositionSeconds),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: palette.textSecondary,
                    ),
                  ),
                  Text(
                    _formatTime(totalDurationSeconds),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: palette.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Video info section
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                if (isCompleted)
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: palette.statusSuccess,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        context.t.course.player.completed,
                        style: TextStyle(color: palette.statusSuccess),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
