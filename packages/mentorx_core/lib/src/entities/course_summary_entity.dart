part of 'package:mentorx_core/mentorx_core.dart';

/// Lightweight course representation for lists and home dashboard sections.
base class CourseSummaryEntity extends Equatable {
  final String id;
  final String title;
  final String thumbnailUrl;
  final double? progressPercent;
  final double? price;
  final int enrolledCount;

  const CourseSummaryEntity({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.enrolledCount,
    this.progressPercent,
    this.price,
  });

  bool get isFree => (price ?? 0) <= 0;

  static const placeholder = CourseSummaryEntity(
    id: '',
    title: '',
    thumbnailUrl: '',
    enrolledCount: 0,
  );

  @override
  List<Object?> get props => [
        id,
        title,
        thumbnailUrl,
        progressPercent,
        price,
        enrolledCount,
      ];

  CourseSummaryEntity copyWith({
    String? id,
    String? title,
    String? thumbnailUrl,
    double? progressPercent,
    double? price,
    int? enrolledCount,
  }) {
    return CourseSummaryEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      progressPercent: progressPercent ?? this.progressPercent,
      price: price ?? this.price,
      enrolledCount: enrolledCount ?? this.enrolledCount,
    );
  }
}
