import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

/// Shown on the parent home when the parent hasn't linked any children yet.
class NoChildrenLinkedState extends StatelessWidget {
  final String title;
  final String hint;
  final String actionLabel;
  final VoidCallback onLinkChildPressed;

  const NoChildrenLinkedState({
    super.key,
    required this.title,
    required this.hint,
    required this.actionLabel,
    required this.onLinkChildPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.brandPrimaryColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.family_restroom_rounded,
                size: 48,
                color: context.brandPrimaryColor,
              ),
            ),
            const Gap(20),
            Text(
              title,
              style: TextStyle(
                color: context.textPrimaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 20,
                letterSpacing: -0.5,
              ),
            ),
            const Gap(8),
            Text(
              hint,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textSecondaryColor,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const Gap(24),
            MentorXButton(
              onPressed: onLinkChildPressed,
              label: actionLabel,
              icon: Icons.add_link_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
