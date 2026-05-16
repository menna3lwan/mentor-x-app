import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';


final class AnalyticsSectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;
  final VoidCallback? onTap;

  const AnalyticsSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: MentorXGlassCard(
        borderRadius: BorderRadius.circular(32),
        opacity: 0.12,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(32),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: context.titleH3Style.copyWith(
                        color: context.textPrimaryColor,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    if (trailing != null) trailing!,
                  ],
                ),
                const Gap(24),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
