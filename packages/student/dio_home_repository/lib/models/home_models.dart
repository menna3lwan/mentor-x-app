import 'package:mentorx_core/mentorx_core.dart';

final class CourseModel extends CourseSummaryEntity {
  const CourseModel({
    required super.id,
    required super.title,
    super.description,
    required super.thumbnailUrl,
    super.progressPercent,
    super.price,
    required super.enrolledCount,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: ModelParser.asString(json['courseId'] ?? json['id']),
      title: ModelParser.asString(json['courseTitle'] ?? json['title']),
      description: ModelParser.asString(json['description'] ?? json['courseDescription']),
      thumbnailUrl: ModelParser.asString(json['courseThumbnailUrl'] ?? json['thumbnailUrl'] ?? json['thumbnail_url']),
      progressPercent: ModelParser.asDouble(json['progress'] ?? json['progressPercent'] ?? json['progress_percent']),
      price: ModelParser.asDouble(json['price']),
      enrolledCount: ModelParser.asInt(json['enrolledCount'] ?? json['enrolled_count']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'thumbnail_url': thumbnailUrl,
        'progress_percent': progressPercent,
        'price': price,
        'enrolled_count': enrolledCount,
      };

  factory CourseModel.fromEntity(CourseSummaryEntity entity) {
    return CourseModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
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
    super.description,
    super.linkUrl,
    super.displayOrder,
    super.active = true,
    super.startDate,
    super.endDate,
    super.createdAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: ModelParser.asString(json['id']),
      imageUrl: ModelParser.asString(json['imageUrl'] ?? json['image_url']),
      title: ModelParser.asString(json['title'] ?? json['name']),
      description: ModelParser.asString(json['description']),
      linkUrl: ModelParser.asString(json['linkUrl'] ?? json['link_url'] ?? json['deepLink'] ?? json['deep_link'] ?? json['actionValue'] ?? json['action_value']),
      displayOrder: ModelParser.asInt(json['displayOrder'] ?? json['display_order']),
      active: ModelParser.asBool(json['active'], fallback: true),
      startDate: ModelParser.asDateTime(json['startDate'] ?? json['start_date']),
      endDate: ModelParser.asDateTime(json['endDate'] ?? json['end_date']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'title': title,
        'description': description,
        'linkUrl': linkUrl,
        'displayOrder': displayOrder,
        'active': active,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'createdAt': createdAt?.toIso8601String(),
      };

  factory BannerModel.fromEntity(BannerEntity entity) {
    return BannerModel(
      id: entity.id,
      imageUrl: entity.imageUrl,
      title: entity.title,
      description: entity.description,
      linkUrl: entity.linkUrl,
      displayOrder: entity.displayOrder,
      active: entity.active,
      startDate: entity.startDate,
      endDate: entity.endDate,
      createdAt: entity.createdAt,
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
    super.expireAt,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title']),
      content: ModelParser.asString(json['description'] ?? json['content'] ?? json['body']),
      preview: ModelParser.asString(json['preview'] ?? json['content'] ?? json['summary'] ?? json['description']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at'] ?? json['announcementDate']) ?? DateTime.now(),
      isPinned: ModelParser.asBool(json['isPinned'] ?? json['is_pinned']),
      expireAt: ModelParser.asDateTime(json['expiryDate'] ?? json['expireAt']),
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
    super.walletId,
    super.studentId,
    super.studentName,
    required super.walletBalance,
    super.totalDeposited = 0,
    super.totalSpent = 0,
    super.totalRefunded = 0,
    super.isActive = true,
    super.isVerified = false,
    super.formattedBalance,
    super.points = 0,
    super.spentThisMonth = 0,
    super.totalCreditsThisMonth = 0,
    super.totalTransactions = 0,
    super.createdAt,
    super.updatedAt,
  });

  factory WalletSummaryModel.fromJson(Map<String, dynamic> json) {
    return WalletSummaryModel(
      walletId: ModelParser.asString(json['id']),
      studentId: ModelParser.asString(json['studentId'] ?? json['student_id']),
      studentName: ModelParser.asString(json['studentName'] ?? json['student_name']),
      walletBalance: ModelParser.asDouble(json['balance'] ?? json['walletBalance'] ?? json['wallet_balance']),
      totalDeposited: ModelParser.asDouble(json['totalDeposited'] ?? json['total_deposited']),
      totalSpent: ModelParser.asDouble(json['totalSpent'] ?? json['total_spent']),
      totalRefunded: ModelParser.asDouble(json['totalRefunded'] ?? json['total_refunded']),
      isActive: ModelParser.asBool(json['isActive'] ?? json['is_active'], fallback: true),
      isVerified: ModelParser.asBool(json['isVerified'] ?? json['is_verified']),
      formattedBalance: ModelParser.asString(json['formattedBalance'] ?? json['formatted_balance']),
      points: ModelParser.asInt(json['totalPoints'] ?? json['total_points'] ?? json['points']),
      spentThisMonth: ModelParser.asDouble(json['spentThisMonth'] ?? json['spent_this_month']),
      totalCreditsThisMonth: ModelParser.asDouble(json['totalCreditsThisMonth'] ?? json['total_credits_this_month']),
      totalTransactions: ModelParser.asInt(json['totalTransactions'] ?? json['total_transactions']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']),
      updatedAt: ModelParser.asDateTime(json['updatedAt'] ?? json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': walletId,
        'balance': walletBalance,
        'total_points': points,
        'spent_this_month': spentThisMonth,
        'total_credits_this_month': totalCreditsThisMonth,
        'total_transactions': totalTransactions,
      };

  factory WalletSummaryModel.fromEntity(WalletSummaryEntity entity) {
    return WalletSummaryModel(
      walletId: entity.walletId,
      walletBalance: entity.walletBalance,
      points: entity.points,
      spentThisMonth: entity.spentThisMonth,
      totalCreditsThisMonth: entity.totalCreditsThisMonth,
      totalTransactions: entity.totalTransactions,
    );
  }
}
