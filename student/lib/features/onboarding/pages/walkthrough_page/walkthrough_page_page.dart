import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

final class WalkthroughPagePage extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final bool isLoading;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const WalkthroughPagePage({
    super.key,
    required this.pageController,
    required this.currentPage,
    required this.onPageChanged,
    required this.isLoading,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final textTheme = Theme.of(context).textTheme;
    final steps = _steps(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: TextButton(
                    onPressed: isLoading ? null : onSkip,
                    style: TextButton.styleFrom(
                      foregroundColor: palette.textTertiary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      context.t.ui.common.skip,
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: steps.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  final step = steps[index];
                  final isCurrent = currentPage == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isCurrent)
                          FadeInDown(
                            duration: const Duration(milliseconds: 800),
                            child: Container(
                              width: 260,
                              height: 260,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    palette.brandPrimary.withValues(
                                      alpha: 0.15,
                                    ),
                                    palette.brandPrimary.withValues(alpha: 0.0),
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: ZoomIn(
                                  duration: const Duration(milliseconds: 600),
                                  delay: const Duration(milliseconds: 200),
                                  child: Container(
                                    width: 140,
                                    height: 140,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          palette.brandPrimary,
                                          palette.brandPrimary.withValues(
                                            alpha: 0.8,
                                          ),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: [
                                        BoxShadow(
                                          color: palette.brandPrimary
                                              .withValues(alpha: 0.3),
                                          blurRadius: 30,
                                          offset: const Offset(0, 15),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      step.icon,
                                      size: 64,
                                      color: palette.textForeground,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        const Gap(60),
                        if (isCurrent)
                          FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            child: Text(
                              step.title,
                              style: textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: palette.textPrimary,
                                letterSpacing: -1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        const Gap(20),
                        if (isCurrent)
                          FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 200),
                            child: Text(
                              step.description,
                              style: textTheme.bodyLarge?.copyWith(
                                color: palette.textSecondary,
                                height: 1.6,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dots indicator
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    steps.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.elasticOut,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: currentPage == index ? 32 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? palette.brandPrimary
                            : palette.brandPrimary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: currentPage == index
                            ? [
                                BoxShadow(
                                  color: palette.brandPrimary.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Next / Get Started button
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
                child: MentorXButton(
                  loading: isLoading,
                  onPressed: onNext,
                  text: currentPage < steps.length - 1
                      ? context.t.ui.common.next
                      : context.t.ui.common.getStarted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_OnboardingStep> _steps(BuildContext context) {
    return [
      _OnboardingStep(
        icon: Icons.school_rounded,
        title: context.t.onboarding.steps.learn.title,
        description: context.t.onboarding.steps.learn.description,
      ),
      _OnboardingStep(
        icon: Icons.auto_graph_rounded,
        title: context.t.onboarding.steps.trackProgress.title,
        description: context.t.onboarding.steps.trackProgress.description,
      ),
      _OnboardingStep(
        icon: Icons.quiz_rounded,
        title: context.t.onboarding.steps.quizzes.title,
        description: context.t.onboarding.steps.quizzes.description,
      ),
    ];
  }
}

final class _OnboardingStep {
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingStep({
    required this.icon,
    required this.title,
    required this.description,
  });
}
