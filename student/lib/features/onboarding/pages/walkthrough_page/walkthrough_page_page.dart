import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class WalkthroughPagePage extends StatefulWidget {
  final VoidCallback onComplete;
  final VoidCallback onSkip;

  const WalkthroughPagePage({
    super.key,
    required this.onComplete,
    required this.onSkip,
  });

  @override
  State<WalkthroughPagePage> createState() => _WalkthroughPagePageState();
}

final class _WalkthroughPagePageState extends State<WalkthroughPagePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const _steps = [
    _OnboardingStep(
      icon: Icons.school_outlined,
      title: 'Learn',
      description:
          'Access your lessons, courses, and educational materials all in one place.',
    ),
    _OnboardingStep(
      icon: Icons.trending_up_outlined,
      title: 'Track Progress',
      description:
          'Monitor your academic performance and track your growth over time.',
    ),
    _OnboardingStep(
      icon: Icons.quiz_outlined,
      title: 'Quizzes',
      description:
          'Test your knowledge with interactive quizzes and get instant feedback.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final textTheme = Theme.of(context).textTheme;

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
                  onPressed: widget.onSkip,
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
                controller: _pageController,
                itemCount: _steps.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final step = _steps[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: palette.brandPrimary.withAlpha(25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            step.icon,
                            size: 72,
                            color: palette.brandPrimary,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          step.title,
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: palette.brandPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          step.description,
                          style: textTheme.bodyLarge?.copyWith(
                            color: palette.textSecondary,
                            height: 1.5,
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
                  _steps.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
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
                  onPressed: _onNext,
                  style: FilledButton.styleFrom(
                    backgroundColor: palette.brandPrimary,
                    foregroundColor: palette.textForeground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentPage < _steps.length - 1
                        ? context.t.ui.common.next
                        : context.t.ui.common.getStarted,
                    style: textTheme.titleMedium?.copyWith(
                      color: palette.textForeground,
                      fontWeight: FontWeight.w600,
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
