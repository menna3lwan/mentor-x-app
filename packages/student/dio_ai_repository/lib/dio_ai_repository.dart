import 'package:mentorx_core/mentorx_core.dart';
import 'models/ai_models.dart';
export 'models/ai_models.dart';

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
    try {
      final response = await httpClient.get(
        '/api/ai/conversations',
        queryParameters: {
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final data = asList(asMap(response.data)['data'] ?? asMap(response.data)['content'] ?? response.data);
      return data.map((e) => AIConversationModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AIRepositoryExceptionCode.failedToLoadConversations,
      );
    }
  }

  @override
  Future<AIConversationEntity> createConversation({String? subject}) async {
    try {
      final response = await httpClient.post(
        '/api/ai/conversations',
        data: {if (subject != null) 'subject': subject},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return AIConversationModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AIRepositoryExceptionCode.failedToCreateConversation,
      );
    }
  }

  @override
  Future<void> deleteConversation(String conversationId) async {
    try {
      await httpClient.delete('/api/ai/conversations/$conversationId');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: AIRepositoryExceptionCode.failedToDeleteConversation,
      );
    }
  }

  @override
  Future<void> renameConversation(String conversationId, String title) async {
    try {
      await httpClient.patch(
        '/api/ai/conversations/$conversationId',
        data: {'title': title},
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: AIRepositoryExceptionCode.failedToRenameConversation,
      );
    }
  }

  @override
  Future<List<AIMessageEntity>> getMessages(
    String conversationId, {
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/ai/conversations/$conversationId/messages',
        queryParameters: {
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final data = asList(asMap(response.data)['data'] ?? asMap(response.data)['content'] ?? response.data);
      return data.map((e) => AIMessageModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AIRepositoryExceptionCode.failedToLoadMessages,
      );
    }
  }

  @override
  Future<AIMessageEntity> sendMessage(
    String conversationId,
    String content,
  ) async {
    try {
      final response = await httpClient.post(
        '/api/ai/conversations/$conversationId/messages',
        data: {'content': content},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return AIMessageModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AIRepositoryExceptionCode.failedToSendMessage,
      );
    }
  }

  @override
  Future<void> submitFeedback(
    String messageId, {
    int? rating,
    String? feedback,
  }) async {
    try {
      await httpClient.post(
        '/api/ai/messages/$messageId/feedback',
        data: {
          if (rating != null) 'rating': rating,
          if (feedback != null) 'feedback': feedback,
        },
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: AIRepositoryExceptionCode.failedToSubmitFeedback,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getStats() async {
    try {
      final response = await httpClient.get('/api/ai/stats');
      return asMap(response.data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(e, defaultCode: AIRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<void> clearHistory() async {
    try {
      await httpClient.post('/api/ai/clear-history');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: AIRepositoryExceptionCode.unknown);
    }
  }
}
