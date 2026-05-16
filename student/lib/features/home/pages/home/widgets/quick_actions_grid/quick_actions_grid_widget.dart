import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';

final class QuickActionsGridWidget extends StatelessWidget {
  final ValueChanged<int>? onActionTap;

  const QuickActionsGridWidget({super.key, this.onActionTap});

  @override
  Widget build(BuildContext context) {
    final actions = [
      (
        context.t.home.dashboard.myCourses,
        Icons.auto_stories_rounded,
        context.brandPrimaryColor,
      ),
      (
        context.t.home.dashboard.attendance,
        Icons.fact_check_rounded,
        context.brandSecondaryColor,
      ),
      (
        context.t.home.dashboard.grades,
        Icons.workspace_premium_rounded,
        Colors.orange,
      ),
      (
        context.t.home.dashboard.aiAssistant,
        Icons.psychology_rounded,
        Colors.purple,
      ),
      (context.t.home.dashboard.assignments, Icons.task_rounded, Colors.teal),
      (context.t.home.dashboard.rewards, Icons.redeem_rounded, Colors.pink),
      (
        context.t.home.dashboard.marketplace,
        Icons.shopping_bag_rounded,
        Colors.indigo,
      ),
      (
        context.t.home.dashboard.analytics,
        Icons.insights_rounded,
        context.brandPrimaryColor,
      ),
      (
        context.t.home.dashboard.leaderboard,
        Icons.emoji_events_rounded,
        context.brandSecondaryColor,
      ),
    ];

    return GridView.builder(
      itemCount: actions.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.1,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];
        return PressableBox(
          onPress: () => onActionTap?.call(index),
          style: Style(
            $box.padding.all(16),
            $box.borderRadius(24),
            $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.4)),
            $box.border.all.color(
              context.borderPrimaryColor.withValues(alpha: 0.1),
            ),
            $on.hover(
              $box.color(
                context.backgroundSecondaryColor.withValues(alpha: 0.7),
              ),
              $box.shadows(context.softShadow),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      action.$3.withValues(alpha: 0.2),
                      action.$3.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  action.$2,
                  color: action.$3,
                  size: 24,
                ),
              ),
              const Gap(10),
              Text(
                action.$1,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.bodyPrimaryStyle.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
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
