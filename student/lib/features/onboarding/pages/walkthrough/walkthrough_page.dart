import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class WalkthroughPage extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final bool isLoading;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const WalkthroughPage({
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
    final steps = _steps(context);

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          // Background Decorations
          Positioned(
            top: -100,
            right: -100,
            child: FadeInDown(
              duration: const Duration(seconds: 2),
              child: _BackgroundBlob(
                size: 300,
                color: context.brandPrimaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: FadeInUp(
              duration: const Duration(seconds: 2),
              child: _BackgroundBlob(
                size: 200,
                color: context.brandSecondaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Skip button
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: TextButton(
                        onPressed: isLoading ? null : onSkip,
                        style: TextButton.styleFrom(
                          foregroundColor: context.textTertiaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: context.borderPrimaryColor.withValues(
                                alpha: 0.1,
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          context.t.core.skip,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                            fontSize: 12,
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
                              ZoomIn(
                                duration: const Duration(milliseconds: 800),
                                child: Container(
                                  width: 320,
                                  height: 320,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: context.brandPrimaryColor
                                            .withValues(alpha: 0.1),
                                        blurRadius: 50,
                                        spreadRadius: 20,
                                      ),
                                    ],
                                  ),
                                  child: AppDynamicImage(
                                    step.imagePath,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            const Gap(48),
                            if (isCurrent) ...[
                              FadeInUp(
                                duration: const Duration(milliseconds: 600),
                                child: Text(
                                  step.title,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    color: context.textPrimaryColor,
                                    letterSpacing: -1.5,
                                    height: 1.1,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Gap(20),
                              FadeInUp(
                                duration: const Duration(milliseconds: 600),
                                delay: const Duration(milliseconds: 200),
                                child: Text(
                                  step.description,
                                  style: TextStyle(
                                    color: context.textSecondaryColor,
                                    height: 1.6,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
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
                        (index) =>
                            _AnimatedIndicator(isActive: currentPage == index),
                      ),
                    ),
                  ),
                ),

                // Next / Get Started button
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 32, 48),
                    child: MentorXButton(
                      loading: isLoading,
                      onPressed: onNext,
                      label: currentPage < steps.length - 1
                          ? context.t.core.next
                          : context.t.core.getStarted,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<_OnboardingStep> _steps(BuildContext context) {
    return [
      _OnboardingStep(
        imagePath: 'assets/images/onboarding/learn.png',
        title: context.t.onboarding.steps.learn.title,
        description: context.t.onboarding.steps.learn.description,
      ),
      _OnboardingStep(
        imagePath: 'assets/images/onboarding/track_progress.png',
        title: context.t.onboarding.steps.trackProgress.title,
        description: context.t.onboarding.steps.trackProgress.description,
      ),
      _OnboardingStep(
        imagePath: 'assets/images/onboarding/quizzes.png',
        title: context.t.onboarding.steps.quizzes.title,
        description: context.t.onboarding.steps.quizzes.description,
      ),
    ];
  }
}

final class _OnboardingStep {
  final String imagePath;
  final String title;
  final String description;

  const _OnboardingStep({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class _BackgroundBlob extends StatelessWidget {
  final double size;
  final Color color;

  const _BackgroundBlob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 100,
            spreadRadius: 50,
          ),
        ],
      ),
    );
  }
}

class _AnimatedIndicator extends StatelessWidget {
  final bool isActive;

  const _AnimatedIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.elasticOut,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: isActive ? 40 : 12,
      height: 12,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).primaryColor
            : Theme.of(context).dividerColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
    );
  }
}
