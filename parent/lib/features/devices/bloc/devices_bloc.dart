import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/bloc_error_helpers.dart';

part 'devices_event.dart';
part 'devices_state.dart';

// ──── Presentation events ──────────────────────────────────────────────────

sealed class DevicesPresentationEvent {
  const DevicesPresentationEvent();
}

final class DevicesLoadFailurePresentationEvent
    extends DevicesPresentationEvent {
  final String message;
  const DevicesLoadFailurePresentationEvent({required this.message});
}

final class DevicesForceLogoutSucceededPresentationEvent
    extends DevicesPresentationEvent {
  const DevicesForceLogoutSucceededPresentationEvent();
}

final class DevicesForceLogoutFailedPresentationEvent
    extends DevicesPresentationEvent {
  final String message;
  const DevicesForceLogoutFailedPresentationEvent({required this.message});
}

final class DeviceDeactivatedPresentationEvent
    extends DevicesPresentationEvent {
  final String deviceId;
  const DeviceDeactivatedPresentationEvent({required this.deviceId});
}

final class DeviceDeactivationFailedPresentationEvent
    extends DevicesPresentationEvent {
  final String message;
  const DeviceDeactivationFailedPresentationEvent({required this.message});
}

final class DevicesUnauthorizedPresentationEvent
    extends DevicesPresentationEvent {
  const DevicesUnauthorizedPresentationEvent();
}

// ──── Bloc ─────────────────────────────────────────────────────────────────

/// Drives the Devices & Sessions screen.
///
/// Three independent operations:
/// - Load list (idempotent, droppable refresh).
/// - Force-logout-all (one-shot, droppable).
/// - Deactivate single device (per-device action with optimistic update +
///   rollback on failure).
final class DevicesBloc extends Bloc<DevicesEvent, DevicesState>
    with BlocPresentationMixin<DevicesState, DevicesPresentationEvent> {
  final ParentDevicesRepository _repository;

  DevicesBloc({required ParentDevicesRepository repository})
    : _repository = repository,
      super(DevicesState.initial()) {
    on<DevicesStarted>(_onStarted);
    on<DevicesRefreshRequested>(_onRefresh, transformer: droppable());
    on<DevicesForceLogoutAllRequested>(
      _onForceLogoutAll,
      transformer: droppable(),
    );
    on<DeviceDeactivationRequested>(
      _onDeactivate,
      transformer: droppable(),
    );
  }

  Future<void> _onStarted(
    DevicesStarted event,
    Emitter<DevicesState> emit,
  ) async {
    if (state.status.isLoaded) return;
    emit(state.copyWith(status: DevicesStatus.loading));
    await _load(emit);
  }

  Future<void> _onRefresh(
    DevicesRefreshRequested event,
    Emitter<DevicesState> emit,
  ) async {
    if (state.isRefreshing) return;
    emit(state.copyWith(isRefreshing: true));
    try {
      await _load(emit);
    } finally {
      if (!emit.isDone) emit(state.copyWith(isRefreshing: false));
    }
  }

  Future<void> _onForceLogoutAll(
    DevicesForceLogoutAllRequested event,
    Emitter<DevicesState> emit,
  ) async {
    emit(state.copyWith(isForceLogoutInFlight: true));
    try {
      final updated = await _repository.forceLogoutAll();
      if (emit.isDone) return;
      emit(
        state.copyWith(
          status: DevicesStatus.loaded,
          devices: updated,
          isForceLogoutInFlight: false,
        ),
      );
      emitPresentation(const DevicesForceLogoutSucceededPresentationEvent());
    } catch (e) {
      if (emit.isDone) return;
      final message = e.describeError();
      emit(state.copyWith(isForceLogoutInFlight: false));
      _maybeAuth(e);
      emitPresentation(
        DevicesForceLogoutFailedPresentationEvent(message: message),
      );
    }
  }

  Future<void> _onDeactivate(
    DeviceDeactivationRequested event,
    Emitter<DevicesState> emit,
  ) async {
    final original = List<DeviceEntity>.from(state.devices);
    final optimistic = original
        .where((d) => d.id != event.deviceId)
        .toList(growable: false);

    // Optimistic remove. We restore from `original` if the network call
    // fails so the row reappears for the user.
    emit(
      state.copyWith(
        devices: optimistic,
        deactivatingDeviceId: event.deviceId,
      ),
    );
    try {
      await _repository.deactivateDevice(event.deviceId);
      if (emit.isDone) return;
      emit(state.copyWith(deactivatingDeviceId: null));
      emitPresentation(
        DeviceDeactivatedPresentationEvent(deviceId: event.deviceId),
      );
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          devices: original,
          deactivatingDeviceId: null,
        ),
      );
      _maybeAuth(e);
      emitPresentation(
        DeviceDeactivationFailedPresentationEvent(
          message: e.describeError(),
        ),
      );
    }
  }

  Future<void> _load(Emitter<DevicesState> emit) async {
    try {
      final devices = await _repository.getDevices();
      if (emit.isDone) return;
      emit(
        state.copyWith(
          status: DevicesStatus.loaded,
          devices: devices,
          errorMessage: null,
        ),
      );
    } catch (e) {
      if (emit.isDone) return;
      final message = e.describeError();
      emit(
        state.copyWith(
          status: DevicesStatus.failure,
          errorMessage: message,
        ),
      );
      _maybeAuth(e);
      emitPresentation(
        DevicesLoadFailurePresentationEvent(message: message),
      );
    }
  }

  void _maybeAuth(Object error) {
    if (isUnauthorizedError(error)) {
      emitPresentation(const DevicesUnauthorizedPresentationEvent());
    }
  }
}
