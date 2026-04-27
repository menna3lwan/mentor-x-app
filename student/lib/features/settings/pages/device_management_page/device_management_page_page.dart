import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

import 'bloc/device_management_page_bloc.dart';

final class DeviceManagementPagePage extends StatelessWidget {
  final DeviceManagementPageState state;
  final VoidCallback onRefresh;
  final ValueChanged<String> onDeactivateTapped;

  const DeviceManagementPagePage({
    super.key,
    required this.state,
    required this.onRefresh,
    required this.onDeactivateTapped,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: palette.textPrimary,
            centerTitle: true,
            title: const Text(
              'Device Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.5),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.loadingState.isError
                ? _buildError(palette)
                : _buildLoaded(context, palette),
      ),
    );
  }

  Widget _buildError(MentorXThemeColorPalette palette) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const Gap(120),
        ZoomIn(
          duration: const Duration(milliseconds: 500),
          child: Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: palette.statusDanger,
          ),
        ),
        const Gap(16),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: Text(
            state.errorMessage ?? 'Unable to load devices.',
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.statusDanger, fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ),
        const Gap(8),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 100),
          child: Text(
            'Pull down to try again.',
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildLoaded(BuildContext context, MentorXThemeColorPalette palette) {
    if (state.devices.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const Gap(120),
          ZoomIn(
            duration: const Duration(milliseconds: 600),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: palette.backgroundPrimary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.devices_other_rounded,
                size: 80,
                color: palette.textTertiary.withValues(alpha: 0.3),
              ),
            ),
          ),
          const Gap(24),
          FadeInUp(
            duration: const Duration(milliseconds: 500),
            child: Text(
              'No registered devices',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: palette.textPrimary,
                  ),
            ),
          ),
          const Gap(10),
          FadeInUp(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 100),
            child: Text(
              'Your active login sessions will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: state.devices.length,
      separatorBuilder: (_, _) => const Gap(16),
      itemBuilder: (context, index) {
        final device = state.devices[index];
        final isDeactivating = state.deactivatingDeviceIds.contains(device.id);

        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: palette.backgroundPrimary,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ZoomIn(
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: palette.brandPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          _getDeviceIcon(device.deviceType),
                          color: palette.brandPrimary,
                          size: 24,
                        ),
                      ),
                    ),
                    const Gap(14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            device.deviceName,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: palette.textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            device.deviceModel,
                            style: TextStyle(
                              color: palette.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _StatusChip(isActive: device.isActive),
                  ],
                ),
                const Gap(16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _MetaPill(
                      icon: Icons.access_time_rounded,
                      label: 'Last used ${_formatDate(device.lastUsedAt)}',
                    ),
                    if (device.osVersion != null && device.osVersion!.isNotEmpty)
                      _MetaPill(
                        icon: Icons.settings_cell_rounded,
                        label: 'OS ${device.osVersion}',
                      ),
                    if (device.appVersion != null && device.appVersion!.isNotEmpty)
                      _MetaPill(
                        icon: Icons.verified_rounded,
                        label: 'App v${device.appVersion}',
                      ),
                  ],
                ),
                const Gap(20),
                SizedBox(
                  width: double.infinity,
                  child: MentorXButton(
                    onPressed: !device.isActive || isDeactivating ? null : () => onDeactivateTapped(device.id),
                    label: device.isActive ? 'Deactivate Device' : 'Deactivated',
                    loading: isDeactivating,
                    color: palette.statusDanger,
                    variant: MentorXButtonVariant.outline,
                    icon: Icons.power_settings_new_rounded,
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
    if (type == 'desktop' || type == 'web') return Icons.desktop_windows_rounded;
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
    final palette = MentorXThemeColorPalette.light;
    final color = isActive ? palette.statusSuccess : palette.textTertiary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 11,
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
    final palette = MentorXThemeColorPalette.light;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: palette.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: palette.textTertiary),
          const Gap(8),
          Text(
            label,
            style: TextStyle(
              color: palette.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
