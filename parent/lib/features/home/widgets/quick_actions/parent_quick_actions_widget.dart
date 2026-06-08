import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';

/// One entry in the quick-actions grid.
class ParentQuickAction {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool enabled;

  const ParentQuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.enabled = true,
  });
}

/// Glass-style 4×N grid of dashboard shortcuts. Matches the Student app's
/// `QuickActionsGridWidget` styling so both apps feel identical here.
class ParentQuickActionsWidget extends StatelessWidget {
  final List<ParentQuickAction> actions;

  const ParentQuickActionsWidget({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    // 4 columns on phones, 5 on small tablets, 6+ on bigger tablets so the
    // grid keeps the same visual rhythm regardless of screen width.
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = switch (width) {
      < 360 => 4,
      < 600 => 4,
      < 900 => 5,
      _ => 6,
    };

    return GridView.builder(
      itemCount: actions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.78,
        mainAxisSpacing: 20,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];
        final disabled = !action.enabled || action.onTap == null;

        return Opacity(
          opacity: disabled ? 0.45 : 1.0,
          child: GestureDetector(
            onTap: disabled ? null : action.onTap,
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: context.backgroundSecondaryColor.withValues(
                      alpha: 0.45,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: context.borderPrimaryColor.withValues(alpha: 0.1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                context.brandPrimaryColor.withValues(
                                  alpha: 0.2,
                                ),
                                context.brandPrimaryColor.withValues(
                                  alpha: 0.05,
                                ),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: context.brandPrimaryColor.withValues(
                                alpha: 0.1,
                              ),
                            ),
                          ),
                          child: Icon(
                            action.icon,
                            color: context.brandPrimaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(12),
                Text(
                  action.label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: context.textPrimaryColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.2,
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
