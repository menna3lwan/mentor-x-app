part of '../mentorx_core.dart';

final class SessionEntity extends Equatable {
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
}
