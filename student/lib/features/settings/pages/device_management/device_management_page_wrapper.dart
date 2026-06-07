import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/device_management_bloc.dart';
import 'device_management_page.dart';

final class DeviceManagementPageWrapper extends StatefulWidget {
  const DeviceManagementPageWrapper({super.key});

  @override
  State<DeviceManagementPageWrapper> createState() =>
      _DeviceManagementPageWrapperState();
}

final class _DeviceManagementPageWrapperState
    extends State<DeviceManagementPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      DeviceManagementBloc,
      DeviceManagementPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case DeviceManagementFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: Builder(
        builder: (context) {
          final isLoading = context.select(
            (DeviceManagementBloc bloc) => bloc.state.isLoading,
          );
          final loadingState = context.select(
            (DeviceManagementBloc bloc) => bloc.state.loadingState,
          );
          final errorMessage = context.select(
            (DeviceManagementBloc bloc) => bloc.state.errorMessage,
          );
          final devices = context.select(
            (DeviceManagementBloc bloc) => bloc.state.devices,
          );
          final deactivatingDeviceIds = context.select(
            (DeviceManagementBloc bloc) => bloc.state.deactivatingDeviceIds,
          );

          return DeviceManagementPage(
            isLoading: isLoading,
            loadingState: loadingState,
            errorMessage: errorMessage,
            devices: devices,
            deactivatingDeviceIds: deactivatingDeviceIds,
            onRefresh: () {
              context.read<DeviceManagementBloc>().add(
                const DeviceManagementRefreshed(),
              );
            },
            onDeactivateTapped: (deviceId) {
              context.read<DeviceManagementBloc>().add(
                DeviceManagementDeactivateRequested(deviceId: deviceId),
              );
            },
          );
        },
      ),
    );
  }
}
