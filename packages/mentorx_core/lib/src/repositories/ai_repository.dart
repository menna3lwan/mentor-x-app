part of '../../mentorx_core.dart';

enum AIRepositoryExceptionCode {
  unknown,
  failedToLoadConversations,
  failedToCreateConversation,
  failedToDeleteConversation,
  failedToRenameConversation,
  failedToLoadMessages,
  failedToSendMessage,
  failedToSubmitFeedback,
}

final class AIRepositoryException
    extends MentorXException<AIRepositoryExceptionCode> {
  const AIRepositoryException({required super.code, super.message});
}

abstract interface class AIRepository {
  Future<void> initialize();

  /// Fetch paginated AI conversations.
  Future<List<AIConversationEntity>> getConversations({
    MentorXPaginationInfo? paginationInfo,
  });

  /// Create a new AI conversation.
  Future<AIConversationEntity> createConversation({String? subject});

  /// Soft-delete a conversation.
  Future<void> deleteConversation(String conversationId);

  /// Rename a conversation.
  Future<void> renameConversation(String conversationId, String title);

  /// Fetch messages for a conversation.
  Future<List<AIMessageEntity>> getMessages(
    String conversationId, {
    MentorXPaginationInfo? paginationInfo,
  });

  /// Send a message and receive AI response.
  Future<AIMessageEntity> sendMessage(
    String conversationId,
    String content,
  );

  /// Submit feedback on a message.
  Future<void> submitFeedback(
    String messageId, {
    int? rating,
    String? feedback,
  });
}
