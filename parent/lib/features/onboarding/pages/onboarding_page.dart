import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/theme/parent_colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<_OnboardingSlide> _slides(BuildContext context) {
    final t = Translations.of(context).parent.onboarding;
    return [
      _OnboardingSlide(
        title: t.slide1Title,
        description: t.slide1Description,
        icon: Icons.analytics_rounded,
        color: ParentColors.slideIndigo,
      ),
      _OnboardingSlide(
        title: t.slide2Title,
        description: t.slide2Description,
        icon: Icons.chat_bubble_rounded,
        color: ParentColors.slideGreen,
      ),
      _OnboardingSlide(
        title: t.slide3Title,
        description: t.slide3Description,
        icon: Icons.account_balance_wallet_rounded,
        color: ParentColors.slideAmber,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    final slides = _slides(context);
    final activeSlide = slides[_currentPage];

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          // Background tinted blob that follows the active slide color.
          Positioned(
            top: -100,
            right: -100,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: activeSlide.color.withValues(alpha: 0.05),
              ),
            ),
          ),

          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    final slide = slides[index];
                    return Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: slide.color.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(slide.icon, size: 80, color: slide.color),
                          ),
                          const SizedBox(height: 60),
                          Text(
                            slide.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: context.textPrimaryColor,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            slide.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: context.textSecondaryColor,
                              height: 1.6,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Indicator + CTA section
              Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(slides.length, (index) {
                        final isActive = index == _currentPage;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: isActive ? 24 : 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isActive
                                ? activeSlide.color
                                : context.textTertiaryColor.withValues(
                                    alpha: 0.2,
                                  ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 40),
                    if (_currentPage == slides.length - 1)
                      MentorXButton(
                        onPressed: () => const LoginPageRoute().go(context),
                        label: t.onboarding.getStarted,
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () =>
                                _pageController.jumpToPage(slides.length - 1),
                            child: Text(
                              t.onboarding.skip,
                              style: TextStyle(
                                color: context.textTertiaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          _NextButton(
                            color: activeSlide.color,
                            onTap: () => _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  const _NextButton({required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

class _OnboardingSlide {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _OnboardingSlide({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
