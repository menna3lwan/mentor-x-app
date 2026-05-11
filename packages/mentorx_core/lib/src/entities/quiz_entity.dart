part of 'package:mentorx_core/mentorx_core.dart';

class QuizEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final bool active;
  final bool deleted;
  final bool timeRestricted;
  final int durationMinutes;
  final DateTime? deadline;
  final String? weekId;
  final String? courseId;
  final List<QuizQuestionEntity> questions;
  final int totalMarks;
  final int passMarks;
  final int? questionsCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const QuizEntity({
    required this.id,
    required this.title,
    this.description,
    this.active = true,
    this.deleted = false,
    this.timeRestricted = false,
    required this.durationMinutes,
    this.deadline,
    this.weekId,
    this.courseId,
    this.questions = const [],
    required this.totalMarks,
    this.passMarks = 0,
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
        description,
        active,
        deleted,
        timeRestricted,
        durationMinutes,
        deadline,
        weekId,
        courseId,
        questions,
        totalMarks,
        passMarks,
        questionsCount,
        createdAt,
        updatedAt,
      ];

  QuizEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? active,
    bool? deleted,
    bool? timeRestricted,
    int? durationMinutes,
    DateTime? deadline,
    String? weekId,
    String? courseId,
    List<QuizQuestionEntity>? questions,
    int? totalMarks,
    int? passMarks,
    int? questionsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return QuizEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      active: active ?? this.active,
      deleted: deleted ?? this.deleted,
      timeRestricted: timeRestricted ?? this.timeRestricted,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      deadline: deadline ?? this.deadline,
      weekId: weekId ?? this.weekId,
      courseId: courseId ?? this.courseId,
      questions: questions ?? this.questions,
      totalMarks: totalMarks ?? this.totalMarks,
      passMarks: passMarks ?? this.passMarks,
      questionsCount: questionsCount ?? this.questionsCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
