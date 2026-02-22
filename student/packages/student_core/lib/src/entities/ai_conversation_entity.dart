part of '../../student_core.dart';

final class AIConversationEntity extends Equatable {
  final String id;
  final String? title;
  final String? subject;
  final int messageCount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AIConversationEntity({
    required this.id,
    required this.messageCount,
    required this.createdAt,
    required this.updatedAt,
    this.title,
    this.subject,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subject,
        messageCount,
        isActive,
        createdAt,
        updatedAt,
      ];
}
