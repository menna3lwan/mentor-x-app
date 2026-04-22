part of 'package:mentorx_core/mentorx_core.dart';

enum StudentRegistrationExceptionCode {
  unknown,
  phoneAlreadyExists,
  failedToLoadGrades,
  failedToLoadCenters,
  failedToLoadSchedules,
  failedToLoadGroups,
  failedToLoadGovernorates,
  failedToLoadDistricts,
  failedToRegister,
  failedToUploadImage,
}

final class StudentRegistrationException
    extends MentorXException<StudentRegistrationExceptionCode> {
  StudentRegistrationException({required super.code, super.message});
}

abstract interface class StudentRegistrationRepository {
  Future<bool> checkPhoneUniqueness(String phone);

  Future<List<GradeEntity>> getGrades(String tenantId);

  Future<List<CenterEntity>> getCenters(String tenantId);

  Future<List<ScheduleEntity>> getSchedules({
    required String centerId,
    required String gradeId,
  });

  Future<List<GroupEntity>> getGroups({
    required String centerId,
    required String gradeId,
    required String scheduleId,
  });

  Future<List<GovernorateEntity>> getGovernorates();

  Future<List<DistrictEntity>> getDistricts(String governorateId);

  Future<String> uploadImage(String filePath);

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
  });
}
