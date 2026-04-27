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
    final t = context.t.student;

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [palette.brandPrimary, palette.brandPrimary.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
            boxShadow: [
              BoxShadow(color: palette.brandPrimary.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 4)),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
      body: _buildBody(context, palette, t),
    );
  }

  Widget _buildBody(BuildContext context, MentorXThemeColorPalette palette, dynamic t) {
    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline_rounded, size: 64, color: Colors.red.withOpacity(0.3)),
              const SizedBox(height: 24),
              Text(
                errorMessage!,
                style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        // Video Player Placeholder
        Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10)),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Gradient Background
                  Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [palette.brandPrimary.withOpacity(0.2), Colors.transparent],
                        radius: 1,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.play_arrow_rounded, size: 48, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        context.t.course.player.title,
                        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  // Progress Overlay (Glassmorphic)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: totalDurationSeconds > 0
                                    ? currentPositionSeconds / totalDurationSeconds
                                    : 0,
                                minHeight: 4,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                valueColor: AlwaysStoppedAnimation(palette.brandPrimary),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${_formatTime(currentPositionSeconds)} / ${_formatTime(totalDurationSeconds)}',
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Video Info Section
        Expanded(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, -5)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: palette.textPrimary),
                      ),
                    ),
                    if (isCompleted)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_rounded, color: Colors.green, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              context.t.course.player.completed,
                              style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                _InfoTile(
                  label: t['videoDuration'] ?? 'Duration',
                  value: _formatTime(totalDurationSeconds),
                  icon: Icons.timer_rounded,
                  palette: palette,
                ),
                const SizedBox(height: 12),
                _InfoTile(
                  label: t['videoStatus'] ?? 'Status',
                  value: isCompleted ? (t['videoCompleted'] ?? 'Completed') : (t['videoWatching'] ?? 'Watching'),
                  icon: Icons.info_outline_rounded,
                  palette: palette,
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

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final MentorXThemeColorPalette palette;

  const _InfoTile({required this.label, required this.value, required this.icon, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.backgroundSecondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: palette.textTertiary, size: 20),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: palette.textSecondary, fontSize: 13, fontWeight: FontWeight.w600)),
          const Spacer(),
          Text(value, style: TextStyle(color: palette.textPrimary, fontSize: 13, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
