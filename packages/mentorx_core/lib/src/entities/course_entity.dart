part of 'package:mentorx_core/mentorx_core.dart';

enum CourseType { online, center, both }

enum OrderingMode { free, sequential, lockSession, lockItem }

class CourseEntity extends Equatable {
  final String id;
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final double price;
  final double? oldPrice;
  final bool isFree;
  final bool isActive;
  final CourseType type;
  final OrderingMode orderingMode;
  final int? durationDays;
  final int pointsReward;
  final String? gradeId;
  final String? categoryId;
  final int totalSessions;
  final int totalVideos;
  final int totalDurationMinutes;
  final int enrolledCount;
  final bool featured;
  final bool pinned;

  const CourseEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.enrolledCount,
    this.subtitle,
    this.imageUrl,
    this.oldPrice,
    this.isFree = false,
    this.isActive = true,
    this.type = CourseType.online,
    this.orderingMode = OrderingMode.free,
    this.durationDays,
    this.pointsReward = 0,
    this.gradeId,
    this.categoryId,
    this.totalSessions = 0,
    this.totalVideos = 0,
    this.totalDurationMinutes = 0,
    this.featured = false,
    this.pinned = false,
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
        subtitle,
        imageUrl,
        price,
        oldPrice,
        isFree,
        isActive,
        type,
        orderingMode,
        durationDays,
        pointsReward,
        gradeId,
        categoryId,
        totalSessions,
        totalVideos,
        totalDurationMinutes,
        enrolledCount,
        featured,
        pinned,
      ];

  CourseEntity copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? imageUrl,
    double? price,
    double? oldPrice,
    bool? isFree,
    bool? isActive,
    CourseType? type,
    OrderingMode? orderingMode,
    int? durationDays,
    int? pointsReward,
    String? gradeId,
    String? categoryId,
    int? totalSessions,
    int? totalVideos,
    int? totalDurationMinutes,
    int? enrolledCount,
    bool? featured,
    bool? pinned,
  }) {
    return CourseEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      isFree: isFree ?? this.isFree,
      isActive: isActive ?? this.isActive,
      type: type ?? this.type,
      orderingMode: orderingMode ?? this.orderingMode,
      durationDays: durationDays ?? this.durationDays,
      pointsReward: pointsReward ?? this.pointsReward,
      gradeId: gradeId ?? this.gradeId,
      categoryId: categoryId ?? this.categoryId,
      totalSessions: totalSessions ?? this.totalSessions,
      totalVideos: totalVideos ?? this.totalVideos,
      totalDurationMinutes: totalDurationMinutes ?? this.totalDurationMinutes,
      enrolledCount: enrolledCount ?? this.enrolledCount,
      featured: featured ?? this.featured,
      pinned: pinned ?? this.pinned,
    );
  }
}
