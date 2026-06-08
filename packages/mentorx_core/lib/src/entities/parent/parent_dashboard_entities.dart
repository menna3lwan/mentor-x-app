part of 'package:mentorx_core/mentorx_core.dart';

/// Status of an upcoming session as surfaced to a parent.
enum ParentSessionStatus { scheduled, live, completed, missed, cancelled }

/// A lightweight, parent-context view of a session that's scheduled for
/// (or recently happened to) a linked child. Intentionally a flatter shape
/// than the student-facing [SessionEntity] — parents only need the at-a-glance
/// fields.
class ParentUpcomingSessionEntity extends Equatable {
  final String id;
  final String title;
  final String courseName;
  final String? teacherName;
  final DateTime scheduledAt;
  final Duration? duration;
  final ParentSessionStatus status;
  final String? location;

  const ParentUpcomingSessionEntity({
    required this.id,
    required this.title,
    required this.courseName,
    required this.scheduledAt,
    required this.status,
    this.teacherName,
    this.duration,
    this.location,
  });

  static final placeholder = ParentUpcomingSessionEntity(
    id: '',
    title: '',
    courseName: '',
    scheduledAt: DateTime.fromMillisecondsSinceEpoch(0),
    status: ParentSessionStatus.scheduled,
  );

  @override
  List<Object?> get props => [
    id,
    title,
    courseName,
    teacherName,
    scheduledAt,
    duration,
    status,
    location,
  ];

  ParentUpcomingSessionEntity copyWith({
    String? id,
    String? title,
    String? courseName,
    String? teacherName,
    DateTime? scheduledAt,
    Duration? duration,
    ParentSessionStatus? status,
    String? location,
  }) {
    return ParentUpcomingSessionEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      courseName: courseName ?? this.courseName,
      teacherName: teacherName ?? this.teacherName,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      location: location ?? this.location,
    );
  }
}

/// What kind of evaluation produced a [ParentRecentGradeEntity].
enum ParentGradeKind { quiz, assignment, exam, project, other }

/// A lightweight, parent-context grade entry. The parent UI needs the score
/// and pass/fail signal, not the full attempt/submission graph used inside the
/// student app.
class ParentRecentGradeEntity extends Equatable {
  final String id;
  final ParentGradeKind kind;
  final String title;
  final String courseName;
  final double score;
  final double totalMarks;
  final double percentage;
  final bool? passed;
  final DateTime gradedAt;

  const ParentRecentGradeEntity({
    required this.id,
    required this.kind,
    required this.title,
    required this.courseName,
    required this.score,
    required this.totalMarks,
    required this.percentage,
    required this.gradedAt,
    this.passed,
  });

  static final placeholder = ParentRecentGradeEntity(
    id: '',
    kind: ParentGradeKind.other,
    title: '',
    courseName: '',
    score: 0,
    totalMarks: 0,
    percentage: 0,
    gradedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  /// e.g. "8 / 10" — convenience for UI labels.
  String get scoreLabel =>
      '${_trimZeros(score)} / ${_trimZeros(totalMarks)}';

  static String _trimZeros(double v) {
    if (v == v.roundToDouble()) return v.toInt().toString();
    return v.toStringAsFixed(1);
  }

  @override
  List<Object?> get props => [
    id,
    kind,
    title,
    courseName,
    score,
    totalMarks,
    percentage,
    passed,
    gradedAt,
  ];

  ParentRecentGradeEntity copyWith({
    String? id,
    ParentGradeKind? kind,
    String? title,
    String? courseName,
    double? score,
    double? totalMarks,
    double? percentage,
    bool? passed,
    DateTime? gradedAt,
  }) {
    return ParentRecentGradeEntity(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      courseName: courseName ?? this.courseName,
      score: score ?? this.score,
      totalMarks: totalMarks ?? this.totalMarks,
      percentage: percentage ?? this.percentage,
      passed: passed ?? this.passed,
      gradedAt: gradedAt ?? this.gradedAt,
    );
  }
}
