import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_rewards_repository/dio_rewards_repository.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioRewardsRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioRewardsRepository(httpClient: httpClient);
  });

  group('DioRewardsRepository', () {
    test('getPointsHistory returns list of transactions', () async {
      final mockResponse = HttpClientResponse(
        data: {
          'data': [
            {
              'id': 't1',
              'amount': 100,
              'type': 'credit',
              'reason': 'Bonus',
              'created_at': DateTime.now().toIso8601String(),
            },
          ]
        },
        statusCode: 200,
      );

      when(() => httpClient.get(
            '/api/student/points/history',
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => mockResponse);

      final history = await repository.getPointsHistory();

      expect(history.length, 1);
      expect(history[0].amount, 100);
    });

    test('getRewardItems returns list of items', () async {
      final mockResponse = HttpClientResponse(
        data: {
          'data': [
            {
              'id': 'r1',
              'title': 'Free Course',
              'points_cost': 1000,
            },
          ]
        },
        statusCode: 200,
      );

      when(() => httpClient.get(
            '/api/rewards/items',
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => mockResponse);

      final items = await repository.getRewardItems();

      expect(items.length, 1);
      expect(items[0].title, 'Free Course');
    });

    test('getRewardClaims returns list of claims', () async {
      final mockResponse = HttpClientResponse(
        data: {
          'data': [
            {
              'id': 'c1',
              'reward_item_id': 'r1',
              'status': 'completed',
              'claimed_at': DateTime.now().toIso8601String(),
            },
          ]
        },
        statusCode: 200,
      );

      when(() => httpClient.get(
            '/api/rewards/claims',
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => mockResponse);

      final claims = await repository.getRewardClaims();

      expect(claims.length, 1);
      expect(claims[0].id, 'c1');
    });

    test('claimReward returns claim', () async {
      final mockResponse = HttpClientResponse(
        data: {
          'data': {
            'id': 'c1',
            'reward_item_id': 'r1',
            'status': 'pending',
            'claimed_at': DateTime.now().toIso8601String(),
          }
        },
        statusCode: 200,
      );

      when(() => httpClient.post(
            '/api/rewards/claims',
            data: any(named: 'data'),
          )).thenAnswer((_) async => mockResponse);

      final claim = await repository.claimReward('r1');

      expect(claim.id, 'c1');
    });
  });
}
