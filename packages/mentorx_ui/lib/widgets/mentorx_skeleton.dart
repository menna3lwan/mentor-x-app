part of '../mentorx_ui.dart';

class MentorXSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? color;

  const MentorXSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MentorXThemeProvider.of(context);
    final backgroundColor = color ?? theme.colors[$mentorxToken.color.backgroundTertiary]!;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  factory MentorXSkeleton.text({
    double? width,
    double height = 16,
    double borderRadius = 4,
  }) {
    return MentorXSkeleton(
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }

  factory MentorXSkeleton.circle({
    required double size,
  }) {
    return MentorXSkeleton(
      width: size,
      height: size,
      borderRadius: size / 2,
    );
  }
}
