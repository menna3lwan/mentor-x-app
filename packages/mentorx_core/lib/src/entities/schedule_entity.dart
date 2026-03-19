part of '../../mentorx_core.dart';

class ScheduleEntity extends Equatable {
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

  static final placeholder = ScheduleEntity(
    id: '',
    day: '',
    startTime: '',
    endTime: '',
  );

  @override
  List<Object?> get props => [id, day, startTime, endTime];
}
