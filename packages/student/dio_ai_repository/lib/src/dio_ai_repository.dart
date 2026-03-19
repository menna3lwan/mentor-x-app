import 'package:student_core/student_core.dart';
import '../models/ai_models.dart';

final class DioAiRepository
    extends HttpClientRepository<AIRepositoryExceptionCode>
    implements AIRepository {
  @override
  Never throwException(AIRepositoryExceptionCode code, {String? message}) =>
      throw AIRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioAiRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<AIConversationEntity>> getConversations({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    final response = await httpClient.get(
      '/api/ai/conversations',
      queryParameters: {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      },
    );

    if (response.statusCode != 200) {
      throw AIRepositoryException(
        code: AIRepositoryExceptionCode.failedToLoadConversations,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => AIConversationModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<AIConversationEntity> createConversation({String? subject}) async {
    final response = await httpClient.post(
      '/api/ai/conversations',
      data: {if (subject != null) 'subject': subject},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw AIRepositoryException(
        code: AIRepositoryExceptionCode.failedToCreateConversation,
        message: response.exception?.message,
      );
    }

    return AIConversationModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<void> deleteConversation(String conversationId) async {
    final response = await httpClient.delete('/api/ai/conversations/$conversationId');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw AIRepositoryException(
        code: AIRepositoryExceptionCode.failedToDeleteConversation,
        message: response.exception?.message,
      );
    }
  }

  @override
  Future<void> renameConversation(String conversationId, String title) async {
    final response = await httpClient.patch(
      '/api/ai/conversations/$conversationId',
      data: {'title': title},
    );

    if (response.statusCode != 200) {
      throw AIRepositoryException(
        code: AIRepositoryExceptionCode.failedToRenameConversation,
        message: response.exception?.message,
      );
    }
  }

  @override
  Future<List<AIMessageEntity>> getMessages(
    String conversationId, {
    MentorXPaginationInfo? paginationInfo,
  }) async {
    final response = await httpClient.get(
      '/api/ai/conversations/$conversationId/messages',
      queryParameters: {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      },
    );

    if (response.statusCode != 200) {
      throw AIRepositoryException(
        code: AIRepositoryExceptionCode.failedToLoadMessages,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => AIMessageModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<AIMessageEntity> sendMessage(
    String conversationId,
    String content,
  ) async {
    final response = await httpClient.post(
      '/api/ai/conversations/$conversationId/messages',
      data: {'content': content},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw AIRepositoryException(
        code: AIRepositoryExceptionCode.failedToSendMessage,
        message: response.exception?.message,
      );
    }

    return AIMessageModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<void> submitFeedback(
    String messageId, {
    int? rating,
    String? feedback,
  }) async {
    final response = await httpClient.post(
      '/api/ai/messages/$messageId/feedback',
      data: {
        if (rating != null) 'rating': rating,
        if (feedback != null) 'feedback': feedback,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw AIRepositoryException(
        code: AIRepositoryExceptionCode.failedToSubmitFeedback,
        message: response.exception?.message,
      );
    }
  }
}
