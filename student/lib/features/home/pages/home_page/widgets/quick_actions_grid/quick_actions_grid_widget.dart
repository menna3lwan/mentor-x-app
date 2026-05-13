import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';

final class QuickActionsGridWidget extends StatelessWidget {
  final ValueChanged<int>? onActionTap;

  const QuickActionsGridWidget({super.key, this.onActionTap});

  @override
  Widget build(BuildContext context) {
    final actions = [
      (context.t.home.dashboard.actions.myCourses, Icons.menu_book_rounded),
      (
        context.t.home.dashboard.actions.attendance,
        Icons.qr_code_scanner_rounded,
      ),
      (context.t.home.dashboard.actions.grades, Icons.grading_rounded),
      (context.t.home.dashboard.actions.aiAssistant, Icons.smart_toy_rounded),
      (context.t.home.dashboard.actions.assignments, Icons.assignment_rounded),
      (context.t.home.dashboard.actions.rewards, Icons.emoji_events_rounded),
      (context.t.home.dashboard.actions.marketplace, Icons.storefront_rounded),
      (
        context.t.home.dashboard.actions.analytics,
        Icons.bar_chart_rounded,
      ),
    ];

    return GridView.builder(
      itemCount: actions.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.8,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];
        return GestureDetector(
          onTap: () => onActionTap?.call(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: context.borderPrimaryColor.withValues(alpha: 0.08),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.brandPrimaryColor.withValues(alpha: 0.15),
                              context.brandPrimaryColor.withValues(alpha: 0.02),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.brandPrimaryColor.withValues(alpha: 0.05),
                          ),
                        ),
                        child: Icon(
                          action.$2,
                          color: context.brandPrimaryColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(10),
              Text(
                action.$1,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.textPrimaryColor,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
