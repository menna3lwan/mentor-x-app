import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio_rewards_repository/src/dio_rewards_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:student_core/student_core.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late DioRewardsRepository repository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = DioRewardsRepository(httpClient: mockHttpClient);
  });

  group('DioRewardsRepository', () {
    test('getPointsHistory returns list of transactions', () async {
      final mockResponse = {
        'data': [
          {
            'id': 't1',
            'transactionType': 'earn',
            'points': 100,
            'balanceAfter': 500,
            'source': 'Quiz Completion',
            'createdAt': DateTime.now().toIso8601String(),
          }
        ]
      };

      when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getPointsHistory();

      expect(result.length, 1);
      expect(result.first.points, 100);
    });

    test('getRewardItems returns list of items', () async {
      final mockResponse = {
        'data': [
          {
            'id': 'r1',
            'title': 'Gift Card',
            'requiredPoints': 500,
            'isActive': true,
          }
        ]
      };

      when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getRewardItems();

      expect(result.length, 1);
      expect(result.first.title, 'Gift Card');
    });

    test('claimReward returns claim entity on success', () async {
      final mockResponse = {
        'data': {
          'id': 'c1',
          'rewardItemId': 'r1',
          'pointsSpent': 500,
          'status': 'pending',
          'claimedAt': DateTime.now().toIso8601String(),
        }
      };

      when(() => mockHttpClient.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.claimReward('r1');

      expect(result.id, 'c1');
      expect(result.status, RewardClaimStatus.pending);
    });
  });
}
