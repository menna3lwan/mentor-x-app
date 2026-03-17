part of '../../student_core.dart';

base class AIConversationEntity extends Equatable {
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


  static final placeholder = AIConversationEntity(
    id: '',
    messageCount: 0,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

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
