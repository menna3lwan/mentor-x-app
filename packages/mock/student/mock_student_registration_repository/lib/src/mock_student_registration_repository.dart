import 'dart:async';
import 'package:mentorx_core/mentorx_core.dart';

final class MockStudentRegistrationRepository
    implements StudentRegistrationRepository {
  @override
  Future<bool> checkPhoneUniqueness(String phone) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulate uniqueness (except for a specific testing number)
    return phone != '01000000000';
  }

  @override
  Future<List<GradeEntity>> getGrades(String tenantId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      const GradeEntity(id: '1', name: 'Primary 1'),
      const GradeEntity(id: '2', name: 'Primary 2'),
      const GradeEntity(id: '3', name: 'Primary 3'),
      const GradeEntity(id: '4', name: 'Secondary 1'),
      const GradeEntity(id: '5', name: 'Secondary 2'),
      const GradeEntity(id: '6', name: 'Secondary 3'),
    ];
  }

  @override
  Future<List<CenterEntity>> getCenters(String tenantId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      const CenterEntity(id: '1', name: 'Downtown Center'),
      const CenterEntity(id: '2', name: 'West Side Branch'),
      const CenterEntity(id: '3', name: 'Smart Village Lab'),
    ];
  }

  @override
  Future<List<ScheduleEntity>> getSchedules({
    required String centerId,
    required String gradeId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      const ScheduleEntity(
          id: '1', day: 'Saturday', startTime: '10:00 AM', endTime: '12:00 PM'),
      const ScheduleEntity(
          id: '2', day: 'Monday', startTime: '04:00 PM', endTime: '06:00 PM'),
      const ScheduleEntity(
          id: '3', day: 'Wednesday', startTime: '06:00 PM', endTime: '08:00 PM'),
    ];
  }

  @override
  Future<List<GroupEntity>> getGroups({
    required String centerId,
    required String gradeId,
    required String scheduleId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      const GroupEntity(id: '1', name: 'Group A'),
      const GroupEntity(id: '2', name: 'Group B'),
      const GroupEntity(id: '3', name: 'Group C'),
    ];
  }

  @override
  Future<List<GovernorateEntity>> getGovernorates() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      const GovernorateEntity(id: '1', name: 'Cairo'),
      const GovernorateEntity(id: '2', name: 'Giza'),
      const GovernorateEntity(id: '3', name: 'Alexandria'),
    ];
  }

  @override
  Future<List<DistrictEntity>> getDistricts(String governorateId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (governorateId == '1') {
      return [
        const DistrictEntity(id: '1', name: 'Maadi', governorateId: '1'),
        const DistrictEntity(id: '2', name: 'Nasr City', governorateId: '1'),
      ];
    } else if (governorateId == '2') {
      return [
        const DistrictEntity(id: '3', name: '6th of October', governorateId: '2'),
        const DistrictEntity(id: '4', name: 'Dokki', governorateId: '2'),
      ];
    }
    return [
      DistrictEntity(id: '5', name: 'Other District', governorateId: governorateId),
    ];
  }

  @override
  Future<String> uploadImage(String filePath) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'https://mock-cdn.mentorx.com/uploads/${filePath.split('/').last}';
  }

  @override
  Future<({String studentCode, int? otpExpiresInSeconds})> register({
    required String tenantId,
    required String firstName,
    required String lastName,
    required String phone,
    String? email,
    required String gender,
    required DateTime dateOfBirth,
    String? profilePhotoUrl,
    required String gradeId,
    String? schoolName,
    required String studyType,
    String? centerId,
    String? scheduleId,
    String? centerGroupId,
    required String governorateId,
    required String districtId,
    required String parentName,
    required String parentPhone,
    required String password,
    String? idCardPhotoUrl,
    required String deviceHash,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return (
      studentCode: 'MX-${DateTime.now().year}-0042',
      otpExpiresInSeconds: 300,
    );
  }
}
