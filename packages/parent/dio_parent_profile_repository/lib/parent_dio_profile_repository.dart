import 'package:mentorx_core/mentorx_core.dart';

import 'models/parent_profile_model.dart';

export 'models/parent_profile_model.dart';

/// Dio-backed implementation of [ParentProfileRepository].
///
/// EduCore contract (from Postman):
/// - `GET  /api/parent/profile`         → returns standard envelope with the
///   parent profile under `data`.
/// - `PUT  /api/parent/profile`         body: `{ name }` → returns updated
///   profile under `data`.
/// - `POST /api/parent/profile/image`   multipart `image` file → returns
///   updated profile (with new `profileImageUrl`) under `data`.
///
/// All three responses use the same envelope shape, so a single mapper
/// (`ParentProfileModel.fromJson`) covers all three call sites.
final class DioParentProfileRepository
    extends HttpClientRepository<ParentProfileRepositoryExceptionCode>
    implements ParentProfileRepository {
  final HttpClient _httpClient;

  DioParentProfileRepository({required HttpClient httpClient})
    : _httpClient = httpClient;

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
      return _parseProfile(response.data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentProfileRepositoryExceptionCode.failedToLoadProfile,
        codeFromStatusCode: _statusToCode,
      );
    }
  }

  @override
  Future<ParentEntity> updateProfile({String? name}) async {
    try {
      final payload = <String, dynamic>{
        if (name != null) 'name': name,
      };
      final response = await _httpClient.put(
        '/api/parent/profile',
        data: payload,
      );
      return _parseProfile(response.data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentProfileRepositoryExceptionCode.failedToUpdateProfile,
        codeFromStatusCode: _statusToCode,
      );
    }
  }

  @override
  Future<ParentEntity> uploadAvatar(String imagePath) async {
    if (imagePath.trim().isEmpty) {
      throw const ParentProfileRepositoryException(
        code: ParentProfileRepositoryExceptionCode.invalidImage,
        message: 'No image was provided.',
      );
    }
    try {
      final response = await _httpClient.postMultipart(
        '/api/parent/profile/image',
        files: {
          'image': [imagePath],
        },
      );
      return _parseProfile(response.data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentProfileRepositoryExceptionCode.failedToUploadAvatar,
        codeFromStatusCode: _statusToCode,
      );
    } catch (e) {
      throw ParentProfileRepositoryException(
        code: ParentProfileRepositoryExceptionCode.failedToUploadAvatar,
        message: e.toString(),
      );
    }
  }

  // ───────────────────────── Helpers ──────────────────────────────────────

  ParentEntity _parseProfile(dynamic raw) {
    final root = asMap(raw);
    final data = (root['data'] is Map) ? asMap(root['data']) : root;
    return ParentProfileModel.fromJson(data);
  }

  ParentProfileRepositoryExceptionCode _statusToCode(int statusCode) {
    return switch (statusCode) {
      401 || 403 => ParentProfileRepositoryExceptionCode.unauthorized,
      404 => ParentProfileRepositoryExceptionCode.failedToLoadProfile,
      _ => ParentProfileRepositoryExceptionCode.unknown,
    };
  }
}
