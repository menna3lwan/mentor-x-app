import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class QuickActionsGridWidget extends StatelessWidget {
  final ValueChanged<int>? onActionTap;

  const QuickActionsGridWidget({super.key, this.onActionTap});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
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
    ];
    return GridView.builder(
      itemCount: actions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];
        return InkWell(
          onTap: () => onActionTap?.call(index),
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: palette.backgroundPrimary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: palette.textPrimary.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: palette.brandTertiary.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      action.$2,
                      color: palette.brandPrimary,
                      size: 26,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                action.$1,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: palette.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
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
