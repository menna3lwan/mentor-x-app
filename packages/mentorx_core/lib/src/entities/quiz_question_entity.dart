part of 'package:mentorx_core/mentorx_core.dart';

enum QuizQuestionType { multipleChoice, trueFalse, shortAnswer, essay, fillInTheBlank }

class QuizQuestionEntity extends Equatable {
  final String id;
  final String description;
  final String? imageUrl;
  final int mark;
  final List<String> options;
  final int? optionsCount;
  final QuizQuestionType type;
  final int order;

  const QuizQuestionEntity({
    required this.id,
    required this.description,
    this.imageUrl,
    this.mark = 0,
    this.options = const [],
    this.optionsCount,
    this.type = QuizQuestionType.multipleChoice,
    this.order = 0,
  });

  static const placeholder = QuizQuestionEntity(
    id: '',
    description: '',
  );

  @override
  List<Object?> get props => [
        id,
        description,
        imageUrl,
        mark,
        options,
        optionsCount,
        type,
        order,
      ];

  QuizQuestionEntity copyWith({
    String? id,
    String? description,
    MentorXNullableValue<String?>? imageUrl,
    int? mark,
    List<String>? options,
    MentorXNullableValue<int?>? optionsCount,
    QuizQuestionType? type,
    int? order,
  }) {
    return QuizQuestionEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      imageUrl: imageUrl != null ? imageUrl.value : this.imageUrl,
      mark: mark ?? this.mark,
      options: options ?? this.options,
      optionsCount:
          optionsCount != null ? optionsCount.value : this.optionsCount,
      type: type ?? this.type,
      order: order ?? this.order,
    );
  }
}
