import 'package:mentorx_core/mentorx_core.dart';

final class CourseModel extends CourseSummaryEntity {
  const CourseModel({
    required super.id,
    required super.title,
    required super.thumbnailUrl,
    super.progressPercent,
    super.price,
    required super.enrolledCount,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      thumbnailUrl:
          (json['thumbnailUrl'] ?? json['thumbnail_url'])?.toString() ?? '',
      progressPercent: _toDoubleOrNull(
        json['progressPercent'] ?? json['progress_percent'],
      ),
      price: _toDoubleOrNull(json['price']),
      enrolledCount: _toInt(json['enrolledCount'] ?? json['enrolled_count']),
    );
  }
}

final class BannerModel extends BannerEntity {
  const BannerModel({
    required super.id,
    required super.imageUrl,
    super.title,
    super.deepLink,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id']?.toString() ?? '',
      imageUrl: (json['imageUrl'] ?? json['image_url'])?.toString() ?? '',
      title: (json['title'] ?? json['name'])?.toString(),
      deepLink: (json['deepLink'] ?? json['deep_link'])?.toString() ??
          (json['actionValue'] ?? json['action_value'])?.toString(),
    );
  }
}

final class AnnouncementModel extends AnnouncementEntity {
  const AnnouncementModel({
    required super.id,
    required super.title,
    required super.content,
    super.preview,
    required super.createdAt,
    super.isPinned = false,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? json['preview']?.toString() ?? '',
      preview: json['preview']?.toString() ?? json['content']?.toString() ?? '',
      createdAt:
          DateTime.tryParse(
            (json['createdAt'] ?? json['created_at'])?.toString() ?? '',
          ) ??
          DateTime.now(),
      isPinned: _toBool(json['isPinned'] ?? json['is_pinned']),
    );
  }
}

final class WalletSummaryModel extends WalletSummaryEntity {
  const WalletSummaryModel({
    required super.walletBalance,
    required super.points,
  });

  factory WalletSummaryModel.fromJson(Map<String, dynamic> json) {
    final balance = _toDouble(json['walletBalance'] ?? json['wallet_balance']);
    final points = _toInt(json['totalPoints'] ?? json['total_points']);
    return WalletSummaryModel(
      walletBalance: balance,
      points: points,
    );
  }
}

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

double _toDouble(dynamic value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

double? _toDoubleOrNull(dynamic value) {
  if (value == null) return null;
  return _toDouble(value);
}

bool _toBool(dynamic value) {
  if (value is bool) return value;
  final normalized = value?.toString().toLowerCase();
  return normalized == 'true' || normalized == '1';
}
