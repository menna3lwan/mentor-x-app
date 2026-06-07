import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:mentorx_student/core/core.dart';

final class VideoPlayerPage extends StatefulWidget {
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

  const VideoPlayerPage({
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
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
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
  void didUpdateWidget(VideoPlayerPage oldWidget) {
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
      _videoPlayerController!
          .initialize()
          .then((_) {
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
          })
          .catchError((error) {
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

    Widget buildContent(Widget playerWidget) {
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
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
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
          // Player at the top (full width)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: MentorXSecuredMediaWrapper(
              watermarkText: widget.watermarkText,
              child: playerWidget,
            ),
          ),
          
          // Info Section below
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Gap(16),
                  _buildInfoSection(context),
                ],
              ),
            ),
          ),
        ],
      );
    }

    if (_youtubeController != null) {
      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubeController!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: context.brandPrimaryColor,
        ),
        builder: (context, player) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            appBar: MentorXAppBar(
              titleText: widget.title,
              backgroundColor: Colors.transparent,
            ),
            body: buildContent(player),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBar: MentorXAppBar(
        titleText: widget.title,
        backgroundColor: Colors.transparent,
      ),
      body: buildContent(_buildPlayer(context)),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Column(
      children: [
        _InfoTile(
          label: context.t.course.player.duration,
          value: _formatTime(widget.totalDurationSeconds),
          icon: Icons.timer_rounded,
        ),
        const Gap(12),
        _InfoTile(
          label: context.t.course.player.status,
          value: widget.isCompleted
              ? context.t.course.player.completed
              : context.t.course.player.watching,
          icon: Icons.info_outline_rounded,
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
