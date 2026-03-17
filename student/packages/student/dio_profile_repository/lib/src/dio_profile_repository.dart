import 'package:mentorx_core/mentorx_core.dart';
import 'package:student_core/student_core.dart';
import 'package:dio/dio.dart';
import '../models/profile_models.dart';
import '../models/device_models.dart';

final class DioStudentProfileRepository
    extends HttpClientRepository<StudentProfileRepositoryExceptionCode>
    implements StudentProfileRepository {
  @override
  Never throwException(StudentProfileRepositoryExceptionCode code,
          {String? message}) =>
      throw StudentProfileRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioStudentProfileRepository({required this.httpClient});

  @override
  Future<ProfileEditRequestEntity> submitEditRequest({
    required String fieldName,
    required String newValue,
    String? reason,
  }) async {
    final response = await httpClient.post(
      '/api/student/profile/edit-requests',
      data: {
        'field_name': fieldName,
        'new_value': newValue,
        if (reason != null) 'reason': reason,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw StudentProfileRepositoryException(
        code: StudentProfileRepositoryExceptionCode.failedToSubmitEditRequest,
        message: response.exception?.message,
      );
    }

    return ProfileEditRequestModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<List<ProfileEditRequestEntity>> getPendingEditRequests() async {
    final response = await httpClient.get(
      '/api/student/profile/edit-requests',
      queryParameters: {'status': 'pending'},
    );

    if (response.statusCode != 200) {
      throw StudentProfileRepositoryException(
        code: StudentProfileRepositoryExceptionCode.failedToLoadEditRequests,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => ProfileEditRequestModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<NationalIdVerificationEntity> verifyIdentity(String imagePath) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath),
      });

      final response = await httpClient.post(
        '/api/student/profile/verify-identity',
        data: formData,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw StudentProfileRepositoryException(
          code: StudentProfileRepositoryExceptionCode.failedToVerifyIdentity,
        );
      }

      return NationalIdVerificationModel.fromJson(response.data['data'] ?? response.data);
    } catch (e) {
      throw StudentProfileRepositoryException(
        code: StudentProfileRepositoryExceptionCode.failedToVerifyIdentity,
        message: e.toString(),
      );
    }
  }

  @override
  Future<NationalIdVerificationEntity> getVerificationStatus() async {
    final response = await httpClient.get('/api/student/profile/verification-status');

    if (response.statusCode != 200) {
      throw StudentProfileRepositoryException(
        code: StudentProfileRepositoryExceptionCode.failedToGetVerificationStatus,
        message: response.exception?.message,
      );
    }

    return NationalIdVerificationModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<StudentEntity> getProfile() async {
    final response = await httpClient.get('/api/student/profile');

    if (response.statusCode != 200) {
      throw ProfileRepositoryException(
        code: ProfileRepositoryExceptionCode.failedToLoadProfile,
        message: response.exception?.message,
      );
    }

    return StudentModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<List<DeviceEntity>> getDevices() async {
    final response = await httpClient.get('/api/student/profile/devices');

    if (response.statusCode != 200) {
      throw ProfileRepositoryException(
        code: ProfileRepositoryExceptionCode.failedToLoadDevices,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => DeviceModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<void> deactivateDevice(String deviceId) async {
    final response = await httpClient.delete('/api/student/profile/devices/$deviceId');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw ProfileRepositoryException(
        code: ProfileRepositoryExceptionCode.failedToDeactivateDevice,
        message: response.exception?.message,
      );
    }
  }
}
