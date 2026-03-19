import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/device_management_page_bloc.dart';
import 'device_management_page_page.dart';

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
      DeviceManagementPageBloc,
      DeviceManagementPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case DeviceManagementPageFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: BlocBuilder<DeviceManagementPageBloc, DeviceManagementPageState>(
        builder: (context, state) {
          return DeviceManagementPagePage(
            state: state,
            onRefresh: () {
              context.read<DeviceManagementPageBloc>().add(
                const DeviceManagementPageRefreshed(),
              );
            },
            onDeactivateTapped: (deviceId) {
              context.read<DeviceManagementPageBloc>().add(
                DeviceManagementPageDeactivateRequested(deviceId: deviceId),
              );
            },
          );
        },
      ),
    );
  }
}
