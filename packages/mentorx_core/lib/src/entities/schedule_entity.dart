part of 'package:mentorx_core/mentorx_core.dart';

base class ScheduleEntity extends Equatable {
  final String id;
  final String day;
  final String startTime;
  final String endTime;

  const ScheduleEntity({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  String get displayName => '$day ($startTime - $endTime)';

  static const placeholder = ScheduleEntity(
    id: '',
    day: '',
    startTime: '',
    endTime: '',
  );

  @override
  List<Object?> get props => [id, day, startTime, endTime];

  ScheduleEntity copyWith({
    String? id,
    String? day,
    String? startTime,
    String? endTime,
  }) {
    return ScheduleEntity(
      id: id ?? this.id,
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
