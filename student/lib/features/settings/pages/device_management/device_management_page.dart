import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

final class DeviceManagementPagePage extends StatelessWidget {
  final bool isLoading;
  final LoadingState loadingState;
  final String? errorMessage;
  final List<DeviceEntity> devices;
  final Set<String> deactivatingDeviceIds;
  final VoidCallback onRefresh;
  final ValueChanged<String> onDeactivateTapped;

  const DeviceManagementPagePage({
    super.key,
    required this.isLoading,
    required this.loadingState,
    this.errorMessage,
    required this.devices,
    required this.deactivatingDeviceIds,
    required this.onRefresh,
    required this.onDeactivateTapped,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.settings;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _buildHeader(context, t),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => onRefresh(),
              color: context.brandPrimaryColor,
              backgroundColor: context.backgroundSecondaryColor,
              child: isLoading
                  ? ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      itemCount: 3,
                      separatorBuilder: (_, _) => const Gap(16),
                      itemBuilder: (_, _) =>
                          const MentorXSkeleton(height: 220, borderRadius: 28),
                    )
                  : loadingState.isError
                  ? AppErrorView(
                      message: errorMessage ?? t.unableToLoadDevices,
                      onRetry: onRefresh,
                    )
                  : _buildLoaded(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.settingsLabel,
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.deviceManagement,
                      style: context.titleH1Style.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoaded(BuildContext context) {
    final t = context.t.settings;
    if (devices.isEmpty) {
      return AppEmptyView(
        title: t.noRegisteredDevices,
        message: t.activeSessionsDesc,
        icon: Icons.devices_other_rounded,
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      itemCount: devices.length,
      separatorBuilder: (_, _) => const Gap(16),
      itemBuilder: (context, index) {
        final device = devices[index];
        final isDeactivating = deactivatingDeviceIds.contains(device.id);

        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: MentorXGlassCard(
            style: Style(
              $box.padding.all(20),
              $box.borderRadius(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: context.brandPrimaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: context.brandPrimaryColor.withValues(
                            alpha: 0.2,
                          ),
                        ),
                      ),
                      child: Icon(
                        _getDeviceIcon(device.deviceType),
                        color: context.brandPrimaryColor,
                        size: 26,
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            device.deviceName,
                            style: context.bodyPrimaryStyle.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            device.deviceModel,
                            style: context.bodySecondaryStyle.copyWith(
                              color: context.textTertiaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _StatusChip(isActive: device.isActive),
                  ],
                ),
                const Gap(20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _MetaPill(
                      icon: Icons.access_time_rounded,
                      label: t.lastUsedAt(date: _formatDate(device.lastUsedAt)),
                    ),
                    if (device.osVersion != null &&
                        device.osVersion!.isNotEmpty)
                      _MetaPill(
                        icon: Icons.settings_cell_rounded,
                        label: 'OS ${device.osVersion}',
                      ),
                    if (device.appVersion != null &&
                        device.appVersion!.isNotEmpty)
                      _MetaPill(
                        icon: Icons.verified_rounded,
                        label: 'App v${device.appVersion}',
                      ),
                  ],
                ),
                const Gap(24),
                SizedBox(
                  width: double.infinity,
                  child: MentorXButton(
                    onPressed: !device.isActive || isDeactivating
                        ? null
                        : () => onDeactivateTapped(device.id),
                    label: device.isActive
                        ? t.deactivateDevice
                        : t.deactivatedLabel,
                    loading: isDeactivating,
                    color: context.backgroundPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getDeviceIcon(String? type) {
    type = type?.toLowerCase();
    if (type == 'tablet') return Icons.tablet_android_rounded;
    if (type == 'desktop' || type == 'web') {
      return Icons.desktop_windows_rounded;
    }
    return Icons.smartphone_rounded;
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM, hh:mm a').format(date);
  }
}

final class _StatusChip extends StatelessWidget {
  final bool isActive;

  const _StatusChip({required this.isActive});

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? context.statusSuccessColor
        : context.textTertiaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        isActive
            ? context.t.settings.activeLabel
            : context.t.settings.inactiveLabel,
        style: context.bodySecondaryStyle.copyWith(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: 10,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

final class _MetaPill extends StatelessWidget {
  final String label;
  final IconData icon;

  const _MetaPill({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: context.textTertiaryColor),
          const Gap(8),
          Text(
            label,
            style: context.bodySecondaryStyle.copyWith(
              color: context.textSecondaryColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
