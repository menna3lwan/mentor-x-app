part of 'package:mentorx_core/mentorx_core.dart';

class SessionEntity extends Equatable {
  final String id;
  final String courseId;
  final List<String> courseIds;
  final String title;
  final String? description;
  final int orderNumber;
  final bool active;
  final bool isFree;
  final double? price;
  final DateTime? availableFrom;
  final DateTime? availableUntil;
  final int itemCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SessionEntity({
    required this.id,
    required this.courseId,
    required this.title,
    this.courseIds = const [],
    this.description,
    this.orderNumber = 0,
    this.active = true,
    this.isFree = false,
    this.price,
    this.availableFrom,
    this.availableUntil,
    this.itemCount = 0,
    this.createdAt,
    this.updatedAt,
  });

  /// Backward compatibility alias for [orderNumber]
  int get orderIndex => orderNumber;

  static const placeholder = SessionEntity(
    id: '',
    courseId: '',
    title: '',
  );

  @override
  List<Object?> get props => [
        id,
        courseId,
        courseIds,
        title,
        description,
        orderNumber,
        active,
        isFree,
        price,
        availableFrom,
        availableUntil,
        itemCount,
        createdAt,
        updatedAt,
      ];

  SessionEntity copyWith({
    String? id,
    String? courseId,
    List<String>? courseIds,
    String? title,
    String? description,
    int? orderNumber,
    bool? active,
    bool? isFree,
    double? price,
    DateTime? availableFrom,
    DateTime? availableUntil,
    int? itemCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SessionEntity(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      courseIds: courseIds ?? this.courseIds,
      title: title ?? this.title,
      description: description ?? this.description,
      orderNumber: orderNumber ?? this.orderNumber,
      active: active ?? this.active,
      isFree: isFree ?? this.isFree,
      price: price ?? this.price,
      availableFrom: availableFrom ?? this.availableFrom,
      availableUntil: availableUntil ?? this.availableUntil,
      itemCount: itemCount ?? this.itemCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
