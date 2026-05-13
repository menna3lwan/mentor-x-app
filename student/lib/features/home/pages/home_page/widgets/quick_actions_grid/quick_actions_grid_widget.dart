
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';

final class QuickActionsGridWidget extends StatelessWidget {
  final ValueChanged<int>? onActionTap;

  const QuickActionsGridWidget({super.key, this.onActionTap});

  @override
  Widget build(BuildContext context) {
    final actions = [
      (context.t.home.dashboard.actions.myCourses, Icons.auto_stories_rounded),
      (
        context.t.home.dashboard.actions.attendance,
        Icons.fact_check_rounded,
      ),
      (context.t.home.dashboard.actions.grades, Icons.workspace_premium_rounded),
      (context.t.home.dashboard.actions.aiAssistant, Icons.psychology_rounded),
      (context.t.home.dashboard.actions.assignments, Icons.task_rounded),
      (context.t.home.dashboard.actions.rewards, Icons.redeem_rounded),
      (context.t.home.dashboard.actions.marketplace, Icons.shopping_bag_rounded),
      (
        context.t.home.dashboard.actions.analytics,
        Icons.insights_rounded,
      ),
    ];

    return GridView.builder(
      itemCount: actions.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75,
        mainAxisSpacing: 12,
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
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.borderPrimaryColor.withValues(alpha: 0.1),
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: context.brandPrimaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      action.$2,
                      color: context.brandPrimaryColor,
                      size: 22,
                    ),
                  ),
                ),
              ),
              const Gap(8),
              Text(
                action.$1,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.textPrimaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
