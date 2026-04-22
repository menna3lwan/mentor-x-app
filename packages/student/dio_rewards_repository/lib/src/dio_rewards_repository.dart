import 'package:mentorx_core/mentorx_core.dart';
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
  Future<void> initialize() async {}

  @override
  Future<List<PointsTransactionEntity>> getPointsHistory({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/student/points/history',
        queryParameters: {
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final data = asList(response.data);
      return data.map((e) => PointsTransactionModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: RewardsRepositoryExceptionCode.failedToLoadPointsHistory,
      );
    }
  }

  @override
  Future<List<RewardItemEntity>> getRewardItems({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/rewards/items',
        queryParameters: {
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final data = asList(response.data);
      return data.map((e) => RewardItemModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: RewardsRepositoryExceptionCode.failedToLoadRewardItems,
      );
    }
  }

  @override
  Future<List<RewardClaimEntity>> getRewardClaims({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/rewards/claims',
        queryParameters: {
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final data = asList(response.data);
      return data.map((e) => RewardClaimModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: RewardsRepositoryExceptionCode.failedToLoadClaims,
      );
    }
  }

  @override
  Future<RewardClaimEntity> claimReward(String rewardItemId) async {
    try {
      final response = await httpClient.post(
        '/api/rewards/claims',
        data: {'reward_item_id': rewardItemId},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return RewardClaimModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: RewardsRepositoryExceptionCode.failedToClaimReward,
      );
    }
  }

}
