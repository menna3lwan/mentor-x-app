import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: isLoading ? null : onSkip,
                  child: Text(
                    context.t.ui.common.skip,
                    style: textTheme.bodyLarge?.copyWith(
                      color: palette.textSecondary,
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                palette.brandPrimary.withValues(alpha: 0.15),
                                palette.brandPrimary.withValues(alpha: 0.0),
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.7)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(32),
                                boxShadow: [
                                  BoxShadow(
                                    color: palette.brandPrimary.withValues(alpha: 0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Icon(
                                step.icon,
                                size: 56,
                                color: palette.textForeground,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          step.title,
                          style: textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: palette.textPrimary,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          step.description,
                          style: textTheme.bodyLarge?.copyWith(
                            color: palette.textSecondary,
                            height: 1.6,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dots indicator
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  steps.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? palette.brandPrimary
                          : palette.brandPrimary.withAlpha(60),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),

            // Next / Get Started button
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: isLoading ? null : onNext,
                  style: FilledButton.styleFrom(
                    backgroundColor: palette.brandPrimary,
                    foregroundColor: palette.textForeground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    currentPage < steps.length - 1
                        ? context.t.ui.common.next
                        : context.t.ui.common.getStarted,
                    style: textTheme.titleMedium?.copyWith(
                      color: palette.textForeground,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
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
        icon: Icons.school_outlined,
        title: context.t.onboarding.steps.learn.title,
        description: context.t.onboarding.steps.learn.description,
      ),
      _OnboardingStep(
        icon: Icons.trending_up_outlined,
        title: context.t.onboarding.steps.trackProgress.title,
        description: context.t.onboarding.steps.trackProgress.description,
      ),
      _OnboardingStep(
        icon: Icons.quiz_outlined,
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
