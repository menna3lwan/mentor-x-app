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
      final queryParams = {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/ai/conversations',
        queryParameters: queryParams,
      );

      final list = response.asList();

      return list.map((e) => AIConversationModel.fromJson(asMap(e))).toList();
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
      final payload = {if (subject != null) 'subject': subject};

      final response = await httpClient.post(
        '/api/ai/conversations',
        data: payload,
      );

      return AIConversationModel.fromJson(response.asMap());
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
      final payload = {'title': title};
      await httpClient.patch(
        '/api/ai/conversations/$conversationId',
        data: payload,
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
      final queryParams = {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/ai/conversations/$conversationId/messages',
        queryParameters: queryParams,
      );

      final list = response.asList();

      return list.map((e) => AIMessageModel.fromJson(asMap(e))).toList();
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
      final payload = {'content': content};

      final response = await httpClient.post(
        '/api/ai/conversations/$conversationId/messages',
        data: payload,
      );

      return AIMessageModel.fromJson(response.asMap());
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
      return response.asMap();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AIRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<void> clearHistory() async {
    try {
      await httpClient.post('/api/ai/clear-history');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: AIRepositoryExceptionCode.unknown,
      );
    }
  }
}
