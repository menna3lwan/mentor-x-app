part of '../../mock_data.dart';

final class MockProfileGenerator {
  MockProfileGenerator._();

  static StudentEntity profile() {
    return StudentEntity(
      id: 'student_1',
      name: 'Ahmed Mohamed',
      phoneNumber: '01012345678',
      email: 'ahmed.m@example.com',
      status: StudentStatus.active,
      gender: Gender.male,
      dateOfBirth: DateTime(2007, 5, 15),
      gradeId: 'g1',
      gradeName: 'Grade 10',
      studyType: StudyType.both,
      profileImageUrl: 'https://picsum.photos/200/200?profile',
      walletBalance: 1240.50,
      totalPoints: 860,
      schoolName: 'Al-Azhar Secondary School',
      parentName: 'Mohamed Ali',
      parentPhone: '01098765432',
      createdAt: DateTime(2024, 9, 1),
      updatedAt: DateTime.now(),
    );
  }

  static List<DeviceEntity> devices() {
    return [
      DeviceEntity(
        id: 'd1',
        deviceName: "Ahmed's iPhone",
        deviceModel: 'iPhone 15',
        osVersion: 'iOS 18.1',
        appVersion: '1.0.0',
        isActive: true,
        lastUsedAt: DateTime.now(),
      ),
      DeviceEntity(
        id: 'd2',
        deviceName: "Ahmed's iPad",
        deviceModel: 'iPad Air',
        osVersion: 'iPadOS 18.1',
        appVersion: '1.0.0',
        isActive: true,
        lastUsedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      DeviceEntity(
        id: 'd3',
        deviceName: 'Old Phone',
        deviceModel: 'Samsung Galaxy S21',
        osVersion: 'Android 14',
        appVersion: '0.9.0',
        isActive: false,
        lastUsedAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
    ];
  }
}
