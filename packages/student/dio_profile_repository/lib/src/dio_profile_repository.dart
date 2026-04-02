import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio/dio.dart';
import 'models/profile_models.dart';
import 'models/device_models.dart';

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
  Future<void> initialize() async {}

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

    final data = _asMap(response.data)['data'] ?? _asMap(response.data);
    return ProfileEditRequestModel.fromJson(data);
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

    return _asList(response.data)
        .map(_asMap)
        .map(ProfileEditRequestModel.fromJson)
        .toList();
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

      final data = _asMap(response.data)['data'] ?? _asMap(response.data);
      return NationalIdVerificationModel.fromJson(data);
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

    final data = _asMap(response.data)['data'] ?? _asMap(response.data);
    return NationalIdVerificationModel.fromJson(data);
  }

  @override
  Future<StudentEntity> getProfile() async {
    final response = await httpClient.get('/api/student/profile');

    if (response.statusCode != 200) {
      throw StudentProfileRepositoryException(
        code: StudentProfileRepositoryExceptionCode.failedToLoadProfile,
        message: response.exception?.message,
      );
    }

    final data = _asMap(response.data)['data'] ?? _asMap(response.data);
    return StudentProfileModel.fromJson(data);
  }

  @override
  Future<List<DeviceEntity>> getDevices() async {
    final response = await httpClient.get('/api/student/profile/devices');

    if (response.statusCode != 200) {
      throw StudentProfileRepositoryException(
        code: StudentProfileRepositoryExceptionCode.failedToLoadDevices,
        message: response.exception?.message,
      );
    }

    return _asList(response.data)
        .map(_asMap)
        .map(DeviceModel.fromJson)
        .toList();
  }

  @override
  Future<void> deactivateDevice(String deviceId) async {
    final response = await httpClient.delete('/api/student/profile/devices/$deviceId');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw StudentProfileRepositoryException(
        code: StudentProfileRepositoryExceptionCode.failedToDeactivateDevice,
        message: response.exception?.message,
      );
    }
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    return <String, dynamic>{};
  }

  static List<dynamic> _asList(dynamic value) {
    if (value is List<dynamic>) return value;
    if (value is Map<String, dynamic>) {
      final data = value['data'] ?? value['items'];
      if (data is List<dynamic>) return data;
    }
    return <dynamic>[];
  }
}
