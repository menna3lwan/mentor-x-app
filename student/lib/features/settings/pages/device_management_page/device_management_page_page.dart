import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'bloc/device_management_page_bloc.dart';

final class DeviceManagementPagePage extends StatelessWidget {
  final VoidCallback onRefresh;
  final ValueChanged<String> onDeactivateTapped;

  const DeviceManagementPagePage({
    super.key,
    required this.onRefresh,
    required this.onDeactivateTapped,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return BlocBuilder<DeviceManagementPageBloc, DeviceManagementPageState>(
      builder: (context, state) {
        final isLoading = state.isLoading;
        final isError = state.loadingState.isError;

        return Scaffold(
          backgroundColor: context.backgroundPrimaryColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Container(
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(28),
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: context.borderPrimaryColor.withValues(alpha: 0.05),
                    ),
                  ),
                ),
                child: MentorXAppBar(
                  backgroundColor: Colors.transparent,
                  titleText: t['deviceManagement'] ?? 'Device Management',
                ),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async => onRefresh(),
            color: context.brandPrimaryColor,
            backgroundColor: context.backgroundSecondaryColor,
            child: isLoading
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    itemCount: 3,
                    separatorBuilder: (_, _) => const Gap(16),
                    itemBuilder: (_, _) => const MentorXSkeleton(height: 220, borderRadius: 28),
                  )
                : isError
                ? AppErrorView(
                    message: state.errorMessage ?? 'Unable to load devices.',
                    onRetry: onRefresh,
                  )
                : _buildLoaded(context, state),
          ),
        );
      },
    );
  }


  Widget _buildLoaded(BuildContext context, DeviceManagementPageState state) {
    final devices = state.devices;
    if (devices.isEmpty) {
      return AppEmptyView(
        title: 'No registered devices',
        message: 'Your active login sessions will appear here.',
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
        final isDeactivating = state.deactivatingDeviceIds.contains(device.id);

        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
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
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: context.textPrimaryColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            device.deviceModel,
                            style: TextStyle(
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
                      label: 'Last used ${_formatDate(device.lastUsedAt)}',
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
                        ? 'Deactivate Device'
                        : 'Deactivated',
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
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
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
        color: context.backgroundPrimaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: context.textTertiaryColor),
          const Gap(8),
          Text(
            label,
            style: TextStyle(
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
