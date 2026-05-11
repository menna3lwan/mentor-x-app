import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class AiFabButton extends StatelessWidget {
  const AiFabButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/ai-chat'),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.brandSecondaryColor,
              context.brandSecondaryColor.withValues(alpha: 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: context.brandSecondaryColor.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: context.brandSecondaryColor.withValues(alpha: 0.2),
              blurRadius: 40,
              spreadRadius: -5,
            ),
          ],
        ),
        child: const Icon(
          Icons.psychology_rounded,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
