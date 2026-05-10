part of 'package:mentorx_core/mentorx_core.dart';

class WeekEntity extends Equatable {
  final String id;
  final String sessionId;
  final String title;
  final int orderIndex;
  final List<SessionItemEntity> items;

  const WeekEntity({
    required this.id,
    required this.sessionId,
    required this.title,
    this.orderIndex = 0,
    this.items = const [],
  });

  @override
  List<Object?> get props => [id, sessionId, title, orderIndex, items];

  WeekEntity copyWith({
    String? id,
    String? sessionId,
    String? title,
    int? orderIndex,
    List<SessionItemEntity>? items,
  }) {
    return WeekEntity(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      title: title ?? this.title,
      orderIndex: orderIndex ?? this.orderIndex,
      items: items ?? this.items,
    );
  }
}
