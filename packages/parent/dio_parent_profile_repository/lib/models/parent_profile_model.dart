import 'package:mentorx_core/mentorx_core.dart';

/// Wire model for the parent profile. Reuses the same forgiving snake/camel
/// parsing as the auth-flow `ParentModel`, but lives inside the profile
/// package so the auth package isn't forced to expose its internals.
final class ParentProfileModel extends ParentEntity {
  const ParentProfileModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    super.email,
    required super.phoneNumber,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.profileImageUrl,
    super.childrenCount,
    super.walletBalance,
    super.totalPoints,
    super.metadata,
  });

  factory ParentProfileModel.fromJson(Map<String, dynamic> json) {
    // Backend nests the parent under `user` in some envelopes (login) and
    // returns it at root in others (profile). Handle both.
    final user = json['user'] is Map
        ? Map<String, dynamic>.from(json['user'] as Map)
        : json;

    final String fullName = ModelParser.asString(user['name']);
    final nameParts = fullName.trim().split(RegExp(r'\s+'));
    final String fallbackFirst = nameParts.isEmpty ? '' : nameParts.first;
    final String fallbackLast =
        nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return ParentProfileModel(
      id: ModelParser.asString(user['id'] ?? user['userId']),
      firstName: ModelParser.asString(
        user['firstName'] ?? user['first_name'],
        fallback: fallbackFirst,
      ),
      lastName: ModelParser.asString(
        user['lastName'] ?? user['last_name'],
        fallback: fallbackLast,
      ),
      email: _stringOrNull(user['email']),
      phoneNumber: ModelParser.asString(
        user['phone'] ?? user['phoneNumber'] ?? user['phone_number'],
      ),
      profileImageUrl: _stringOrNull(
        user['profileImageUrl'] ??
            user['profileImage'] ??
            user['avatarUrl'] ??
            user['profile_photo_url'] ??
            user['profile_image_url'],
      ),
      status: _parseStatus(user['status']),
      childrenCount: ModelParser.asInt(
        user['childrenCount'] ?? user['children_count'],
      ),
      walletBalance: ModelParser.asDouble(
        user['walletBalance'] ?? user['wallet_balance'],
      ),
      totalPoints: ModelParser.asInt(
        user['totalPoints'] ?? user['total_points'],
      ),
      metadata: user['metadata'] is Map
          ? Map<String, dynamic>.from(user['metadata'] as Map)
          : null,
      createdAt:
          ModelParser.asDateTime(user['createdAt'] ?? user['created_at']) ??
          DateTime.now(),
      updatedAt:
          ModelParser.asDateTime(user['updatedAt'] ?? user['updated_at']) ??
          DateTime.now(),
    );
  }

  static String? _stringOrNull(dynamic value) {
    if (value == null) return null;
    final str = value.toString().trim();
    return str.isEmpty ? null : str;
  }

  static ParentStatus _parseStatus(dynamic value) {
    if (value == null) return ParentStatus.pending;
    final str = value.toString().toLowerCase();
    return ParentStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => ParentStatus.pending,
    );
  }
}
