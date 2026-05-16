part of '../mentorx_ui.dart';

class MentorXShimmer extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final Duration duration;
  final Color? baseColor;
  final Color? highlightColor;

  const MentorXShimmer({
    super.key,
    required this.child,
    this.enabled = true,
    this.duration = const Duration(milliseconds: 1500),
    this.baseColor,
    this.highlightColor,
  });

  @override
  State<MentorXShimmer> createState() => _MentorXShimmerState();
}

class _MentorXShimmerState extends State<MentorXShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    final effectiveBaseColor =
        widget.baseColor ?? context.backgroundTertiaryColor;
    final effectiveHighlightColor =
        widget.highlightColor ?? context.backgroundSecondaryColor;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                effectiveBaseColor,
                effectiveHighlightColor,
                effectiveBaseColor,
              ],
              stops: const [0.1, 0.5, 0.9],
              transform: _SlidingGradientTransform(offset: _controller.value),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double offset;

  const _SlidingGradientTransform({required this.offset});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (offset - 0.5) * 2, 0, 0);
  }
}
