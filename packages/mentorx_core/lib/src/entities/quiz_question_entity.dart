part of 'package:mentorx_core/mentorx_core.dart';

enum QuizQuestionType { multipleChoice, trueFalse, shortAnswer, essay, fillInTheBlank }


class QuizQuestionEntity extends Equatable {
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

  static const placeholder = QuizQuestionEntity(
    id: '',
    questionText: '',
    questionType: QuizQuestionType.multipleChoice,
    marks: 0,
  );

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

  QuizQuestionEntity copyWith({
    String? id,
    String? questionText,
    String? questionImageUrl,
    QuizQuestionType? questionType,
    List<String>? options,
    int? marks,
    int? negativeMarks,
    String? explanation,
    int? order,
  }) {
    return QuizQuestionEntity(
      id: id ?? this.id,
      questionText: questionText ?? this.questionText,
      questionImageUrl: questionImageUrl ?? this.questionImageUrl,
      questionType: questionType ?? this.questionType,
      options: options ?? this.options,
      marks: marks ?? this.marks,
      negativeMarks: negativeMarks ?? this.negativeMarks,
      explanation: explanation ?? this.explanation,
      order: order ?? this.order,
    );
  }
}
