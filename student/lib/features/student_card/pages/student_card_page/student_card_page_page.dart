import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class StudentCardPage extends StatelessWidget {
  final Widget appBar;
  final Widget content;

  const StudentCardPage({
    super.key,
    required this.appBar,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              appBar,
              SliverFillRemaining(
                hasScrollBody: false,
                child: content,
              ),
            ],
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
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
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
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
      ),
    );
  }
}
