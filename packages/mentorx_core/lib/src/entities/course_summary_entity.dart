part of '../../mentorx_core.dart';

/// Lightweight course representation for lists and home dashboard sections.
final class CourseSummaryEntity extends Equatable {
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


  static final placeholder = CourseSummaryEntity(
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
}
