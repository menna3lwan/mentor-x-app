import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/devices_bloc.dart';
import '../widgets/device_card.dart';

/// Devices & Sessions surface. Lists every device bound to the parent
/// account and exposes per-device revoke + a global force-logout button.
class DevicesPageWrapper extends StatelessWidget {
  const DevicesPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DevicesBloc(
        repository: context.read<ParentDevicesRepository>(),
      )..add(const DevicesStarted()),
      child: const _DevicesView(),
    );
  }
}

class _DevicesView extends StatelessWidget {
  const _DevicesView();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocPresentationListener<DevicesBloc, DevicesPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case DevicesLoadFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
          case DevicesForceLogoutSucceededPresentationEvent():
            MentorXUI.showToast(
              message: t.devices.forceLogoutSuccess,
            );
          case DevicesForceLogoutFailedPresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
          case DeviceDeactivatedPresentationEvent():
            MentorXUI.showToast(message: t.devices.revokeSuccess);
          case DeviceDeactivationFailedPresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
          case DevicesUnauthorizedPresentationEvent():
            context.read<AppAuthenticationCubit>().logout();
            const LoginPageRoute().go(context);
        }
      },
      child: Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        appBar: AppBar(
          backgroundColor: context.backgroundSecondaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: context.textPrimaryColor,
              size: 20,
            ),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                const SettingsRoute().go(context);
              }
            },
          ),
          title: Text(
            t.devices.pageTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: context.brandPrimaryColor,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async => context.read<DevicesBloc>().add(
            const DevicesRefreshRequested(),
          ),
          child: BlocBuilder<DevicesBloc, DevicesState>(
            builder: (context, state) => _body(context, state, t),
          ),
        ),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    DevicesState state,
    TranslationsParentEn t,
  ) {
    if (state.status.isInitial || state.status.isLoading) {
      return ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          MentorXSkeleton(
            width: double.infinity,
            height: 96,
            borderRadius: 18,
          ),
          SizedBox(height: 12),
          MentorXSkeleton(
            width: double.infinity,
            height: 96,
            borderRadius: 18,
          ),
          SizedBox(height: 12),
          MentorXSkeleton(
            width: double.infinity,
            height: 96,
            borderRadius: 18,
          ),
        ],
      );
    }
    if (state.status.isFailure) {
      return AppErrorView(
        message: state.errorMessage ?? t.unableToLoad,
        onRetry: () => context.read<DevicesBloc>().add(
          const DevicesRefreshRequested(),
        ),
      );
    }
    if (state.devices.isEmpty) {
      return AppEmptyView(
        title: t.devices.emptyTitle,
        message: t.devices.emptyHint,
        icon: Icons.devices_other_outlined,
      );
    }
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: context.brandPrimaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(
                Icons.shield_outlined,
                color: context.brandPrimaryColor,
                size: 20,
              ),
              const Gap(10),
              Expanded(
                child: Text(
                  t.devices.pageSubtitle,
                  style: TextStyle(
                    color: context.textPrimaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(20),
        for (final device in state.devices) ...[
          _buildDeviceCard(context, t, device, state),
          const Gap(12),
        ],
        if (state.hasMultipleDevices) ...[
          const Gap(12),
          _ForceLogoutSection(state: state, t: t),
        ],
        const Gap(40),
      ],
    );
  }

  Widget _buildDeviceCard(
    BuildContext context,
    TranslationsParentEn t,
    DeviceEntity device,
    DevicesState state,
  ) {
    // Convention: the first active device returned by the backend is the
    // current one. The Mock honours this order, and the legacy
    // single-session shape always returns one entry with id 'current'.
    final firstActiveId = state.devices
        .firstWhere(
          (d) => d.isActive,
          orElse: () => DeviceEntity.placeholder,
        )
        .id;
    final isCurrent = device.id == firstActiveId && device.isActive;

    return DeviceCard(
      device: device,
      isCurrent: isCurrent,
      isDeactivating: state.deactivatingDeviceId == device.id,
      currentBadgeLabel: t.devices.currentBadge,
      activeBadgeLabel: t.devices.activeBadge,
      inactiveBadgeLabel: t.devices.inactiveBadge,
      lastUsedLabel: t.devices.lastUsedLabel(
        time: describeLastUsed(device.lastUsedAt, now: DateTime.now()),
      ),
      revokeLabel: t.devices.revokeAction,
      onRevoke: () => _confirmRevoke(context, t, device),
    );
  }

  Future<void> _confirmRevoke(
    BuildContext context,
    TranslationsParentEn t,
    DeviceEntity device,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: dialogContext.backgroundSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(t.devices.revokeConfirmTitle),
          content: Text(
            t.devices.revokeConfirmMessage(
              device: device.deviceName.isEmpty
                  ? device.deviceModel
                  : device.deviceName,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(t.devices.cancel),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: dialogContext.statusDangerColor,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(t.devices.revokeAction),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !context.mounted) return;
    context.read<DevicesBloc>().add(
      DeviceDeactivationRequested(device.id),
    );
  }
}

class _ForceLogoutSection extends StatelessWidget {
  final DevicesState state;
  final TranslationsParentEn t;

  const _ForceLogoutSection({required this.state, required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.statusDangerColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: context.statusDangerColor.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.logout_rounded,
                color: context.statusDangerColor,
                size: 18,
              ),
              const Gap(8),
              Text(
                t.devices.forceLogoutTitle,
                style: TextStyle(
                  color: context.statusDangerColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Gap(6),
          Text(
            t.devices.forceLogoutHint,
            style: TextStyle(
              color: context.textSecondaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          const Gap(12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: state.isForceLogoutInFlight
                  ? null
                  : () => _confirmForceLogout(context, t),
              icon: state.isForceLogoutInFlight
                  ? SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: context.statusDangerColor,
                      ),
                    )
                  : Icon(
                      Icons.devices_other_rounded,
                      size: 16,
                      color: context.statusDangerColor,
                    ),
              label: Text(
                t.devices.forceLogoutAction,
                style: TextStyle(
                  color: context.statusDangerColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: context.statusDangerColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmForceLogout(
    BuildContext context,
    TranslationsParentEn t,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: dialogContext.backgroundSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(t.devices.forceLogoutConfirmTitle),
          content: Text(t.devices.forceLogoutConfirmMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(t.devices.cancel),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: dialogContext.statusDangerColor,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(t.devices.forceLogoutAction),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !context.mounted) return;
    context.read<DevicesBloc>().add(
      const DevicesForceLogoutAllRequested(),
    );
  }
}
