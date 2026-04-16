import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../bloc/onboarding_bloc.dart';

final class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

final class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _controller;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = const [
      (
        title: 'Track Your Child\'s Learning',
        subtitle:
            'Follow learning progress, grades, and course activity daily.',
      ),
      (
        title: 'Stay Informed in Real-Time',
        subtitle:
            'Get instant updates for grades, attendance, and announcements.',
      ),
      (
        title: 'Monitor Attendance and Spending',
        subtitle:
            'Review attendance history and wallet transactions in one place.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<OnboardingBloc>().add(const OnboardingCompleted());
              const LoginPageRoute().go(context);
            },
            child: const Text('Skip'),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          final isLast = _pageIndex == pages.length - 1;
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school, size: 88, color: Colors.blue.shade400),
                const SizedBox(height: 24),
                Text(
                  page.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  page.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 28),
                FilledButton(
                  onPressed: () {
                    if (!isLast) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeInOut,
                      );
                      return;
                    }
                    context.read<OnboardingBloc>().add(
                      const OnboardingCompleted(),
                    );
                    const LoginPageRoute().go(context);
                  },
                  child: Text(isLast ? 'Get Started' : 'Next'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
