import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final class VideoPlayerPagePage extends StatefulWidget {
  final String title;
  final String? streamUrl;
  final bool isLoading;
  final bool isReady;
  final bool isCompleted;
  final String? errorMessage;
  final String? watermarkText;
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
    this.watermarkText,
  });

  @override
  State<VideoPlayerPagePage> createState() => _VideoPlayerPagePageState();
}

class _VideoPlayerPagePageState extends State<VideoPlayerPagePage> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  YoutubePlayerController? _youtubeController;
  int _lastReportedSecond = -1;

  @override
  void initState() {
    super.initState();
    if (widget.streamUrl != null) {
      _initializePlayer();
    }
  }

  @override
  void didUpdateWidget(VideoPlayerPagePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.streamUrl != oldWidget.streamUrl && widget.streamUrl != null) {
      _initializePlayer();
    }
  }

  void _initializePlayer() {
    _disposeControllers();
    _lastReportedSecond = -1;

    final url = widget.streamUrl!;
    if (url.contains('youtube.com') || url.contains('youtu.be')) {
      final videoId = YoutubePlayer.convertUrlToId(url);
      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        )..addListener(_onYoutubePlayerStateChange);
      }
      setState(() {});
    } else {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
      _videoPlayerController!.initialize().then((_) {
        if (mounted) {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController!,
            autoPlay: true,
            looping: false,
            aspectRatio: _videoPlayerController!.value.aspectRatio,
            errorBuilder: (context, errorMessage) {
              return Center(
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          );
          _videoPlayerController!.addListener(_onVideoPlayerStateChange);
          setState(() {});
        }
      }).catchError((error) {
        debugPrint('Video initialization error: $error');
      });
    }
  }

  void _onVideoPlayerStateChange() {
    if (_videoPlayerController == null) return;
    final position = _videoPlayerController!.value.position.inSeconds;
    final duration = _videoPlayerController!.value.duration.inSeconds;

    if (position != _lastReportedSecond) {
      _lastReportedSecond = position;
      widget.onProgressChanged(position, duration);
    }

    if (_videoPlayerController!.value.position >=
            _videoPlayerController!.value.duration &&
        _videoPlayerController!.value.duration != Duration.zero) {
      widget.onCompleted();
    }
  }

  void _onYoutubePlayerStateChange() {
    if (_youtubeController == null) return;
    final position = _youtubeController!.value.position.inSeconds;
    final duration = _youtubeController!.metadata.duration.inSeconds;

    if (position != _lastReportedSecond) {
      _lastReportedSecond = position;
      widget.onProgressChanged(position, duration);
    }

    if (_youtubeController!.value.playerState == PlayerState.ended) {
      widget.onCompleted();
    }
  }

  void _disposeControllers() {
    _videoPlayerController?.removeListener(_onVideoPlayerStateChange);
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    _youtubeController?.removeListener(_onYoutubePlayerStateChange);
    _youtubeController?.dispose();
    _videoPlayerController = null;
    _chewieController = null;
    _youtubeController = null;
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          Positioned.fill(
            child: Column(
              children: [
                Gap(MediaQuery.paddingOf(context).top + 20),
                _buildHeader(context),
                Expanded(child: _buildBody(context, t)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: MentorXIconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icons.arrow_back_ios_new_rounded,
              color: context.textPrimaryColor,
              size: MentorXIconButtonSize.small,
            ),
          ),
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'NOW PLAYING',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: context.brandPrimaryColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                const Gap(4),
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    dynamic t,
  ) {
    if (widget.errorMessage != null) {
      return AppErrorView(
        message: widget.errorMessage!,
      );
    }

    if (widget.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const MentorXSkeleton(height: 200, borderRadius: 32),
            const Gap(40),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Column(
                  children: List.generate(
                    3,
                    (index) => const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: MentorXSkeleton(height: 60, borderRadius: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: context.borderPrimaryColor.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: MentorXSecuredMediaWrapper(
                  watermarkText: widget.watermarkText,
                  child: _buildPlayer(context),
                ),
              ),
            ),
          ),
        ),

        // Video Info Section
        Expanded(
          child: FadeInUp(
            duration: const Duration(milliseconds: 600),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(44),
                ),
                border: Border.all(
                  color: context.borderPrimaryColor.withValues(alpha: 0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 30,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(44),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: context.textPrimaryColor,
                                  letterSpacing: -0.8,
                                ),
                              ),
                            ),
                            if (widget.isCompleted)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: context.statusSuccessColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: context.statusSuccessColor
                                        .withValues(
                                      alpha: 0.1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color: context.statusSuccessColor,
                                      size: 16,
                                    ),
                                    const Gap(8),
                                    Text(
                                      context.t.course.player.completed
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: context.statusSuccessColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const Gap(40),
                        _InfoTile(
                          label: t['videoDuration'] ?? 'Duration',
                          value: _formatTime(widget.totalDurationSeconds),
                          icon: Icons.timer_rounded,
                        ),
                        const Gap(16),
                        _InfoTile(
                          label: t['videoStatus'] ?? 'Status',
                          value: widget.isCompleted
                              ? (t['videoCompleted'] ?? 'Completed')
                              : (t['videoWatching'] ?? 'Watching'),
                          icon: Icons.info_outline_rounded,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayer(BuildContext context) {
    if (_youtubeController != null) {
      return YoutubePlayer(
        controller: _youtubeController!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: context.brandPrimaryColor,
      );
    }

    if (_chewieController != null) {
      return Chewie(controller: _chewieController!);
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

final class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.brandPrimaryColor.withValues(alpha: 0.15),
                  context.brandPrimaryColor.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.brandPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: Icon(icon, color: context.brandPrimaryColor, size: 24),
          ),
          const Gap(20),
          Text(
            label,
            style: TextStyle(
              color: context.textSecondaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
      ),
    );
  }
}
