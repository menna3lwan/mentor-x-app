import 'package:mentorx_core/mentorx_core.dart';
import '../models/parent_profile_model.dart';

final class DioProfileRepository
    extends HttpClientRepository<ParentProfileRepositoryExceptionCode>
    implements ParentProfileRepository {
  DioProfileRepository({
    required HttpClient httpClient,
    required CacheRepository cacheRepository,
  }) : _httpClient = httpClient;

  final HttpClient _httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentProfileRepositoryExceptionCode code, {
    String? message,
  }) => throw ParentProfileRepositoryException(code: code, message: message);

  @override
  Future<ParentEntity> getProfile() async {
    try {
      final response = await _httpClient.get('/api/parent/profile');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ParentProfileModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentProfileRepositoryExceptionCode.failedToLoadProfile,
      );
    }
  }

  @override
  Future<ParentEntity> updateProfile(ParentEntity profile) async {
    try {
      final response = await _httpClient.put(
        '/api/parent/profile',
        data: {
          'firstName': profile.firstName,
          'lastName': profile.lastName,
          'email': profile.email,
          'phoneNumber': profile.phoneNumber,
        },
      );
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ParentProfileModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentProfileRepositoryExceptionCode.failedToUpdateProfile,
      );
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _httpClient.post(
        '/api/parent/profile/change-password',
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentProfileRepositoryExceptionCode.failedToUpdateProfile,
      );
    }
  }
}
