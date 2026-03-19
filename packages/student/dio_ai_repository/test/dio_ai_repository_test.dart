import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio_ai_repository/src/dio_ai_repository.dart';
import 'package:student_core/student_core.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late DioAiRepository repository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = DioAiRepository(httpClient: mockHttpClient);
  });

  group('DioAiRepository', () {
    test('getConversations returns list of conversations', () async {
      final mockResponse = {
        'data': [
          {
            'id': 'c1',
            'title': 'AI Chat',
            'messageCount': 2,
            'createdAt': DateTime.now().toIso8601String(),
            'updatedAt': DateTime.now().toIso8601String(),
          }
        ]
      };

      when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getConversations();

      expect(result.length, 1);
      expect(result.first.title, 'AI Chat');
    });

    test('getMessages returns list of messages', () async {
      final mockResponse = {
        'data': [
          {
            'id': 'm1',
            'conversationId': 'c1',
            'role': 'user',
            'content': 'Hello AI',
            'createdAt': DateTime.now().toIso8601String(),
          }
        ]
      };

      when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getMessages('c1');

      expect(result.length, 1);
      expect(result.first.content, 'Hello AI');
    });

    test('sendMessage returns assistant message', () async {
      final mockResponse = {
        'data': {
          'id': 'm2',
          'conversationId': 'c1',
          'role': 'assistant',
          'content': 'Hello Student',
          'createdAt': DateTime.now().toIso8601String(),
        }
      };

      when(() => mockHttpClient.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.sendMessage('c1', 'Hello AI');

      expect(result.role, AIMessageRole.assistant);
      expect(result.content, 'Hello Student');
    });
  });
}
