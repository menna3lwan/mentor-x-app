import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class OnboardingPage extends StatefulWidget {
  final VoidCallback onCompleted;

  const OnboardingPage({
    super.key,
    required this.onCompleted,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _slides = [
    _OnboardingData(
      title: 'Monitor Progress',
      description: 'Keep track of your child\'s grades, attendance, and academic achievements in real-time.',
      icon: Icons.analytics_rounded,
      color: const Color(0xFF6366F1),
    ),
    _OnboardingData(
      title: 'Stay Connected',
      description: 'Direct communication with teachers and school administration for a better learning experience.',
      icon: Icons.chat_bubble_rounded,
      color: const Color(0xFF10B981),
    ),
    _OnboardingData(
      title: 'Secure Payments',
      description: 'Manage school fees and your child\'s wallet balance safely and conveniently.',
      icon: Icons.account_balance_wallet_rounded,
      color: const Color(0xFFF59E0B),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Gradient blobs
          Positioned(
            top: -100,
            right: -100,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _slides[_currentPage].color.withValues(alpha: 0.05),
              ),
            ),
          ),
          
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Padding(
                      padding: const EdgeInsets.all(40.0),
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
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: context.textPrimaryColor,
                              letterSpacing: -1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            slide.description,
                            style: TextStyle(
                              fontSize: 16,
                              color: context.textSecondaryColor,
                              height: 1.6,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              // Bottom Section
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    // Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_slides.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: index == _currentPage ? 24 : 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: index == _currentPage 
                                ? _slides[_currentPage].color 
                                : context.textTertiaryColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 40),
                    
                    if (_currentPage == _slides.length - 1)
                      MentorXButton(
                        onPressed: widget.onCompleted,
                        label: 'Get Started',
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => _pageController.jumpToPage(_slides.length - 1),
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: context.textTertiaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: _slides[_currentPage].color,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: _slides[_currentPage].color.withValues(alpha: 0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 20),
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

class _OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  _OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
