import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class HomePagePage extends StatelessWidget {
  final Widget appBar;
  final Widget content;
  final Future<void> Function() onRefresh;

  const HomePagePage({
    super.key,
    required this.appBar,
    required this.content,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return AppDashboardScaffold(
      title: 'MentorX',
      onRefresh: onRefresh,
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBar,
                  const Gap(24),
                  content,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -120,
          right: -80,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.15),
            size: 400,
          ),
        ),
        Positioned(
          top: 250,
          left: -180,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.1),
            size: 450,
          ),
        ),
        Positioned(
          bottom: 100,
          right: -150,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 380,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
