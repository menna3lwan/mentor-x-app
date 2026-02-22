import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class QuickActionsGridWidget extends StatelessWidget {
  const QuickActionsGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final actions = [
      (context.t.home.dashboard.actions.myCourses, Icons.menu_book_rounded),
      (
        context.t.home.dashboard.actions.attendance,
        Icons.qr_code_scanner_rounded
      ),
      (context.t.home.dashboard.actions.grades, Icons.grading_rounded),
      (context.t.home.dashboard.actions.aiAssistant, Icons.smart_toy_rounded),
      (context.t.home.dashboard.actions.rewards, Icons.emoji_events_rounded),
      (context.t.home.dashboard.actions.marketplace, Icons.storefront_rounded),
    ];
    return GridView.builder(
      itemCount: actions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];
        return Material(
          color: palette.backgroundPrimary,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: palette.brandTertiary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(action.$2, color: palette.brandPrimary),
                ),
                const SizedBox(height: 8),
                Text(
                  action.$1,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: palette.textPrimary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
