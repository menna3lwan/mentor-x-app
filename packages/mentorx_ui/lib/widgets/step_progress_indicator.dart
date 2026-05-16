part of '../mentorx_ui.dart';

class StepProgressIndicator extends StatelessWidget {
  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.activeColor,
    this.inactiveColor,
    this.height = 6,
    this.spacing = 4,
  });

  final int currentStep;
  final int totalSteps;
  final Color? activeColor;
  final Color? inactiveColor;
  final double height;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index <= currentStep;
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: spacing / 2),
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height * 2),
              color: isActive
                  ? (activeColor ?? context.brandPrimaryColor)
                  : (inactiveColor ?? context.backgroundSecondaryColor),
            ),
          ),
        );
      }),
    );
  }
}
