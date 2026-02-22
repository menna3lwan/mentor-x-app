part of '../mentorx_core.dart';

enum QuizQuestionType { mcqSingle, mcqMultiple, trueFalse, fillBlank, text }

final class QuizQuestionEntity extends Equatable {
  final String id;
  final String questionText;
  final String? questionImageUrl;
  final QuizQuestionType questionType;
  final List<String> options;
  final int marks;
  final int negativeMarks;
  final String? explanation;
  final int order;

  const QuizQuestionEntity({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.marks,
    this.questionImageUrl,
    this.options = const [],
    this.negativeMarks = 0,
    this.explanation,
    this.order = 0,
  });

  @override
  List<Object?> get props => [
        id,
        questionText,
        questionImageUrl,
        questionType,
        options,
        marks,
        negativeMarks,
        explanation,
        order,
      ];
}
