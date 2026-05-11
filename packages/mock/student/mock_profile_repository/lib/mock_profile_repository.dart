import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockProfileRepository implements StudentProfileRepository {
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
  Future<Map<String, dynamic>> getSummary() async {
    await Future<void>.delayed(delay);
    return {
      'points': 2450,
      'rank': 3,
      'quizzesCompleted': 18,
      'badgesEarned': 4,
    };
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

  @override
  Future<ProfileEditRequestEntity> submitEditRequest({
    required String fieldName,
    required String newValue,
    String? reason,
  }) async {
    await Future<void>.delayed(delay);
    return ProfileEditRequestEntity(
      id: 'req-1',
      fieldName: fieldName,
      oldValue: 'Old Value',
      newValue: newValue,
      status: EditRequestStatus.pending,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<List<ProfileEditRequestEntity>> getPendingEditRequests() async {
    await Future<void>.delayed(delay);
    return [];
  }


  @override
  Future<void> deleteAccount(String password) async {
    await Future<void>.delayed(delay);
  }
}
