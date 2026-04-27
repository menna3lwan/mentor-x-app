part of 'package:mentorx_core/mentorx_core.dart';

class QuizEntity extends Equatable {
  final String id;
  final String title;
  final bool active;
  final bool timeRestricted;
  final int durationMinutes;
  final List<QuizQuestionEntity> questions;
  final int totalMarks;
  final int? questionsCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const QuizEntity({
    required this.id,
    required this.title,
    this.active = true,
    this.timeRestricted = false,
    required this.durationMinutes,
    this.questions = const [],
    required this.totalMarks,
    this.questionsCount,
    this.createdAt,
    this.updatedAt,
  });

  static const placeholder = QuizEntity(
    id: '',
    title: '',
    durationMinutes: 0,
    totalMarks: 0,
  );

  @override
  List<Object?> get props => [
        id,
        title,
        active,
        timeRestricted,
        durationMinutes,
        questions,
        totalMarks,
        questionsCount,
        createdAt,
        updatedAt,
      ];

  QuizEntity copyWith({
    String? id,
    String? title,
    bool? active,
    bool? timeRestricted,
    int? durationMinutes,
    List<QuizQuestionEntity>? questions,
    int? totalMarks,
    int? questionsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return QuizEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      active: active ?? this.active,
      timeRestricted: timeRestricted ?? this.timeRestricted,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      questions: questions ?? this.questions,
      totalMarks: totalMarks ?? this.totalMarks,
      questionsCount: questionsCount ?? this.questionsCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
