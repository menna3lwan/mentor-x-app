import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';

import 'package:mentorx_student/core/core.dart';

part 'device_management_event.dart';
part 'device_management_state.dart';

sealed class DeviceManagementPresentationEvent {
  const DeviceManagementPresentationEvent();
}

final class DeviceManagementFailurePresentationEvent
    extends DeviceManagementPresentationEvent {
  final String message;

  const DeviceManagementFailurePresentationEvent({required this.message});
}

final class DeviceManagementBloc
    extends Bloc<DeviceManagementEvent, DeviceManagementState>
    with
        BlocPresentationMixin<
          DeviceManagementState,
          DeviceManagementPresentationEvent
        > {
  final ProfileRepository _profileRepository;

  DeviceManagementBloc({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository,
       super(DeviceManagementState.initial) {
    on<DeviceManagementInitialized>(_onInitialized);
    on<DeviceManagementRefreshed>(_onRefreshed);
    on<DeviceManagementDeactivateRequested>(_onDeactivateRequested);
  }

  Future<void> _onInitialized(
    DeviceManagementInitialized event,
    Emitter<DeviceManagementState> emit,
  ) async {
    await _loadDevices(emit: emit);
  }

  Future<void> _onRefreshed(
    DeviceManagementRefreshed event,
    Emitter<DeviceManagementState> emit,
  ) async {
    await _loadDevices(emit: emit);
  }

  Future<void> _onDeactivateRequested(
    DeviceManagementDeactivateRequested event,
    Emitter<DeviceManagementState> emit,
  ) async {
    final ids = Set<String>.from(state.deactivatingDeviceIds)
      ..add(event.deviceId);
    emit(state.copyWith(deactivatingDeviceIds: ids));

    try {
      await _profileRepository.deactivateDevice(event.deviceId);
      await _loadDevices(emit: emit, isSilent: true);
    } on ProfileRepositoryException catch (e) {
      final message = e.message ?? 'Failed to deactivate device.';
      emitPresentation(
        DeviceManagementFailurePresentationEvent(message: message),
      );
    } catch (e) {
      emitPresentation(
        DeviceManagementFailurePresentationEvent(message: e.toString()),
      );
    } finally {
      final updated = Set<String>.from(state.deactivatingDeviceIds)
        ..remove(event.deviceId);
      emit(state.copyWith(deactivatingDeviceIds: updated));
    }
  }

  Future<void> _loadDevices({
    required Emitter<DeviceManagementState> emit,
    bool isSilent = false,
  }) async {
    if (!isSilent) {
      emit(
        state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
      );
    }

    try {
      final devices = await _profileRepository.getDevices();
      final sorted = List<DeviceEntity>.from(devices)
        ..sort((a, b) => b.lastUsedAt.compareTo(a.lastUsedAt));
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          devices: sorted,
          errorMessage: null,
        ),
      );
    } on ProfileRepositoryException catch (e) {
      final message = e.message ?? 'Failed to load devices.';
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(
        DeviceManagementFailurePresentationEvent(message: message),
      );
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(
        DeviceManagementFailurePresentationEvent(message: message),
      );
    }
  }
}
