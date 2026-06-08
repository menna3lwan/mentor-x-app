import 'package:mentorx_core/mentorx_core.dart';

/// In-memory mock of [ParentDevicesRepository] for `mock` builds.
///
/// Holds a mutable list of [DeviceEntity] so `forceLogoutAll` and
/// `deactivateDevice` produce visible state changes in the UI — the user
/// sees the device disappear from the list immediately.
final class MockParentDevicesRepository implements ParentDevicesRepository {
  final Duration delay;
  final List<DeviceEntity> _devices;

  MockParentDevicesRepository({
    this.delay = const Duration(milliseconds: 500),
    List<DeviceEntity>? initialDevices,
  }) : _devices = List<DeviceEntity>.from(initialDevices ?? _seed());

  @override
  Future<void> initialize() async {}

  @override
  Future<List<DeviceEntity>> getDevices() async {
    await Future<void>.delayed(delay);
    return List<DeviceEntity>.unmodifiable(_devices);
  }

  @override
  Future<List<DeviceEntity>> forceLogoutAll() async {
    await Future<void>.delayed(delay);
    // Keep only the current session (the first `isActive` device, by
    // convention).
    final current = _devices.firstWhere(
      (d) => d.isActive,
      orElse: () =>
          _devices.isEmpty ? DeviceEntity.placeholder : _devices.first,
    );
    _devices
      ..clear()
      ..add(current);
    return List<DeviceEntity>.unmodifiable(_devices);
  }

  @override
  Future<void> deactivateDevice(String deviceId) async {
    await Future<void>.delayed(delay);
    _devices.removeWhere((d) => d.id == deviceId);
  }

  static List<DeviceEntity> _seed() {
    final now = DateTime.now();
    return [
      DeviceEntity(
        id: 'dev-current',
        deviceName: 'Pixel 7 Pro',
        deviceModel: 'Google Pixel',
        deviceType: 'Android',
        osVersion: 'Android 14',
        appVersion: '1.0.0',
        isActive: true,
        lastUsedAt: now,
      ),
      DeviceEntity(
        id: 'dev-secondary',
        deviceName: 'iPhone 14',
        deviceModel: 'Apple iPhone',
        deviceType: 'iOS',
        osVersion: 'iOS 17.4',
        appVersion: '1.0.0',
        isActive: true,
        lastUsedAt: now.subtract(const Duration(hours: 6)),
      ),
      DeviceEntity(
        id: 'dev-old',
        deviceName: 'Samsung Galaxy A52',
        deviceModel: 'Samsung',
        deviceType: 'Android',
        osVersion: 'Android 13',
        appVersion: '0.9.4',
        isActive: false,
        lastUsedAt: now.subtract(const Duration(days: 18)),
      ),
    ];
  }
}
