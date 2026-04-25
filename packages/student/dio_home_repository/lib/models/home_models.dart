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
      id: (json['courseId'] ?? json['id'])?.toString() ?? '',
      title: (json['courseTitle'] ?? json['title'])?.toString() ?? '',
      thumbnailUrl: (json['courseThumbnailUrl'] ??
              json['thumbnailUrl'] ??
              json['thumbnail_url'])
          ?.toString() ??
          '',
      progressPercent: _toDoubleOrNull(
        json['progress'] ?? json['progressPercent'] ?? json['progress_percent'],
      ),
      price: _toDoubleOrNull(json['price']),
      enrolledCount: _toInt(json['enrolledCount'] ?? json['enrolled_count']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'thumbnail_url': thumbnailUrl,
        'progress_percent': progressPercent,
        'price': price,
        'enrolled_count': enrolledCount,
      };

  factory CourseModel.fromEntity(CourseSummaryEntity entity) {
    return CourseModel(
      id: entity.id,
      title: entity.title,
      thumbnailUrl: entity.thumbnailUrl,
      progressPercent: entity.progressPercent,
      price: entity.price,
      enrolledCount: entity.enrolledCount,
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'image_url': imageUrl,
        'title': title,
        'deep_link': deepLink,
      };

  factory BannerModel.fromEntity(BannerEntity entity) {
    return BannerModel(
      id: entity.id,
      imageUrl: entity.imageUrl,
      title: entity.title,
      deepLink: entity.deepLink,
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
      createdAt: DateTime.tryParse(
            (json['createdAt'] ?? json['created_at'])?.toString() ?? '',
          ) ??
          DateTime.now(),
      isPinned: _toBool(json['isPinned'] ?? json['is_pinned']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'preview': preview,
        'created_at': createdAt.toIso8601String(),
        'is_pinned': isPinned,
      };

  factory AnnouncementModel.fromEntity(AnnouncementEntity entity) {
    return AnnouncementModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      preview: entity.preview,
      createdAt: entity.createdAt,
      isPinned: entity.isPinned,
    );
  }
}

final class WalletSummaryModel extends WalletSummaryEntity {
  const WalletSummaryModel({
    required super.walletBalance,
    required super.points,
    super.spentThisMonth = 0,
    super.totalCreditsThisMonth = 0,
    super.totalTransactions = 0,
  });

  factory WalletSummaryModel.fromJson(Map<String, dynamic> json) {
    return WalletSummaryModel(
      walletBalance: _toDouble(
        json['walletBalance'] ?? json['wallet_balance'] ?? json['balance'],
      ),
      points: _toInt(json['totalPoints'] ?? json['total_points'] ?? json['points']),
      spentThisMonth: _toDouble(json['spentThisMonth'] ?? json['spent_this_month']),
      totalCreditsThisMonth: _toDouble(
        json['totalCreditsThisMonth'] ?? json['total_credits_this_month'],
      ),
      totalTransactions: _toInt(
        json['totalTransactions'] ?? json['total_transactions'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'wallet_balance': walletBalance,
        'total_points': points,
        'spent_this_month': spentThisMonth,
        'total_credits_this_month': totalCreditsThisMonth,
        'total_transactions': totalTransactions,
      };

  factory WalletSummaryModel.fromEntity(WalletSummaryEntity entity) {
    return WalletSummaryModel(
      walletBalance: entity.walletBalance,
      points: entity.points,
      spentThisMonth: entity.spentThisMonth,
      totalCreditsThisMonth: entity.totalCreditsThisMonth,
      totalTransactions: entity.totalTransactions,
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
  return double.tryParse(value?.toString() ?? '') ?? 0.0;
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
