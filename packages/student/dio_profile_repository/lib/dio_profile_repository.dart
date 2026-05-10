import 'package:mentorx_core/mentorx_core.dart';
import 'models/profile_models.dart';
import 'models/device_models.dart';
export 'models/profile_models.dart';
export 'models/device_models.dart';

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
    try {
      final response = await httpClient.post(
        '/api/student/profile/edit-requests',
        data: {
          'field_name': fieldName,
          'new_value': newValue,
          if (reason != null) 'reason': reason,
        },
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ProfileEditRequestModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentProfileRepositoryExceptionCode.failedToSubmitEditRequest,
      );
    }
  }

  @override
  Future<List<ProfileEditRequestEntity>> getPendingEditRequests() async {
    try {
      final response = await httpClient.get(
        '/api/student/profile/edit-requests',
        queryParameters: {'status': 'pending'},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list
          .map(asMap)
          .map(ProfileEditRequestModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentProfileRepositoryExceptionCode.failedToLoadEditRequests,
      );
    }
  }

  @override
  Future<NationalIdVerificationEntity> verifyIdentity(String imagePath) async {
    try {
      final response = await httpClient.postMultipart(
        '/api/student/profile/verify-identity',
        files: {'image': [imagePath]},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return NationalIdVerificationModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentProfileRepositoryExceptionCode.failedToVerifyIdentity,
      );
    } catch (e) {
      throw StudentProfileRepositoryException(
        code: StudentProfileRepositoryExceptionCode.failedToVerifyIdentity,
        message: e.toString(),
      );
    }
  }

  @override
  Future<NationalIdVerificationEntity> getVerificationStatus() async {
    try {
      final response = await httpClient.get('/api/student/profile/verification-status');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return NationalIdVerificationModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentProfileRepositoryExceptionCode.failedToGetVerificationStatus,
      );
    }
  }

  @override
  Future<StudentEntity> getProfile() async {
    try {
      final response = await httpClient.get('/api/student/profile');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return StudentProfileModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentProfileRepositoryExceptionCode.failedToLoadProfile,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getSummary() async {
    try {
      final response = await httpClient.get('/api/profile/student/summary');
      return asMap(response.data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(e, defaultCode: StudentProfileRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<List<DeviceEntity>> getDevices() async {
    try {
      final response = await httpClient.get('/api/auth/session-status');
      
      final rootData = asMap(response.data);

      // Handle the case where session-status returns a single status object instead of a list
      if (rootData.containsKey('hasSession')) {
        final hasSession = boolOrFalse(rootData['hasSession']);
        if (!hasSession) return const [];

        return [
          DeviceEntity(
            id: stringOrNull(rootData['studentCode']) ?? 'current',
            deviceName: 'Active Session',
            deviceModel: stringOrNull(rootData['role']) ?? 'Student',
            isActive: true,
            lastUsedAt: DateTime.now(),
          ),
        ];
      }

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : rootData['content'] ?? response.data);

      return list.map(asMap).map(DeviceModel.fromJson).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentProfileRepositoryExceptionCode.failedToLoadDevices,
      );
    }
  }

  @override
  Future<void> deactivateDevice(String deviceId) async {
    try {
      await httpClient.delete('/api/student/profile/devices/$deviceId');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: StudentProfileRepositoryExceptionCode.failedToDeactivateDevice,
      );
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await httpClient.post(
        '/api/auth/change-password',
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: StudentProfileRepositoryExceptionCode.failedToUpdateProfile);
    }
  }

  @override
  Future<StudentEntity> updateProfile(StudentEntity profile) async {
    try {
      final response = await httpClient.put(
        '/api/student/profile',
        data: StudentProfileModel.fromEntity(profile).toJson(),
      );
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return StudentProfileModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentProfileRepositoryExceptionCode.failedToUpdateProfile,
      );
    }
  }

  @override
  Future<void> deleteAccount(String password) async {
    try {
      await httpClient.post('/api/auth/delete-account', data: {'password': password});
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: StudentProfileRepositoryExceptionCode.unknown);
    }
  }
}
