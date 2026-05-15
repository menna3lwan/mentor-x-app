import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';

/// Single row in the linked-children list. Shows the child avatar, name,
/// student id, optional grade/center info, and an unlink trailing button.
/// Purely presentational — the wrapper provides the callbacks.
class ChildManagementCardWidget extends StatelessWidget {
  final ParentChildEntity child;
  final VoidCallback? onUnlinkPressed;
  final bool unlinkingInProgress;
  final String studentIdLabel;
  final String? gradeLabel;
  final String? centerLabel;
  final String unlinkLabel;

  const ChildManagementCardWidget({
    super.key,
    required this.child,
    required this.onUnlinkPressed,
    required this.unlinkingInProgress,
    required this.studentIdLabel,
    required this.unlinkLabel,
    this.gradeLabel,
    this.centerLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.brandPrimaryColor.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: context.backgroundTertiaryColor,
              backgroundImage: child.profileImageUrl != null
                  ? NetworkImage(child.profileImageUrl!)
                  : null,
              child: child.profileImageUrl == null
                  ? Icon(
                      Icons.person_rounded,
                      color: context.brandPrimaryColor,
                      size: 32,
                    )
                  : null,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  child.name.isEmpty ? '—' : child.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.3,
                  ),
                ),
                const Gap(4),
                Text(
                  studentIdLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textTertiaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (gradeLabel != null || centerLabel != null) ...[
                  const Gap(8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (gradeLabel != null)
                        _MetaChip(label: gradeLabel!, icon: Icons.school_rounded),
                      if (centerLabel != null)
                        _MetaChip(
                          label: centerLabel!,
                          icon: Icons.location_city_rounded,
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const Gap(8),
          if (unlinkingInProgress)
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(context.brandPrimaryColor),
              ),
            )
          else
            IconButton(
              tooltip: unlinkLabel,
              onPressed: onUnlinkPressed,
              icon: Icon(
                Icons.link_off_rounded,
                color: context.statusDangerColor,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _MetaChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.backgroundTertiaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: context.textSecondaryColor),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
