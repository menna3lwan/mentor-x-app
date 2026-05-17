import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

/// Section card used in profile/settings — a small uppercase heading + a
/// rounded container that wraps its children with no internal padding so
/// individual tiles control their own.
class ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ProfileSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: context.textTertiaryColor,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.08),
            ),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
