part of 'package:mentorx_core/mentorx_core.dart';

enum QuizQuestionType { multipleChoice, trueFalse, shortAnswer, essay, fillInTheBlank }


class QuizQuestionEntity extends Equatable {
  final String id;
  final String text;
  final String? imageUrl;
  final QuizQuestionType type;
  final List<String> options;
  final int mark;
  final int? optionsCount;
  final int order;

  const QuizQuestionEntity({
    required this.id,
    required this.text,
    required this.type,
    this.imageUrl,
    this.options = const [],
    this.mark = 0,
    this.optionsCount,
    this.order = 0,
  });

  static const placeholder = QuizQuestionEntity(
    id: '',
    text: '',
    type: QuizQuestionType.multipleChoice,
  );

  @override
  List<Object?> get props => [
        id,
        text,
        type,
        imageUrl,
        options,
        mark,
        optionsCount,
        order,
      ];

  QuizQuestionEntity copyWith({
    String? id,
    String? text,
    QuizQuestionType? type,
    String? imageUrl,
    List<String>? options,
    int? mark,
    int? optionsCount,
    int? order,
  }) {
    return QuizQuestionEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      options: options ?? this.options,
      mark: mark ?? this.mark,
      optionsCount: optionsCount ?? this.optionsCount,
      order: order ?? this.order,
    );
  }
}
