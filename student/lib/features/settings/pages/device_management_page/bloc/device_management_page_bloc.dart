import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';

import '../../../../../core/core.dart';

part 'device_management_page_event.dart';
part 'device_management_page_state.dart';

sealed class DeviceManagementPagePresentationEvent {
  const DeviceManagementPagePresentationEvent();
}

final class DeviceManagementPageFailurePresentationEvent
    extends DeviceManagementPagePresentationEvent {
  final String message;

  const DeviceManagementPageFailurePresentationEvent({required this.message});
}

final class DeviceManagementPageBloc
    extends Bloc<DeviceManagementPageEvent, DeviceManagementPageState>
    with
        BlocPresentationMixin<
          DeviceManagementPageState,
          DeviceManagementPagePresentationEvent
        > {
  final ProfileRepository _profileRepository;

  DeviceManagementPageBloc({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository,
      super(DeviceManagementPageState.initial) {
    on<DeviceManagementPageInitialized>(_onInitialized);
    on<DeviceManagementPageRefreshed>(_onRefreshed);
    on<DeviceManagementPageDeactivateRequested>(_onDeactivateRequested);
  }

  Future<void> _onInitialized(
    DeviceManagementPageInitialized event,
    Emitter<DeviceManagementPageState> emit,
  ) async {
    await _loadDevices(emit: emit);
  }

  Future<void> _onRefreshed(
    DeviceManagementPageRefreshed event,
    Emitter<DeviceManagementPageState> emit,
  ) async {
    await _loadDevices(emit: emit);
  }

  Future<void> _onDeactivateRequested(
    DeviceManagementPageDeactivateRequested event,
    Emitter<DeviceManagementPageState> emit,
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
        DeviceManagementPageFailurePresentationEvent(message: message),
      );
    } catch (e) {
      emitPresentation(
        DeviceManagementPageFailurePresentationEvent(message: e.toString()),
      );
    } finally {
      final updated = Set<String>.from(state.deactivatingDeviceIds)
        ..remove(event.deviceId);
      emit(state.copyWith(deactivatingDeviceIds: updated));
    }
  }

  Future<void> _loadDevices({
    required Emitter<DeviceManagementPageState> emit,
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
        DeviceManagementPageFailurePresentationEvent(message: message),
      );
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(
        DeviceManagementPageFailurePresentationEvent(message: message),
      );
    }
  }
}
