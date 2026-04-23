part of 'package:mentorx_core/mentorx_core.dart';

class AIConversationEntity extends Equatable {
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

  AIConversationEntity copyWith({
    String? id,
    String? title,
    String? subject,
    int? messageCount,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AIConversationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      messageCount: messageCount ?? this.messageCount,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
