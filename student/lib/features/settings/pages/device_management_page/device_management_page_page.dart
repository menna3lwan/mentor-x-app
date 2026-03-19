import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

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
      appBar: AppBar(title: const Text('Device Management')),
      body: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.loadingState.isError
            ? ListView(
                children: [
                  const SizedBox(height: 120),
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: palette.statusDanger,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.errorMessage ?? 'Unable to load devices.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: palette.statusDanger),
                  ),
                ],
              )
            : _buildLoaded(context, palette),
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, MentorXThemeColorPalette palette) {
    if (state.devices.isEmpty) {
      return ListView(
        children: [
          const SizedBox(height: 120),
          Icon(
            Icons.devices_other_outlined,
            size: 68,
            color: palette.textSecondary,
          ),
          const SizedBox(height: 12),
          Text(
            'No registered devices.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Your active sessions will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(color: palette.textSecondary),
          ),
        ],
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.devices.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final device = state.devices[index];
        final isDeactivating = state.deactivatingDeviceIds.contains(device.id);

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: palette.backgroundPrimary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: palette.brandTertiary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.smartphone, color: palette.brandPrimary),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          device.deviceName,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          device.deviceModel,
                          style: TextStyle(color: palette.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  _StatusChip(isActive: device.isActive),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _MetaPill(
                    label: 'Last used ${_formatDate(device.lastUsedAt)}',
                  ),
                  if (device.osVersion != null && device.osVersion!.isNotEmpty)
                    _MetaPill(label: 'OS ${device.osVersion}'),
                  if (device.appVersion != null &&
                      device.appVersion!.isNotEmpty)
                    _MetaPill(label: 'App ${device.appVersion}'),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: !device.isActive || isDeactivating
                      ? null
                      : () => onDeactivateTapped(device.id),
                  icon: isDeactivating
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.power_settings_new_outlined),
                  label: Text(
                    device.isActive ? 'Deactivate Device' : 'Already Inactive',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
    final color = isActive ? palette.statusSuccess : palette.textSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

final class _MetaPill extends StatelessWidget {
  final String label;

  const _MetaPill({required this.label});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: palette.backgroundSecondary,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: palette.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
