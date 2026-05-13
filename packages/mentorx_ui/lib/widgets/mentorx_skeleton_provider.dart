part of '../mentorx_ui.dart';

final class MentorXSkeletonProvider extends StatelessWidget {
  final Widget child;

  const MentorXSkeletonProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Note: This requires the 'skeletonizer' package to be added to pubspec.yaml
    // Assuming it is already present or will be added.
    return SkeletonizerConfig(
      data: const SkeletonizerConfigData(
        enableSwitchAnimation: true,
        switchAnimationConfig: SwitchAnimationConfig(
          reverseDuration: Duration.zero,
        ),
      ),
      child: child,
    );
  }
}
