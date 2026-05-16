import 'package:mentorx_core/mentorx_core.dart';
import 'models/profile_models.dart';
import 'models/device_models.dart';
export 'models/profile_models.dart';
export 'models/device_models.dart';

final class DioStudentProfileRepository
    extends HttpClientRepository<StudentProfileRepositoryExceptionCode>
    implements StudentProfileRepository {
  @override
  Never throwException(
    StudentProfileRepositoryExceptionCode code, {
    String? message,
  }) => throw StudentProfileRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioStudentProfileRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<ProfileEditRequestEntity> submitEditRequest({
    required String fieldName,
    required String oldValue,
    required String newValue,
    String? reason,
  }) async {
    // Backend doesn't support edit requests, it updates directly via PUT.
    // We'll perform a direct update to maintain interface compatibility.
    try {
      final String apiField = switch (fieldName.toLowerCase()) {
        'name' || 'firstname' => 'firstName',
        'secondname' => 'secondName',
        'thirdname' => 'thirdName',
        'fourthname' => 'fourthName',
        'grade' => 'grade',
        'school' || 'schoolname' => 'schoolName',
        'center' || 'centername' => 'centerName',
        'phone' || 'phonenumber' => 'phone',
        _ => fieldName,
      };

      final response = await httpClient.put(
        '/api/student/profile',
        data: {
          apiField: newValue,
        },
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);

      return ProfileEditRequestEntity(
        id: ModelParser.asString(data['id']),
        fieldName: fieldName,
        oldValue: oldValue,
        newValue: newValue,
        status: EditRequestStatus.approved,
        createdAt: DateTime.now(),
        reason: reason,
      );
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            StudentProfileRepositoryExceptionCode.failedToSubmitEditRequest,
      );
    }
  }

  @override
  Future<List<ProfileEditRequestEntity>> getPendingEditRequests() async {
    // Backend doesn't support edit requests.
    return const [];
  }

  @override
  Future<StudentEntity> getProfile() async {
    try {
      final response = await httpClient.get('/api/student/profile');
      final data = response.asMap();
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
      final response = await httpClient.get('/api/student/profile/summary');
      return response.asMap();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentProfileRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<List<DeviceEntity>> getDevices() async {
    try {
      final response = await httpClient.get('/api/auth/session-status');
      final rootData = response.asMap();

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

      return response.asList().map(asMap).map(DeviceModel.fromJson).toList();
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
        defaultCode:
            StudentProfileRepositoryExceptionCode.failedToDeactivateDevice,
      );
    }
  }

  @override
  Future<void> updateLocation({
    required String governorate,
    required String city,
    required String area,
    double? latitude,
    double? longitude,
    String? mapAddress,
  }) async {
    try {
      await httpClient.patch(
        '/api/student/profile/location',
        data: {
          'governorate': governorate,
          'area': area,
          if (latitude != null) 'latitude': latitude,
          if (longitude != null) 'longitude': longitude,
          'mapAddress': mapAddress ?? '$governorate, $city, $area',
        },
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode:
            StudentProfileRepositoryExceptionCode.failedToUpdateProfile,
      );
    }
  }

  @override
  Future<void> updateProfileImage(String imagePath) async {
    try {
      await httpClient.postMultipart(
        '/api/student/profile/image',
        files: {
          'image': [imagePath],
        },
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode:
            StudentProfileRepositoryExceptionCode.failedToUpdateProfile,
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
      handleHttpClientErrorResponse(
        e,
        defaultCode:
            StudentProfileRepositoryExceptionCode.failedToUpdateProfile,
      );
    }
  }

  @override
  Future<StudentEntity> updateProfile(StudentEntity profile) async {
    try {
      final response = await httpClient.put(
        '/api/student/profile',
        data: StudentProfileModel.fromEntity(profile).toJson(),
      );
      final data = response.asMap();
      return StudentProfileModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            StudentProfileRepositoryExceptionCode.failedToUpdateProfile,
      );
    }
  }
}
