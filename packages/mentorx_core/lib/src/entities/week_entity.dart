part of 'package:mentorx_core/mentorx_core.dart';

enum WeekLockType { none, date, afterDays }

class WeekEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final int orderNumber;
  final bool active;
  final List<String> sessionIds;
  final List<SessionItemEntity> materials;
  final WeekLockType lockType;
  final int? lockAfterDays;
  final DateTime? lockDate;
  final bool globallyLocked;
  final DateTime? createdAt;

  const WeekEntity({
    required this.id,
    required this.title,
    this.description,
    this.orderNumber = 0,
    this.active = true,
    this.sessionIds = const [],
    this.materials = const [],
    this.lockType = WeekLockType.none,
    this.lockAfterDays,
    this.lockDate,
    this.globallyLocked = false,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        orderNumber,
        active,
        sessionIds,
        materials,
        lockType,
        lockAfterDays,
        lockDate,
        globallyLocked,
        createdAt,
      ];

  WeekEntity copyWith({
    String? id,
    String? title,
    MentorXNullableValue<String?>? description,
    int? orderNumber,
    bool? active,
    List<String>? sessionIds,
    List<SessionItemEntity>? materials,
    WeekLockType? lockType,
    MentorXNullableValue<int?>? lockAfterDays,
    MentorXNullableValue<DateTime?>? lockDate,
    bool? globallyLocked,
    MentorXNullableValue<DateTime?>? createdAt,
  }) {
    return WeekEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description != null ? description.value : this.description,
      orderNumber: orderNumber ?? this.orderNumber,
      active: active ?? this.active,
      sessionIds: sessionIds ?? this.sessionIds,
      materials: materials ?? this.materials,
      lockType: lockType ?? this.lockType,
      lockAfterDays:
          lockAfterDays != null ? lockAfterDays.value : this.lockAfterDays,
      lockDate: lockDate != null ? lockDate.value : this.lockDate,
      globallyLocked: globallyLocked ?? this.globallyLocked,
      createdAt: createdAt != null ? createdAt.value : this.createdAt,
    );
  }
}
