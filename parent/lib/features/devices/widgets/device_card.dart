import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

/// Renders one [DeviceEntity] as a card with platform icon, name, last-seen
/// timestamp, and an optional "Sign out" CTA. The current device is marked
/// with a primary-coloured chip and never shows the revoke button.
class DeviceCard extends StatelessWidget {
  final DeviceEntity device;
  final bool isCurrent;
  final bool isDeactivating;
  final String currentBadgeLabel;
  final String activeBadgeLabel;
  final String inactiveBadgeLabel;
  final String lastUsedLabel;
  final String revokeLabel;
  final VoidCallback? onRevoke;

  const DeviceCard({
    super.key,
    required this.device,
    required this.isCurrent,
    required this.isDeactivating,
    required this.currentBadgeLabel,
    required this.activeBadgeLabel,
    required this.inactiveBadgeLabel,
    required this.lastUsedLabel,
    required this.revokeLabel,
    this.onRevoke,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCurrent
        ? context.brandPrimaryColor
        : (device.isActive
              ? context.statusSuccessColor
              : context.textTertiaryColor);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withValues(alpha: isCurrent ? 0.35 : 0.12),
          width: isCurrent ? 1.4 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(_iconFor(device), color: color, size: 22),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.deviceName.isEmpty
                          ? device.deviceModel
                          : device.deviceName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.textPrimaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    if (device.deviceModel.isNotEmpty) ...[
                      const Gap(2),
                      Text(
                        device.deviceModel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: context.textSecondaryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Gap(8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  isCurrent
                      ? currentBadgeLabel
                      : (device.isActive
                            ? activeBadgeLabel
                            : inactiveBadgeLabel),
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const Gap(12),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            children: [
              if (device.osVersion != null && device.osVersion!.isNotEmpty)
                _MetaChip(
                  icon: Icons.memory_rounded,
                  text: device.osVersion!,
                ),
              if (device.appVersion != null && device.appVersion!.isNotEmpty)
                _MetaChip(
                  icon: Icons.tag_rounded,
                  text: device.appVersion!,
                ),
              _MetaChip(
                icon: Icons.access_time_rounded,
                text: lastUsedLabel,
              ),
            ],
          ),
          if (!isCurrent && device.isActive && onRevoke != null) ...[
            const Gap(12),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton.icon(
                onPressed: isDeactivating ? null : onRevoke,
                style: TextButton.styleFrom(
                  foregroundColor: context.statusDangerColor,
                ),
                icon: isDeactivating
                    ? SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: context.statusDangerColor,
                        ),
                      )
                    : Icon(
                        Icons.logout_rounded,
                        size: 16,
                        color: context.statusDangerColor,
                      ),
                label: Text(
                  revokeLabel,
                  style: TextStyle(
                    color: context.statusDangerColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _iconFor(DeviceEntity d) {
    final type = (d.deviceType ?? '').toLowerCase();
    final model = d.deviceModel.toLowerCase();
    if (type.contains('ios') ||
        model.contains('iphone') ||
        model.contains('apple')) {
      return Icons.phone_iphone_rounded;
    }
    if (type.contains('android')) return Icons.phone_android_rounded;
    if (type.contains('web') || model.contains('browser')) {
      return Icons.laptop_chromebook_rounded;
    }
    return Icons.devices_rounded;
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String text;
  const _MetaChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: context.textTertiaryColor),
        const Gap(4),
        Text(
          text,
          style: TextStyle(
            color: context.textTertiaryColor,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// Helper used by the page to produce a human-readable "last used" label
/// (e.g. "5m ago", "Yesterday", "May 12 · 3:24 PM"). Kept here so the page
/// stays focused on layout.
String describeLastUsed(DateTime lastUsed, {required DateTime now}) {
  final diff = now.difference(lastUsed);
  if (diff.inMinutes < 1) return 'just now';
  if (diff.inHours < 1) return '${diff.inMinutes}m ago';
  if (diff.inDays < 1) return '${diff.inHours}h ago';
  if (diff.inDays == 1) return 'yesterday';
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  return DateFormat.yMMMd().format(lastUsed);
}
