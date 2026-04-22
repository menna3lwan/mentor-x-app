import 'package:flutter/material.dart';
import '../../../core/routing/app_routes.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to MentorX Parent',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('The best way to track your child\'s progress.'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                const LoginPageRoute().go(context);
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
