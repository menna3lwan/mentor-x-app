part of 'package:mentorx_core/mentorx_core.dart';

class SessionEntity extends Equatable {
  final String id;
  final String courseId;
  final String title;
  final int orderIndex;
  final bool isFree;
  final double? price;
  final DateTime? availableFrom;
  final DateTime? availableUntil;
  final int itemCount;

  const SessionEntity({
    required this.id,
    required this.courseId,
    required this.title,
    required this.orderIndex,
    this.isFree = false,
    this.price,
    this.availableFrom,
    this.availableUntil,
    this.itemCount = 0,
  });

  static const placeholder = SessionEntity(
    id: '',
    courseId: '',
    title: '',
    orderIndex: 0,
  );

  @override
  List<Object?> get props => [
        id,
        courseId,
        title,
        orderIndex,
        isFree,
        price,
        availableFrom,
        availableUntil,
        itemCount,
      ];

  SessionEntity copyWith({
    String? id,
    String? courseId,
    String? title,
    int? orderIndex,
    bool? isFree,
    double? price,
    DateTime? availableFrom,
    DateTime? availableUntil,
    int? itemCount,
  }) {
    return SessionEntity(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      orderIndex: orderIndex ?? this.orderIndex,
      isFree: isFree ?? this.isFree,
      price: price ?? this.price,
      availableFrom: availableFrom ?? this.availableFrom,
      availableUntil: availableUntil ?? this.availableUntil,
      itemCount: itemCount ?? this.itemCount,
    );
  }
}
