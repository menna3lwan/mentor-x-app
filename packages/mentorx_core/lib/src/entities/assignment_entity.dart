part of 'package:mentorx_core/mentorx_core.dart';

class AssignmentEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final int totalMarks;
  final List<QuizQuestionEntity> questions;
  final int? questionsCount;
  final String? instructions;
  final String? fileUrl;
  final String? fileName;


  const AssignmentEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.totalMarks,
    this.questions = const [],
    this.questionsCount,
    this.instructions,
    this.fileUrl,
    this.fileName,
  });

  bool get isOverdue => DateTime.now().isAfter(dueDate);
  DateTime get deadlineAt => dueDate;
  int get maxScore => totalMarks;


  static final placeholder = AssignmentEntity(
    id: '',
    title: '',
    description: '',
    dueDate: DateTime.fromMillisecondsSinceEpoch(0),
    totalMarks: 0,
  );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        dueDate,
        totalMarks,
        questions,
        questionsCount,
        instructions,
        fileUrl,
        fileName,
      ];

  AssignmentEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    int? totalMarks,
    List<QuizQuestionEntity>? questions,
    int? questionsCount,
    String? instructions,
    String? fileUrl,
    String? fileName,
  }) {
    return AssignmentEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      totalMarks: totalMarks ?? this.totalMarks,
      questions: questions ?? this.questions,
      questionsCount: questionsCount ?? this.questionsCount,
      instructions: instructions ?? this.instructions,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
    );
  }
}
