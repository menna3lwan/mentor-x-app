import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockProfileRepository implements ProfileRepository {
  final Duration delay;

  const MockProfileRepository({required this.delay});

  @override
  Future<void> initialize() async {}

  @override
  Future<StudentEntity> getProfile() async {
    await Future<void>.delayed(delay);
    return MockProfileGenerator.profile();
  }

  @override
  Future<List<DeviceEntity>> getDevices() async {
    await Future<void>.delayed(delay);
    return MockProfileGenerator.devices();
  }

  @override
  Future<void> deactivateDevice(String deviceId) async {
    await Future<void>.delayed(delay ~/ 2);
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await Future<void>.delayed(delay);
  }

  @override
  Future<StudentEntity> updateProfile(StudentEntity profile) async {
    await Future<void>.delayed(delay);
    return profile;
  }
}
