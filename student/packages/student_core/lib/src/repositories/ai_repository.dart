part of '../../student_core.dart';

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
  /// Fetch paginated AI conversations.
  Future<List<AIConversationEntity>> getConversations({
    int page = 1,
    int limit = 20,
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
    int page = 1,
    int limit = 30,
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
