part of 'package:mentorx_core/mentorx_core.dart';

/// Lightweight course representation for lists and home dashboard sections.
class CourseSummaryEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String thumbnailUrl;
  final double? progressPercent;
  final double? price;
  final int enrolledCount;

  const CourseSummaryEntity({
    required this.id,
    required this.title,
    this.description,
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
        description,
        thumbnailUrl,
        progressPercent,
        price,
        enrolledCount,
      ];

  CourseSummaryEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? thumbnailUrl,
    double? progressPercent,
    double? price,
    int? enrolledCount,
  }) {
    return CourseSummaryEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      progressPercent: progressPercent ?? this.progressPercent,
      price: price ?? this.price,
      enrolledCount: enrolledCount ?? this.enrolledCount,
    );
  }
}
