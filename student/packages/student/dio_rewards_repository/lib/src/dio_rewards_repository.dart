import 'package:mentorx_core/mentorx_core.dart';
import 'package:student_core/student_core.dart';
import '../models/rewards_models.dart';

final class DioRewardsRepository
    extends HttpClientRepository<RewardsRepositoryExceptionCode>
    implements RewardsRepository {
  @override
  Never throwException(RewardsRepositoryExceptionCode code, {String? message}) =>
      throw RewardsRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioRewardsRepository({required this.httpClient});

  @override
  Future<List<PointsTransactionEntity>> getPointsHistory({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await httpClient.get(
      '/api/student/points/history',
      queryParameters: {'page': page, 'limit': limit},
    );

    if (response.statusCode != 200) {
      throw RewardsRepositoryException(
        code: RewardsRepositoryExceptionCode.failedToLoadPointsHistory,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => PointsTransactionModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<List<RewardItemEntity>> getRewardItems({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await httpClient.get(
      '/api/rewards/items',
      queryParameters: {'page': page, 'limit': limit},
    );

    if (response.statusCode != 200) {
      throw RewardsRepositoryException(
        code: RewardsRepositoryExceptionCode.failedToLoadRewardItems,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => RewardItemModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<List<RewardClaimEntity>> getRewardClaims({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await httpClient.get(
      '/api/rewards/claims',
      queryParameters: {'page': page, 'limit': limit},
    );

    if (response.statusCode != 200) {
      throw RewardsRepositoryException(
        code: RewardsRepositoryExceptionCode.failedToLoadClaims,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => RewardClaimModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<RewardClaimEntity> claimReward(String rewardItemId) async {
    final response = await httpClient.post(
      '/api/rewards/claims',
      data: {'reward_item_id': rewardItemId},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw RewardsRepositoryException(
        code: RewardsRepositoryExceptionCode.failedToClaimReward,
        message: response.exception?.message,
      );
    }

    return RewardClaimModel.fromJson(response.data['data'] ?? response.data);
  }
}
