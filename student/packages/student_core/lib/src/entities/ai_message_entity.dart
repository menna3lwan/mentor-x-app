part of '../../student_core.dart';

enum AIMessageRole { user, assistant, system }

final class AIMessageEntity extends Equatable {
  final String id;
  final String conversationId;
  final AIMessageRole role;
  final String content;
  final int? userRating;
  final String? userFeedback;
  final List<String>? sources;
  final String? confidence;
  final DateTime createdAt;

  const AIMessageEntity({
    required this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    required this.createdAt,
    this.userRating,
    this.userFeedback,
    this.sources,
    this.confidence,
  });

  @override
  List<Object?> get props => [
        id,
        conversationId,
        role,
        content,
        userRating,
        userFeedback,
        sources,
        confidence,
        createdAt,
      ];
}
