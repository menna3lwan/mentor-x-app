part of '../mentorx_ui.dart';

final class MentorXSkeletonProvider extends StatelessWidget {
  final Widget child;

  const MentorXSkeletonProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SkeletonizerConfig(
      data: SkeletonizerConfigData(
        enableSwitchAnimation: true,
        switchAnimationConfig: const SwitchAnimationConfig(
          reverseDuration: Duration.zero,
        ),
        effect: ShimmerEffect(
          baseColor: context.backgroundTertiaryColor,
          highlightColor: context.backgroundSecondaryColor,
          duration: const Duration(milliseconds: 1500),
        ),
      ),
      child: child,
    );
  }
}
