import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class SplashPagePage extends StatefulWidget {
  const SplashPagePage({super.key});

  @override
  State<SplashPagePage> createState() => _SplashPagePageState();
}

final class _SplashPagePageState extends State<SplashPagePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              palette.brandPrimary.withAlpha(220),
              palette.brandPrimary,
              palette.brandPrimary.withAlpha(180),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fadeIn,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/images/Logo-WithoutBackground.png',
                      width: 140,
                      height: 140,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    context.t.core.appName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: palette.textForeground,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      minHeight: 4,
                      backgroundColor: palette.textForeground.withAlpha(60),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
