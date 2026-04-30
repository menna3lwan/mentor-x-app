part of 'package:mentorx_core/mentorx_core.dart';

class AssignmentEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final DateTime? deadline;
  final int totalMarks;
  final List<QuizQuestionEntity> questions;
  final int? questionsCount;
  final String? instructions;
  final String? fileUrl;
  final String? fileName;
  final bool active;
  final bool deleted;
  final String? weekId;
  final String? courseId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AssignmentEntity({
    required this.id,
    required this.title,
    this.description,
    this.deadline,
    this.totalMarks = 0,
    this.questions = const [],
    this.questionsCount,
    this.instructions,
    this.fileUrl,
    this.fileName,
    this.active = true,
    this.deleted = false,
    this.weekId,
    this.courseId,
    this.createdAt,
    this.updatedAt,
  });

  /// Backward compatibility alias for [deadline]
  DateTime get dueDate => deadline ?? DateTime.fromMillisecondsSinceEpoch(0);
  bool get isOverdue => deadline != null && DateTime.now().isAfter(deadline!);
  DateTime get deadlineAt => dueDate;
  int get maxScore => totalMarks;

  static final placeholder = AssignmentEntity(
    id: '',
    title: '',
    deadline: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        deadline,
        totalMarks,
        questions,
        questionsCount,
        instructions,
        fileUrl,
        fileName,
        active,
        deleted,
        weekId,
        courseId,
        createdAt,
        updatedAt,
      ];

  AssignmentEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? deadline,
    int? totalMarks,
    List<QuizQuestionEntity>? questions,
    int? questionsCount,
    String? instructions,
    String? fileUrl,
    String? fileName,
    bool? active,
    bool? deleted,
    String? weekId,
    String? courseId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AssignmentEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      totalMarks: totalMarks ?? this.totalMarks,
      questions: questions ?? this.questions,
      questionsCount: questionsCount ?? this.questionsCount,
      instructions: instructions ?? this.instructions,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
      active: active ?? this.active,
      deleted: deleted ?? this.deleted,
      weekId: weekId ?? this.weekId,
      courseId: courseId ?? this.courseId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
