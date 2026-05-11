part of 'package:mentorx_core/mentorx_core.dart';

enum CourseType { online, center, both }

enum OrderingMode { free, sequential, lockSession, lockItem }

base class CourseEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? subtitle;
  final String? imageUrl;
  final double price;
  final double? oldPrice;
  final bool isFree;
  final bool isActive;
  final int orderNumber;
  final CourseType type;
  final OrderingMode orderingMode;
  final int? durationDays;
  final int pointsReward;
  final String? gradeId;
  final String? categoryId;
  final List<String> categoryIds;
  final int totalSessions;
  final int totalVideos;
  final int totalDurationMinutes;
  final int enrolledCount;
  final bool featured;
  final bool pinned;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CourseEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.enrolledCount,
    this.description,
    this.subtitle,
    this.imageUrl,
    this.oldPrice,
    this.isFree = false,
    this.isActive = true,
    this.orderNumber = 0,
    this.type = CourseType.online,
    this.orderingMode = OrderingMode.free,
    this.durationDays,
    this.pointsReward = 0,
    this.gradeId,
    this.categoryId,
    this.categoryIds = const [],
    this.totalSessions = 0,
    this.totalVideos = 0,
    this.totalDurationMinutes = 0,
    this.featured = false,
    this.pinned = false,
    this.createdAt,
    this.updatedAt,
  });

  static const placeholder = CourseEntity(
    id: '',
    title: '',
    price: 0.0,
    enrolledCount: 0,
  );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        subtitle,
        imageUrl,
        price,
        oldPrice,
        isFree,
        isActive,
        orderNumber,
        type,
        orderingMode,
        durationDays,
        pointsReward,
        gradeId,
        categoryId,
        categoryIds,
        totalSessions,
        totalVideos,
        totalDurationMinutes,
        enrolledCount,
        featured,
        pinned,
        createdAt,
        updatedAt,
      ];

  CourseEntity copyWith({
    String? id,
    String? title,
    MentorXNullableValue<String?>? description,
    MentorXNullableValue<String?>? subtitle,
    MentorXNullableValue<String?>? imageUrl,
    double? price,
    MentorXNullableValue<double?>? oldPrice,
    bool? isFree,
    bool? isActive,
    int? orderNumber,
    CourseType? type,
    OrderingMode? orderingMode,
    MentorXNullableValue<int?>? durationDays,
    int? pointsReward,
    MentorXNullableValue<String?>? gradeId,
    MentorXNullableValue<String?>? categoryId,
    List<String>? categoryIds,
    int? totalSessions,
    int? totalVideos,
    int? totalDurationMinutes,
    int? enrolledCount,
    bool? featured,
    bool? pinned,
    MentorXNullableValue<DateTime?>? createdAt,
    MentorXNullableValue<DateTime?>? updatedAt,
  }) {
    return CourseEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description != null ? description.value : this.description,
      subtitle: subtitle != null ? subtitle.value : this.subtitle,
      imageUrl: imageUrl != null ? imageUrl.value : this.imageUrl,
      price: price ?? this.price,
      oldPrice: oldPrice != null ? oldPrice.value : this.oldPrice,
      isFree: isFree ?? this.isFree,
      isActive: isActive ?? this.isActive,
      orderNumber: orderNumber ?? this.orderNumber,
      type: type ?? this.type,
      orderingMode: orderingMode ?? this.orderingMode,
      durationDays: durationDays != null ? durationDays.value : this.durationDays,
      pointsReward: pointsReward ?? this.pointsReward,
      gradeId: gradeId != null ? gradeId.value : this.gradeId,
      categoryId: categoryId != null ? categoryId.value : this.categoryId,
      categoryIds: categoryIds ?? this.categoryIds,
      totalSessions: totalSessions ?? this.totalSessions,
      totalVideos: totalVideos ?? this.totalVideos,
      totalDurationMinutes: totalDurationMinutes ?? this.totalDurationMinutes,
      enrolledCount: enrolledCount ?? this.enrolledCount,
      featured: featured ?? this.featured,
      pinned: pinned ?? this.pinned,
      createdAt: createdAt != null ? createdAt.value : this.createdAt,
      updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
    );
  }
}
