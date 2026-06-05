part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentProfileRepositoryExceptionCode {
  unknown,
  failedToLoadProfile,
  failedToUpdateProfile,
  failedToUploadAvatar,
  invalidImage,
  networkError,
  unauthorized,
}

final class ParentProfileRepositoryException
    extends MentorXException<ParentProfileRepositoryExceptionCode> {
  const ParentProfileRepositoryException({
    required super.code,
    super.message,
  });
}

// ——— Repository ———

/// Backs the Parent app's profile screen + edit-profile flow.
///
/// Backed by three EduCore endpoints:
/// - `GET /api/parent/profile`         (load latest profile)
/// - `PUT /api/parent/profile`         (update profile fields)
/// - `POST /api/parent/profile/image`  (multipart avatar upload)
abstract interface class ParentProfileRepository {
  Future<void> initialize();

  /// Loads the freshest profile of the currently-authenticated parent.
  Future<ParentEntity> getProfile();

  /// Updates editable profile fields. The backend currently accepts a
  /// single `name` field; this signature keeps it `String?` so a future
  /// version can add email / phone without breaking callers.
  Future<ParentEntity> updateProfile({
    String? name,
  });

  /// Uploads a new avatar image and returns the updated profile (with the
  /// new `profileImageUrl` populated). [imagePath] is a local filesystem
  /// path produced by `image_picker` or similar.
  Future<ParentEntity> uploadAvatar(String imagePath);
}
